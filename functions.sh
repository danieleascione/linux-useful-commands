#!/bin/bash 

generate_key() 
{
  if [ -z "$1" ]
  then
    echo "You must specify an email as first argument"
    exit 0
  fi
  
  ssh-keygen -t rsa -b 4096 -C $1
}







