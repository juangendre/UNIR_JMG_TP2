#!/bin/bash

#*************************************************
#
#--------------------------------------------------
export ANSIBLE_HOST_KEY_CHECKING=False

ansible-playbook -i hosts -l workers pb_workers.yaml -v