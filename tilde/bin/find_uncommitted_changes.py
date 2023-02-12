#!/usr/bin/env python3
import os
import subprocess
import sys

IGNORED_REPOS = [
  "setup/dotfiles/vim/bundle",
  "setup/dotfiles/tmux/plugins",
]

def find_git_repos(root_dir):
  git_repos = []
  for dirpath, dirnames, filenames in os.walk(root_dir):
    if '.git' in dirnames:
      repo_root = dirpath
      ignored = False
      for ignored_repo in IGNORED_REPOS:
        if ignored_repo in repo_root:
          ignored = True
          break
      if not ignored:
        git_repos.append(repo_root)
  return git_repos

def find_uncommitted(git_repos):
  uncommitted_repos = []
  for repo_root in git_repos:
    result = subprocess.run(
      ['git', 'status', '--ignore-submodules', '--porcelain'],
      cwd=repo_root,
      stdout=subprocess.PIPE,
      stderr=subprocess.DEVNULL
    )
    output = result.stdout.decode().strip()
    if output:
      uncommitted_repos.append(repo_root + " (uncommitted changes)")
  return uncommitted_repos

def find_unpushed(git_repos):
  branches = ['master', 'main', 'dev', 'development', 'develop', 'release', 'staging', 'production']
  unpushed_repos = []
  for repo_root in git_repos:
    for branch in branches:
      try:
        result = subprocess.run(
          ['git', 'rev-list', 'HEAD...origin/' + branch, '--count'],
          cwd=repo_root,
          stdout=subprocess.PIPE,
          stderr=subprocess.DEVNULL
        )
        output = result.stdout.decode().strip()
        if output and int(output) > 0:
          unpushed_repos.append(repo_root + " (committed changes not pushed to origin/" + branch + ")")
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