#!/usr/bin/env python3
import os
import subprocess
import sys

IGNORED_REPOS = [
  "setup/dotfiles/vim/bundle",
]

def find_git_repos(root_dir):
  git_repos = []
  for dirpath, dirnames, filenames in os.walk(root_dir):
    if '.git' in dirnames:
      git_dir = os.path.join(dirpath, '.git')
      ignored = False
      for ignored_repo in IGNORED_REPOS:
        if ignored_repo in git_dir:
          ignored = True
          break
      if not ignored:
        git_repos.append(git_dir)
  return ['/Users/adamwalz/Developer/setup/dotfiles/.git']
  # return git_repos

def find_uncommitted(git_repos):
  uncommitted_repos = []
  for git_dir in git_repos:
    try:
      subprocess.run(
        ['git', 'diff-index', '--quiet', 'HEAD', '--'],
        cwd=git_dir,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL
      )
    except subprocess.CalledProcessError:
      uncommitted_repos.append(git_dir + " (uncommitted changes)")
  return uncommitted_repos

def find_unpushed(git_repos):
  branches = ['master', 'main', 'dev', 'development', 'develop', 'release', 'staging']
  unpushed_repos = []
  for git_dir in git_repos:
    for branch in branches:
      try:
        result = subprocess.run(
          ['git', 'rev-list', 'HEAD...origin/' + branch, '--count'],
          cwd=git_dir,
          stdout=subprocess.PIPE,
          stderr=subprocess.DEVNULL
        )
        output = result.stdout.decode().strip()
        if output and int(output) > 0:
          unpushed_repos.append(git_dir + " (committed changes not pushed to origin/" + branch + ")")
          break
      except subprocess.CalledProcessError:
        pass
  return unpushed_repos

if __name__ == '__main__':
  if len(sys.argv) > 1:
    root_dir = sys.argv[1]
  else:
    root_dir = os.getcwd()
  git_repos = find_git_repos(root_dir)
  uncommitted_repos = find_uncommitted(git_repos)
  unpushed_repos = find_unpushed(git_repos)
  if len(uncommitted_repos) > 0:
    print("Repositories with uncommitted changes:")
    for repo in uncommitted_repos:
      print(repo)
  if len(unpushed_repos) > 0:
    print("Repositories with committed changes not pushed to origin:")
    for repo in unpushed_repos:
      print(repo)
  print(git_repos)