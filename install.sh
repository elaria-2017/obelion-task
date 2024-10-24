#!/bin/bash
apt-get update -y
apt-get install -y  awscli git docker.io
systemctl enable docker
systemctl start docker