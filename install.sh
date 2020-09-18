#!/bin/bash

install_dir=`pwd`
base_python_interpretator=''
main_dir=''
project_dir=''
domain_or_ip=''
user=''

read -p "Enter python interpretator: "  base_python_interpretator
read -p "Enter domain or ip: " domain_or_ip
read -p "Enter main directory (root directory): " main_dir
read -p "Enter project directory (where project located): " project_dir
read -p "User: " user


cd $main_dir
`$base_python_interpretator -m venv ienv`

source ienv/bin/activate

cd $project_dir
pip install --upgrade pip
pip install -r requirements.txt

cd $main_dir
mkdir -p "logs"



sudo supervisorctl reread
sudo supervisorctl update
sudo supervisorctl restart all

sudo service nginx restart
