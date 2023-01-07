#!/usr/bin/env bash

branches=(
  "02-add-remix-app"
  "03-add-shared-ui"
  "04-reuse-button"
  "05-add-nx"
  "06-configure-caching"
  "07-custom-cache-output"
  "08-fine-tune-cache-inputs"
  "09-named-inputs"
  "10-task-pipelines"
  "11-affected-commands"
  "12-nx-cloud"
  "main"
) 
for branch in ${branches[@]}; 
do
    echo $branch
    git checkout -b "$branch" juristr/"$branch"
    git push -u origin "$branch"
done

