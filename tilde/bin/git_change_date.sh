#!/bin/sh

git filter-branch $1 --env-filter '

if [ $GIT_COMMIT = 75aa4a7eab94c9a875e981101a04f1489f9049a8 ]
then
  export GIT_AUTHOR_DATE="Mon Feb 2 15:45:24 2015 -0800"
  export GIT_COMMITTER_DATE="Mon Feb 2 15:45:24 2015 -0800"
  export GIT_COMMITTER_EMAIL="adam@adamwalz.net"
  export GIT_AUTHOR_EMAIL="adam@adamwalz.net"
fi
' --tag-name-filter cat -- --branches --tags
