#!/bin/bash

# filename=$dir"release.txt"
# if [ ! -f $filename ]
# then
# echo "$filename does not exist"
#     touch $filename
#     echo "App_version : 1.0.1
# Latest_commit: 7ef9d5d" > release.txt
# else
# echo "$filename   exist"
# ls -ltra $filename
# fi




filename=$dir"release.txt"
if [ ! -f $filename ]
then
echo "$filename does not exist"
    touch $filename
    echo "App_version : 1.0.1
Latest_commit: 7ef9d5d" > release.txt
else
readarray -t a <  $filename
IFS=$'\n' read -d '' -r -a lines < $filename 

arrlines=(${lines[1]//:/ })
echo ${arrlines[1]}

fi

declare -a changed_paths

latest_commit=$(git log --pretty=format:'%h' -n 1)

        if [ "${latest_commit}" = "" ]; then
          echo "No changes found."
          exit;
        else
          echo "$(latest_commit)"
        fi

readarray -t changed_paths < <(dirname ${latest_commit})



        echo ${changed_paths}




# current_commit=$(echo ${arrlines[1]})
# latest_commit=$(git log --pretty=format:'%h' -n 1)




# for i in "${lines[1]}"; do

# done

# readarray -t StringArray <<<"$filename"

# for val in "${StringArray[@]}"; do



# for file in "${@}release.txt"
# do
# if [ ! -e "$file" ] ; then
#     touch "$file"
# fi

# if [ ! -w "$file" ] ; then
#     echo cannot write to $file
#     exit 1
# fi
# done