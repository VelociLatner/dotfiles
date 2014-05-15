set -o vi
#export PS1='\[\033[01;32m\]\u\[\033[01;34m\]::\[\033[01;31m\]\h \[\033[00;34m\]{ \[\033[01;34m\]\w \[\033[00;34m\]}\[\033[01;32m\]-> \[\033[00m\]'
export PS1='\[\033[01;32m\][\u]\[\033[01;34m\] \[\033[00;34m\]{ \[\033[01;34m\]\w\[\033[01;33m\]$(__git_ps1) \[\033[00;34m\]}\[\033[01;32m\]-> \[\033[00m\]'

#export PATH=$PATH:~/bin
#export PATH=$PATH:/opt/jdk1.7.0_45/bin
#export JAVA_HOME=/opt/jdk1.7.0_45
#export PATH=$PATH:/opt/scala-2.10.3/bin
#export PATH=$PATH:/opt/sbt/bin
#export PATH=$PATH:/opt/android/sdk/platform-tools
#export PATH=$PATH:/opt/android/sdk/tools
#export PATH=$PATH:/opt/rabbitmq_server-3.1.5/sbin
#export PATH=$PATH:/opt/apache-jmeter-2.9/bin
#export CATALINA_HOME=/var/lib/tomcat7
#export CATALINA_HOME=~/Desktop/apache-tomcat-7.0.29
#export CATALINA_HOME=/opt/apache-tomcat-7.0.41
export EDITOR=vim

alias adb="my-adb"
alias clip="xclip -selection c"
alias ls="ls --color"
alias please="sudo !!"
alias retag="ctags -f ~/.tags --exclude=*.js -R ~/git"
alias upgrade="sudo apt-get update; sudo apt-get upgrade -y; sudo apt-get dist-upgrade -y"


function src () {
	find $(pwd) -iname $1* | grep src
}

function test () {
	find $(pwd) -iname $1* | grep tests
}

function j () {
	grep -rl --include="*.java" $1 $(pwd)
}

function xml () {
	grep -rl --include="*.xml" $1 $(pwd) | grep -v target
}

extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }

## Displays the last date a file was touched by a commit.
checkdate () {
	for foo in $@
	  do
	    if [[ -f $foo ]]
	    then
		echo $foo
		echo $(git log --oneline -- $foo | tail -n 1)
		git show $(git log --oneline -- $foo -n 1 | awk '{print $1}') | head -n 3 | tail -n 1
		echo
	    fi
	  done
  }

## Usage: wuts-between <branch> <branch> -- Displays the authors and commits between two git refs.
wuts-between () {
	for commit in `git rev-list $1..$2 --no-merges`
	do
		git show --format="%H   %an" $commit | head -1
	done
  }

## Usage:  loggrep [keyword] [file]
function loggrep () {
	commitHashes=$(git log -- $2 | grep commit | awk '{print $2}' )
	for number in {1..100}
	do
		currentHash=$(echo $commitHashes | awk "{print \$$number}" )
		if [[ $(git show $currentHash | grep -ci $1 ) -ne 0 ]]
			then
			echo "Commit $number: $currentHash"
		fi
	done
}


if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
