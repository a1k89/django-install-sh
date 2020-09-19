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

path_to_logs=$main_dir

cd $main_dir
`$base_python_interpretator -m venv ienv`

source ienv/bin/activate

cd $project_dir
pip install --upgrade pip
pip install -r requirements.txt

cd $main_dir
mkdir -p "logs"

cd $install_dir

sed -i "s~{project_dir}~$project_dir~g" /templates/supervisor/core.conf
sed -i "s~{path_to_logs}~$path_to_logs~g" /templates/supervisor/core.conf

sed -i "s~{domain_or_ip}~$domain_or_ip~g" /templates/nginx/main.conf
sed -i "s~{user}~$user~g" /templates/nginx/main.conf

sed -i "s~{main_dir}~$main_dir~g" /templates/supervisor/celery.conf
sed -i "s~{project_dir}~$project_dir~g" /templates/supervisor/celery.conf
 
sudo ln -s $install_dir/templates/nginx/main.conf /etc/nginx/sites-enabled/
sudo ln -s $install_dir/templates/supervisor/core.conf /etc/supervisor/conf.d/
sudo ln -s $install_dir/templates/supervisor/celery.conf /etc/supervisor/conf.d/

sudo supervisorctl reread
sudo supervisorctl update
sudo supervisorctl restart all

sudo service nginx restart
