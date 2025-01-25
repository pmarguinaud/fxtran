#!/bin/bash


set -x
set -e

unset LANG
unset LC_ALL
unset LANGUAGE

EMAIL=pmarguinaud@hotmail.com
NAME="Philippe Marguinaud"
DEBIAN=debian:unstable

sudo docker pull $DEBIAN

if [ ! -f "$HOME/.ssh/known_hosts" ]
then
  touch "$HOME/.ssh/known_hosts" 
fi

if [ ! -f "$HOME/.ssh/id_rsa" ]
then
  ssh-keygen -b 2048 -t rsa -f "$HOME/.ssh/id_rsa" -q -N ""
fi

SSHKEY=$(cat $HOME/.ssh/id_rsa.pub)
SHARED=$PWD/../$DEBIAN
TIMEZONE=$(cat /etc/timezone)

\rm -rf $SHARED
mkdir -p $SHARED

mkdir -p $SHARED/.ssh
cat > $SHARED/.ssh/authorized_keys << EOF
$SSHKEY
EOF

chmod 600 $SHARED/.ssh/authorized_keys

cat -> $SHARED/.bash_profile << EOF

export EMAIL=$EMAIL
unset LANG

set -o vi

EOF

cat -> $SHARED/.vimrc << EOF
:set mouse=
:set hlsearch
EOF

cat > $SHARED/fxtran-boot.sh << EOF
#!/bin/bash

set -x
set -e

export DEBIAN_FRONTEND=noninteractive

dir=\$(dirname \$0)

cd \$dir

ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime 
echo $TIMEZONE > /etc/timezone

apt-get -y update 
apt-get -y dist-upgrade
apt-get -y install git vim ssh screen sudo
apt-get -y install debhelper-compat
apt-get -y install g++ make build-essential debhelper dpkg-dev \
  python3-dev python3-setuptools dh-exec python3-pip devscripts lintian

cat > /etc/apt/sources.list.d/fxtran.list << EOC
deb [trusted=yes] file:/home/$USER /
EOC

echo 'X11UseLocalhost no' >> /etc/ssh/sshd_config

service ssh start

useradd $USER
chsh -s /bin/bash $USER

cat >> /etc/sudoers << EOC

$USER ALL=(root) NOPASSWD: /usr/bin/dpkg, NOPASSWD: /usr/bin/apt, NOPASSWD: /usr/bin/apt-get, NOPASSWD: /usr/bin/dpkg, NOPASSWD: /bin/su
EOC

EOF

chmod 755 $SHARED/fxtran-boot.sh 

sudo docker \
  run -h fxtran_build -t -d \
  --name fxtran_build \
  --mount type=bind,src=$SHARED/,dst=/home/$USER \
  --mount type=bind,src=$PWD/,dst=/home/$USER/fxtran \
  $DEBIAN

sudo docker exec fxtran_build /home/$USER/fxtran-boot.sh 

IP=$(sudo docker inspect -f "{{ .NetworkSettings.IPAddress }}" fxtran_build)
ssh-keygen -f "$HOME/.ssh/known_hosts" -R ${IP}

echo "${IP}" > fxtran_build.txt

cat > $SHARED/fxtran-build.sh << EOF
#!/bin/bash

set -x
set -e

git config --global user.email "$EMAIL"
git config --global user.name "$NAME"
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'

cd fxtran

./scripts/debian/tar.pl
debuild -us -uc

cd ..

dpkg-scanpackages -m . > Packages

sudo apt-get update

EOF
 
chmod 755 $SHARED/fxtran-build.sh 



