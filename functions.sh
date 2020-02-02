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
  if [ -z "$1" ] || [ -z "$2" ]
  then
    echo -e "
      You must specify an email as first argument and the name of the file as second argument.
      generate_key [mail_address] [key_name]
      Example: generate_key hello@mail.com key1
      " 
    return 0
  fi

  
  # Generate key with provided name
  ssh-keygen -t rsa -b 4096 -C $1 -f ~/.ssh/$2

  # Add key to ssh-agent
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/$2

  echo -e "Generated key: $HOME/.ssh/$2: \n"
  cat ~/.ssh/$2
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

