#!/bin/bash 

#
# Constant declarations
#
readonly INPUT_ERROR=2

#
# Shortcut function which generates an ssh key 
# under the directory ~/.ssh/ with rsa and:
# - ($1) a given email
# - ($2) a given filename
#
generate_key() 
{
  if [ -z "$1" ]
  then
    echo "You must specify an email as first argument"
    return INPUT_ERROR
  fi

  if [ -z "$2" ]
  then
    echo "You must specify the file name as second argument"
    return INPUT_ERROR
  fi
  
  # Generate key with provided name
  ssh-keygen -t rsa -b 4096 -C $1 -f ~/.ssh/$2

  # Add key to ssh-agent
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/$2
}

#
# Remove all local branches with a different name 
# from the one provided in input ($1)
#
remove_branches_but() 
{
  if [ -z "$1" ]
  then
    echo "You must specify the branch to keep"
    return INPUT_ERROR
  fi

  git branch | grep -v '*' | grep -vw "$1" | xargs git branch -D
}

