#!/bin/bash

set -x
set -e 

sudo docker stop ubuntu_fxtran
sudo docker rm ubuntu_fxtran 
sudo docker image rm ubuntu:latest 
