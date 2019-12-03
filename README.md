# linux-useful-commands
Some useful commands

## Git
### Global setup

```bash
git config --global user.email "email@example.com"
git config --global user.name "username"

# Use kdiff as merge tool
sudo apt-get install kdiff3
git config --global merge.tool "kdiff3"

#Use vim as default editor
git config --global core.editor "vim"
```

### Git commands
```bash
# Import functions
chmod u+x functions && . ./functions

# Remove all branches but master
remove_branches_but master

# Squash against another branch
git rebase -i <other branch>
# Squash last 2 commits in current branch
git rebase -i HEAD~2
# Squash when merging
git merge --squash <other branch>

# Take file from another branch
git checkout <branch> -- file

# Change author and committer
git filter-branch --env-filter 'if [ "$GIT_AUTHOR_EMAIL" = "incorrect@email" ]; then
     GIT_AUTHOR_EMAIL=correct@email;
     GIT_AUTHOR_NAME="Correct Name";
     GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL;
     GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"; fi' -- --all
```
 
