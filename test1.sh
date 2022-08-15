filename=$dir"release.txt"
version="$(grep 'App_version :' $filename | sed 's/^.*: //')"
commit="$(grep 'Latest_commit:' $filename | sed 's/^.*: //')"

if git checkout master &&
    git fetch origin master &&
    [ `git rev-list HEAD...origin/master --count` != 0 ] &&
    git merge origin/master
then
    echo 'Updated!'
else
    echo 'Not updated.'
fi

git status
git fetch
git config --global user.name "linuxgirl20"
git config --global user.email "aidaliko3@gmail.com"
  if git merge-base --is-ancestor origin/master;then
   echo "no commits "
  else
   git pull
   new_commit="$(git rev-parse HEAD | cut -c 1-7)"
   docker build -t 123456odi/todo-app:$new_commit .
   docker push 123456odi/todo-app:$new_commit
   helm upgrade app --install ./app/charts --set-string image.tag=$new_commit 

file_has_been_modified () {
  if [ ! -f $1 ]; then
    return 1
  fi

  for f in `git ls-files --modified`; do
    [[ "$f" == "$1" ]] && return 0
  done

  return 1
}

git fetch --tags
latestTag=$(git describe --tags `git rev-list --tags --max-count=1`)

git config --global user.name "linuxgirl20"
git config --global user.email "aidaliko3@gmail.com"

read -e -p "Are you sure you want to release? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo -e "Release.."
  echo
  git add . 
  git commit -m "Build version $version"
  git tag -a v $version -m "Version $version"
  git push origin master
  git push --tags

  npm publish
else
  echo -e "Cancelling the release"
fi


filename=$dir"release.txt"
if [ ! -f $filename ]
then
echo "$filename does not exist"
    touch $filename
    echo "App_version : 1.0.1
Latest_commit: 7ef9d5d" > release.txt
else
echo "$filename   exist"
ls -ltra $filename
fi


on_master_branch () {
  [[ $(git symbolic-ref --short -q HEAD) == "master" ]] && return 0
  return 1
}

origin="origin"
branch="master"
commit=$(git log -n 1 --pretty=format:%H "$origin/$branch")

url=$(git remote get-url "$origin")

for line in "$(git ls-remote -h $url)"; do
    fields=($(echo $line | tr -s ' ' ))
    test "${fields[1]}" == "refs/heads/$branch" || continue
    test "${fields[0]}" == "$commit" && echo "nothing new" \
        || echo "new commit(s) availble"
    exit
done

echo "no matching head found on remote"
fi