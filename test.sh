#!/bin/bash

echo What is your project name?

read project

#project_path="V:/kepler/workspace/jovt_$project"
#echo $project_path
#cd $project_path

#echo Hello, $project developer!

branch_nm="$(git symbolic-ref --short HEAD)"
previous_tag="$(git describe --match "$branch_nm*" --abbrev=0 --tags $(git rev-list --tags --skip=1 --max-count=1))"
current_tag="$(git describe --tags --abbrev=0 HEAD)"
echo branch_nm is $branch_nm
echo $previous_tag
echo $current_tag

name="[$previous_tag]To[$current_tag]"
if [ "$previous_tag" = "$current_tag" ]; then
  name="[$previous_tag]"
  current_tag="$(git describe --tags)"
fi

if [ -z "$previous_tag" ]; then
echo "Previous is null"
fi

if [ -z "$current_tag" ]; then
echo "current_tag is null"
fi
#echo "$name"

git archive -o V:/htdocs_Update_$name.zip HEAD $(git diff --diff-filter=AMR --name-only $previous_tag..$current_tag -- ':!*etc/*')

git diff --diff-filter=AMR --name-status $previous_tag..$current_tag -- ':!*etc/*' >> V:/update_list_"$name".txt

git diff --diff-filter=AMR --name-status $previous_tag..$current_tag -- ':!*etc/*' '*.java' >> V:/update_java_list_"$name".txt

cd V:/
start .