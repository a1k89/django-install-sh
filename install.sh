#!/bin/bash
base_python_interpretator = ''
main_dir = ''
project_dir = ''
domain_or_ip = ''

read -p "Enter python interpretator " : base_python_interpreter
read -p "Enter domain or ip " : domain_or_ip
read -p "Enter main directory (root directory)" : main_dir
read -p "Enter project directory (where project located) " : project_dir


cd $main_dir
`$base_python_interpretator -m venv ienv`
source ienv/bin/activate

cd $project_dir
pip install --upgrade pip
pip install -r requirements.txt

cd $main_dir
mkdir -p "logs"

sed -i "s~{/project_dir/}~$project_dir~g" templates/supervisor/core.conf
sed -i "s~path_to_logs~$main_dir~g" templates/supervisor/core.conf

sed -i "s~{domain_or_ip}~$domain_or_ip~g" templates/nginx/main.conf


sed -i "s~{main_dir}~$main_dir~g" templates/supervisor/celery.conf
sed -i "s~{project_dir}~$project_dir~g" templates/supervisor/celery.conf
