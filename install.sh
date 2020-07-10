#!/bin/bash
sudo su
yum -y install httpd
echo "<p> My Instance! </p>" >> /var/www/html/index.html
sudo systemctl enable httpd
sudo systemctl start httpd

sudo yum install python37 -y

curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user


