#! /usr/bin/bash

cd ansible

ansible-playbook dat151_lab.yml --become-password-file .sudo_password
