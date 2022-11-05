#!/bin/bash
set -x
USER=$1
Key_path=$2
touch  storefile
echo "" > storefile
IP=$(terraform output -json private-ip | jq -s -r '.[]')
echo $IP >> storefile
IP=$(terraform output -json private-ip-backend1 | jq -s -r '.[]')
echo $IP >> storefile
IP=$(terraform output -json private-ip-Haproxy_backend2 | jq -s -r '.[]')
echo $IP >> storefile
 touch Invnetory 
 echo "" > Invnetory
 echo "[seed-nodes]" > Invnetory
 for line in $(cat storefile)
 do
     y=$(echo "${line}") 
     IP=$(echo $y | awk -F, '{print $1}')
    echo "node${j} ansible_host=${line} ansible_user=${USER} ansible_ssh_private_key_file=${Key_path} ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> Invnetory 
     ((j++))
     ((i++))
 done
 cat Invnetory
rm storefile
