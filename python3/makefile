TOP=..

all: build

# Debian takes the dependencies from debian/control, not from PyPI
install:
	pip3 install --upgrade --no-deps -t $(TOP)/debian/tmp/usr/lib/python3/dist-packages/ -r requirements.txt  .

build:
	python3 setup.py build

# The tests find xml_libxml and xpath_parser installed, in PYTHONPATH, or next to
# this repository (../python-libxml2, ../python-xpath_parser)
test:
	python3 setup.py build_ext --inplace
	python3 -m pytest t

clean:
	\rm -rf build dist *.egg-info _fxtran*.so

