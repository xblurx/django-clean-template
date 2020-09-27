#!/bin/bash
base_python_interpreter=""
project_domain=""
project_path=`pwd`

read -p "Python interpreter: " base_python_interpreter
read -p "Your domain without protocol (for example, google.com): " project_domain
`$base_python_interpreter -m venv venv`
source venv/bin/activate

pip install wheels/setuptools-50.3.0-py3-none-any.whl
pip install wheels/sqlparse-0.3.1-py2.py3-none-any.whl
pip install wheels/pytz-2020.1-py2.py3-none-any.whl
pip install wheels/Django-2.2.5-py3-none-any.whl
pip install wheels/gunicorn-20.0.4-py2.py3-none-any.whl

sed -i "s~dbms_template_path~$project_path~g" nginx/site.conf systemd/gunicorn.service
sed -i "s~dbms_template_domain~$project_domain~g" nginx/site.conf src/config/settings.py

sudo ln -s $project_path/nginx/site.conf /etc/nginx/sites-enabled/
sudo ln -s $project_path/systemd/gunicorn.service /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl start gunicorn
sudo systemctl enable gunicorn
sudo service nginx restart
