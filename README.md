# pesmtech

How to commit your Changes,

$ git status
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   medicine/medicine.sql

Untracked files:
  (use "git add <file>..." to include in what will be committed)

        dataset/

no changes added to commit (use "git add" and/or "git commit -a")


$ git add medicine/medicine.sql
warning: LF will be replaced by CRLF in medicine/medicine.sql.
The file will have its original line endings in your working directory.
                                                                                                                                                                          

$ git commit                                                                                                                                                                                                                    
[master 7a23bec]        modified:   medicine/medicine.sql
 1 file changed, 17 insertions(+), 49 deletions(-)


$ git push 'https://github.com/dinuthomas/pesmtech'
