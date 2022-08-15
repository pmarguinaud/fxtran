#!/bin/bash


set -x
set -e

if [ 1 -eq 1 ]
then
sudo docker pull ubuntu:latest

cat > fxtran.sh << EOF
#!/bin/bash

set -x
set -e

dir=\$(dirname \$0)

cd \$dir

apt-get -y update 
apt-get -y dist-upgrade

apt-get -y install ./fxtran_1-0_amd64.deb
apt-get -y install ./libfxtran-perl_1-0_amd64.deb
apt-get -y install ./python-fxtran_1-0_amd64.deb

/usr/bin/fxtran -help
perl -e ' use fxtran;  print &fxtran::run ("END\n") ' 
python2.7 -c 'import fxtran;  print (fxtran.run ("END\n")) '

EOF

chmod +x fxtran.sh

sudo docker run -t -d --name ubuntu_fxtran \
  --mount type=bind,src=$PWD/,dst=/root/fxtran,readonly=true \
  ubuntu:latest

sudo docker exec ubuntu_fxtran /root/fxtran/fxtran.sh

fi
