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

