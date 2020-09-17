#!/usr/bin/env bash
set -e

# Initialize Git repo
git init

# Create Python virtual environment and install Python requirements
if [ ! -d "venv" ]; then
    python3 -m venv venv
    source venv/bin/activate
    pip3 install --upgrade pip pip-tools
fi

# Compile Python production requirements
printf "Setting up Python requirements\n"
if [ -f "requirements.in" ]; then
    printf "Compiling Python production requirements\n"
    pip-compile
fi

# Compile Python development requirements
if [ -f "requirements-dev.in" ]; then
    printf "Compiling Python development requirements\n"
    pip-compile requirements-dev.in
fi

pip-sync requirements.txt requirements-dev.txt

# Make first Git commit
git add .
git config user.email "{{ cookiecutter.email }}"
git config user.name "{{ cookiecutter.author }}"
git commit -n -m "First commit using Cookiecutter Template"
