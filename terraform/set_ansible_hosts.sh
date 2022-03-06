#!/bin/bash

# get list of created servers from terraform
servers=$(terraform state list)

for vm in ${servers[@]}; do

  echo $vm
# get name and public_ip from terraform
  name=$(terraform state show $vm | grep "Name" | awk '{print $3}' | head -1)

  pub_ip=$(terraform state show $vm | grep public_ip | awk '/"/ {print $3}')
  pub_ip=${pub_ip:1:-1}   # remove "" from around ip

  all_servers+=("${pub_ip} ansible_user=ec2-user ansible_python_interpreter=/usr/bin/python")

  if [[ "$name" == *"db"* ]]
    then db_servers+=("${pub_ip} ansible_user=ec2-user ansible_python_interpreter=/usr/bin/python")
  fi


  if [[ "$name" == *"wa"* ]]
    then web_app_servers+=("${pub_ip} ansible_user=ec2-user ansible_python_interpreter=/usr/bin/python")
  fi


  if [[ "$name" == *"tst"* ]]
    then tst_servers+=("${pub_ip} ansible_user=ec2-user ansible_python_interpreter=/usr/bin/python")
  fi


  if [[ "$name" == *"stg"* ]]
    then stg_servers+=("${pub_ip} ansible_user=ec2-user ansible_python_interpreter=/usr/bin/python")
  fi


  if [[ "$name" == *"prd"* ]]
    then prd_servers+=("${pub_ip} ansible_user=ec2-user ansible_python_interpreter=/usr/bin/python")
  fi

done # end of for loop

printf "%s\n" "${all_servers[@]}" | sudo tee -a /etc/ansible/hosts
printf "%s\n" "${db_servers[@]}"  | sudo tee -a  /etc/ansible/hosts
printf "%s\n" "${web_app_servers[@]}" | sudo tee -a  /etc/ansible/hosts
printf "%s\n" "${tst_servers[@]}" | sudo tee -a  /etc/ansible/hosts
printf "%s\n" "${stg_servers[@]}" | sudo tee -a  /etc/ansible/hosts
printf "%s\n" "${prd_servers[@]}" | sudo tee -a  /etc/ansible/hosts
