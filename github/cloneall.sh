#!/bin/bash
#requires jq -> http://stedolan.github.io/jq/

#optional change working_dir
working_dir=${1-$(pwd)}
cd $working_dir

USER="luciotbc"


REPO_LIST=$(curl https://api.github.com/users/$USER/repos?per_page=100 | jq .[].ssh_url | sed -e 's/^"//'  -e 's/"$//')

for REPO in $REPO_LIST; do

  echo "Repo found: $REPO"

  REPO_PATH=$(echo $REPO | awk -F'/' '{print $NF}' | awk -F'.' '{print $1}')
  echo "Repo path: $REPO_PATH"

  if [ ! -d "$REPO_PATH" ]; then
    echo "git clone $REPO_PATH"
    git clone "$REPO" "$REPO_PATH"
  else
    echo "git pull $REPO_PATH"
    (cd "$REPO_PATH" && git pull)
  fi
done
