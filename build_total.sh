#!/bin/sh
#----------------------------------------------------------#
# SCRIPT para aprovisionar infraestructura
# Actualizado por: Juan Martin Gutierrez
# Fecha: 13/03/2022
#----------------------------------------------------------#

#-----------------------------------------------------------
#------            Variables Iniciales               -------
#-----------------------------------------------------------

    DIR_TRABAJO=`pwd`
    DIR_LOG="$DIR_TRABAJO/log"
    strFecha=`date "+%Y%m%d%H%M%S"` ; export strFecha 
    flLog="$DIR_LOG/build_${strFecha}.txt"
    
    var_master_pub=""   ; export var_master_pub
    var_worker_pub_1="" ; export var_worker_pub_1
    var_worker_pub_2="" ; export var_worker_pub_2
    var_nfs_pub=""      ; export var_nfs_pub

    var_def_hosts_mi="master.terra.ip"
    var_def_hosts_w1i="worker1.terra.ip"
    #var_def_hosts_w2i="worker2.terra.ip"
    var_def_hosts_nfsi="nfs.terra.ip"
    
     var_File="/etc/hosts"
     var_etc_ansible="$DIR_TRABAJO/ansible/hosts"
     var_hosts_ansible="$DIR_TRABAJO/ansible/group_vars/vars_host.yaml"

     
     
#-----------------------------------------------------------
#------------------------------------------------------------
###     FUNCIONES
cambiar_hosts () {
  sudo sed -i "/$1/ s/.*/$2\t$1/g" /etc/hosts
}

verificar_etc () {
    if ! grep -q $1 "$2"; then
    sudo echo -e -n "\n $3  $1" >> $2
    else
    echo "YA EXISTE EL HOST:$1 EN EL ARCHIVO $2"
    fi
}

set_vars_public_ip () {
    var_master_pub=`terraform output -json master_public_ip | sed -e 's/^.//' -e 's/.$//'`
    var_worker_pub_1=`terraform output -json worker1_public_ip | sed -e 's/^.//' -e 's/.$//'`
    #var_worker_pub_2=`terraform output -json worker2_public_ip | sed -e 's/^.//' -e 's/.$//'`
    var_nfs_pub=`terraform output -json nfs_public_ip | sed -e 's/^.//' -e 's/.$//'`
}

ver_todo () {
    verificar_etc $var_def_hosts_mi $var_File $var_generic_ip
    verificar_etc $var_def_hosts_w1i $var_File $var_generic_ip
    #verificar_etc $var_def_hosts_w2i $var_File $var_generic_ip
    verificar_etc $var_def_hosts_nfsi $var_File $var_generic_ip
}

cambia_ips () {
    cambiar_hosts $var_def_hosts_mi $var_master_pub
    cambiar_hosts $var_def_hosts_w1i $var_worker_pub_1
    #cambiar_hosts $var_def_hosts_w2i $var_worker_pub_2
    cambiar_hosts $var_def_hosts_mi $var_nfs_pub
}


fn_cambio_hosts () {
    set_vars_public_ip
    ver_todo
    cambia_ips
}

fn_change_ips_prepare_hosts () {
    cat <<EOF > $var_hosts_ansible
var_hosts:
  - name: master
    ip: $1
    name_long: master.terra.ip
    
  - name: worker1
    ip: $2
    name_long: worker1.terra.ip

  - name: nfs
    ip: $3
    name_long: nfs.terra.ip

EOF
}

fn_change_gral_hosts () {
    cat <<EOF > $DIR_TRABAJO/ansible/hosts
[all:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_user=juangendre

[master]
$1

[workers]
$2


[nfs]
$3

[allnodes]
$1
$2
$3


EOF
}


#------------------------------------------------------------




echo $flLog
mkdir $DIR_LOG
echo "INICIO DEL BUILD EN EL SERVIDOR ${HOSTNAME}" &>> $flLog
echo "-----------------------------------------------------------------" &>> $flLog


#------------------------------------------------------------
###     TERRAFORM
echo "HOSTNAME" &>> $flLog
hostname &>> $flLog
cd $DIR_TRABAJO/terraform
echo "-----------------------------------------------------------------" &>> $flLog
echo "---------------------------TERRAFORM-----------------------------" &>> $flLog
echo "---------------------------INIT----------------------------------" &>> $flLog
terraform init &>> $flLog
echo "---------------------------PLAN----------------------------------" &>> $flLog
terraform plan &>> $flLog
echo "---------------------------BUILD---------------------------------" &>> $flLog
terraform apply -auto-approve
echo "---------------------------CAMBIO ARCHIVO /ETC/HOSTS-------------" &>> $flLog
fn_cambio_hosts
#cat /etc/hosts &>> $flLog
echo "-----------------------------------------------------------------" &>> $flLog
echo "---------------------------FIN TERRAFORM-------------------------" &>> $flLog

echo "---------------------------CAMBIO ARCHIVO /ANSIBLE/HOSTS---------" &>> $flLog

fn_change_gral_hosts $var_master_pub $var_worker_pub_1  $var_nfs_pub

fn_change_ips_prepare_hosts $var_master_pub $var_worker_pub_1 $var_nfs_pub


#------------------------------------------------------------
###     ANSIBLE
echo "-----------------------------------------------------------------" &>> $flLog
echo "---------------------------ANSIBLE-------------------------------" &>> $flLog
#ssh-keyscan $var_def_hosts_mi $var_def_hosts_w1i $var_def_hosts_w2i $var_def_hosts_nfsi
cd $DIR_TRABAJO/ansible

sh build.sh

echo "-----------------------------------------------------------------" &>> $flLog
echo "---------------------------FINALIZA EL DEPLOY--------------------" &>> $flLog
