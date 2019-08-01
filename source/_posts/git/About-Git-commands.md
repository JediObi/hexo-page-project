---
title: About Git commands
copyright: true
date: 2019-08-01 11:08:00
categories:
    - git
tags:
    - git
---
git命令，从本地新建一个git工程关联到远程空工程。
从远程新建一个新工程拉到本地。

<!-- more -->

workspace==add==>temporary storage==commit==>local version repository==push==>remote version repository.

(1)**basic operation**
**git add <file_or_directory>**  --> add changes to temporary
**git commit [≶file_or_directory>] -m "msg"** --> commit changes to local repository, [≶file_or_directory>] optional arguments and null means all files.
**git push <remote_repository> <local_branch>[:<remote_branch>]** --> push local changes to remote, [<remote_branch>:] optional argument and null means push the local branch to its tracking remote branch.
**git pull <remote_repository> [<remote_branch>:]<local_branch> **  -->get update from remote then merge to the local branch. "**git pull origin master**" equals to "**git fetch --all & git merge origin/master**".
**git merge <local_branch>** --> merge the specific branch to current branch in **Fast Forward(FF)**. Merge is like a process combines "add" and "commit", "FF" means no msg  in commit.
**git merge ‐-no-ff -m "msg"** --> merge without "FF".

**Conflict**
when we "**merge**" a branch "**a**" to current branch "**b**", it may comes a "**confilct**". If **a**'s version is higher than **b**, the "**merge**" will complete smoothly. But if not, as **a**'s version is 2 and **b**'s version is 2 or bigger, the "**merge**" will fail. **You need to resolve the conflict.**
**git merge** will automatically gain all changes from two branches. You have to edit these changes and than "**add**" and "**commit**" for a **new version**. A **new version** means the conflict had been resolved.

### **new project**
+ **(1)start a new project on remote and local is null**
		(1)start a new project on remote
		(2)clone to local
+ **(2)start a new project on local and remote is null**
		(1)start a new project on local
		(2)start a new project on remote
			(3)```~:git remote add origin <remote_project_URL>``` --> add a new repository named "**origin**"to reomte
			(4)```~:git pull origin master``` --> update master from origin
			(5)```add``` and ```commit``` --> update local repository
			(6)```~:git push origin master``` --> push the initial porject to remote.

**branch**
**git remote show origin** --> see remote branch of origin
**git remote prune origin** --> delete the local cache of remote branches that had been deleted at remote.
**git fetch** --> update local records of remote repository. **You can't use remote component directly with which local repository don't have the component's record. So, you must use "git fetch" to update the local records if you want to use a new branch at remote.**
(1)start a new branch on remote and local has no corresponding.
             (1)**git checkout -b <new_local_branch> <origin/remote_branchname>** --> create a new local branch of the specific remote branch.
(2)start a new branch on local and remote has no corresponding.
             (1)**git push <remote_repository> <local_branch>** --> just push it .

**push & pull branch**
**git push <remote_repository> <local_branch>** --> it is a simplification of **git push <remote_repository> <local_branch>:<remote_branch>**.
**git push origin :<remote_branch>**-->delete a remote branch.
**git pull <remote_repository> <local_branch>** --> it is a simplification of **git pull <remote_repository> <remote_branch>:<remote_branch>**.

**others**
**git status** --> show status of workspace and temporary.
**git branch ‐-set-upstream-to=origin/<remote_branch> <local_branch>** -->track the local branch to a specific remote branch.
**git reflog** --> show all commit history and id.

**git config --unset --global user.name** --> unset user.name

**commit id on local**
**git log ‐-pretty=oneline** --> see logs of commit id and messages.
**git rev-parse HEAD** --> latest commit id of current branch
**git rev-parse short HEAD** --> have a try

**commit id on remote**
**git log FETCH_HEAD** or **git log origin/master** --> show commit id(s) and message(s) of remote branch.
**git rev-parse FETCH_HEAD** or **git rev-parse origin/master** -->lastest commit id of remote branch.
**git rev-parse short origin/master** --> have a try.

**set-url**
**git remote set-url origin https://xxx.xx/xxx.git** --> change remote url