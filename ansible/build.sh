#!/bin/sh


export ANSIBLE_HOST_KEY_CHECKING=False
#------------------------------------------------------------
###     ANSIBLE
echo "-----------------------------------------------------------------" 
echo "---------------------------ANSIBLE-------------------------------" 
#ssh-keyscan $var_def_hosts_mi $var_def_hosts_w1i $var_def_hosts_w2i $var_def_hosts_nfsi

#----------------------------------------------------------------------
#
#   SE CORREN LOS PRE-REQUISITOS PARA TODOS LOS NODOS.
#
#----------------------------------------------------------------------


sh run_master.sh
sh run_workers.sh
sh run_nfs.sh
sh run_jenkins.sh


