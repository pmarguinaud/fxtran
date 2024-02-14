#!/bin/bash

set -x
set -e 

sudo docker stop fxtran_build
sudo docker rm fxtran_build
sudo docker image rm debian:unstable
