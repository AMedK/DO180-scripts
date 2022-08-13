#!/bin/sh

###########################################################
# CH06-GE02 Chapter 6 Guided Exercise 2
# Creating a Containerized Application with Source-to-Image
###########################################################

Username="brzytwa"
str1="https://github.com/"
str2="/DO180-apps"
URL="$str1$Username$str2"
Repo="$Username$str2"
RedHatRepo="https://github.com/RedHatTraining/DO180-apps"

nc -zw1 google.com 443 2>/dev/null
flag01=$?

if [ $flag01 -eq 0 ]
then
    echo -e "Access to the network: OK.\n"
else
   echo -e "Error. There is no network access.\n"
   echo -e "Interrupting script execution.\n"
   exit 1
fi


if [ -d "$HOME/DO180-apps" ] 
then
    echo -e "Directory: ~/DO180-apps exists.\n"
    echo -e "Removing directory: ~/DO180-apps\n"
    rm -r -f ~/DO180-apps
fi


gh auth login --with-token < $HOME/mytoken.txt >/dev/null
flag03=$?


if [ $flag03 -eq 0 ]
then
    echo -e "Access to the GitHub account granted.\n"
else
    echo -e "Error. Unable to access GitHub account.\n"
    echo -e "Interrupting script execution.\n"
    exit 2
fi


cd $HOME
git ls-remote $URL -q
flag04=$?

if [ $flag04 -eq 0 ]
then
   echo -e "Removing old repo.\n"
   gh repo delete $Repo --confirm
   echo -e "Forking clean repo.\n"
   gh repo fork --clone $RedHatRepo  
else
   echo -e "Forking repo.\n"
   gh repo fork --clone $RedHatRepo
fi

gh auth logout 

