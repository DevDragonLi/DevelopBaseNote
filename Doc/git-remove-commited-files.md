
# 刪除Git中已經被commit的檔案？減少倉庫(Repository)所佔用的檔案空間大小

> [**参考文章原地址**](https://magiclen.org/git-remove-commited-files/) 

## git-scm上指令探索

- https://git-scm.com/book/zh/v2/Git-内部原理-维护与数据恢复
  
  -  git filter-branch --index-filter \
  'git rm --ignore-unmatch --cached git.tgz' -- 7b30847^.. 
  
  - **本地指令报：you must specify a ref to rewrite **
-  其他简书教程基本是：WARNING: Ref 'refs/remotes/origin/master' is unchanged

## 瘦身的执行操作如下

- 顯示目前專案的Git倉庫究竟佔用了多少空間

	-  git count-objects -vH

- 將Git倉庫中的檔案依照大小排序並顯示出來

	- git rev-list --objects --all | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | sed -n 's/^blob //p' | sort --numeric-sort --key=2 | cut -c 1-12,41- | $(command -v gnumfmt || echo numfmt) --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest

- 將已經被commit進Git倉庫的檔案刪除

	-  git filter-branch --force --tree-filter 'rm -f -r "fileName"' -- --all 

- 后续操作，可连续执行 
	- git filter-branch --force && git reflog expire --expire=now --expire-unreachable=now --all && git gc --prune=all --aggressive && git push --force --all


 
 
 
 