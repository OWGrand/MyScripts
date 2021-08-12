#!/bin/bash

###This is a tool/utility that does different checks for an AWS account using the aws_cli. Inspired by the manual work I had to do and the fact that I am too fucking lazy to do such a manual labour.
###This is version 1.0.1
###In this revision the basic layout of the script will be created such as the UI and some of the options. Also, there are some pre-requsites that would be needed, so the script would make dependency checks as well.
###This is version 1.0.2 
###This is version 1.0.3
###In this revision, the options are hardcoded. It acctually do not need to be that complicated, but the purpose of the script is to work and to help me practice working with the "dialog" utility. It was going to be much more easier without using it.
###You should choose the tags for the services you want to check and it redirects it to a file called "TNT_`name_of_tag`" in your $PWD, so you can later cat TNT* and get all of the services' names that should be redeployed with the new tags acording to TNT.
###I should add two new dialog boxes, so you can check all of the services at once... (or you know... I can just execute the aws command and not bother making useless scripts)

cr=`echo $'\n'`
version="version 1.0.1"

####profile=cat ~/.aws/config | grep profile

#This checks if "dialog" and "aws_cli" are existing on the machine
echo which dialog 1> /dev/null

if [ $? != 0 ]
then sudo apt -y install dialog
fi

echo which aws 1> /dev/null

if [ $? != 0 ]
then sudo apt -y install aws
fi

#This is the dialog box's UI configuration
HEIGHT=15

WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="AWS Util $version"
TITLE="AWS Util $version"
MENU="Choose one of the following options:"
MENU2="Choose the desired AWS TAG"

OPTIONS=(1 "service"
         2 "Service"
         3 "Type"
         4 "type")

CHOICE=$(dialog --clear \
        --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
    clear
OPTIONS2=(1 "service"
         2 "Service"
         3 "Type"
         4 "type")

CHOICE2=$(dialog --clear \
        --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS2[@]}" \
                2>&1 >/dev/tty)
    clear
OPTIONS3=(1 "service"
         2 "Service"
         3 "Type"
         4 "type")

CHOICE3=$(dialog --clear \
        --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS3[@]}" \
                2>&1 >/dev/tty)
    clear    

case $CHOICE in
        1)
           echo "The services with tag `service` are:"/n && aws ec2 describe-tags --filters "Name=tag:service,Values=*" --output text | awk '{print $5}' | sort | uniq #1>$PWD/TNT_service
            ;;
        2)
           echo "The services with tag 'Service' are:" && aws ec2 describe-tags --filters "Name=tag:Service,Values=*" --output text | awk '{print $5}' | sort | uniq 
            ;;
        3)
            echo "The services with tag `Type` are:"/n && aws ec2 describe-tags --filters "Name=tag:Type,Values=*" --output text | awk '{print $5}' | sort | uniq 
            ;;
        4)  
            echo "The services with tag `type` are:"/n && aws ec2 describe-tags --filters "Name=tag:type,Values=*" --output text | awk '{print $5}' | sort | uniq 
            ;;
esac

case $CHOICE2 in
        1)
           echo "The services with tag `service` are:"/n && aws ec2 describe-tags --filters "Name=tag:service,Values=*" --output text | awk '{print $5}' | sort | uniq #1>$PWD/TNT_service 
            ;;
        2)
           echo "The services with tag `Service` are:"/n && aws ec2 describe-tags --filters "Name=tag:Service,Values=*" --output text | awk '{print $5}' | sort | uniq 
            ;;
        3)
            echo "The services with tag 'Type' are:" && aws ec2 describe-tags --filters "Name=tag:Type,Values=*" --output text | awk '{print $5}' | sort | uniq  
            ;;
        4)  
            echo "The services with tag `type` are:"/n && aws ec2 describe-tags --filters "Name=tag:type,Values=*" --output text | awk '{print $5}' | sort | uniq  
            ;;
esac

case $CHOICE3 in
        1)
           echo "The services with tag `service` are:" && aws ec2 describe-tags --filters "Name=tag:service,Values=*" --output text | awk '{print $5}' | sort | uniq  
            ;;
        2)
           echo "The services with tag `Service` are:" && aws ec2 describe-tags --filters "Name=tag:Service,Values=*" --output text | awk '{print $5}' | sort | uniq  
            ;;
        3)
            echo "The services with tag `Type` are:" && aws ec2 describe-tags --filters "Name=tag:Type,Values=*" --output text | awk '{print $5}' | sort | uniq  
            ;;
        4)  
            echo "The services with tag 'type' are:" && aws ec2 describe-tags --filters "Name=tag:type,Values=*" --output text | awk '{print $5}' | sort | uniq 
            ;;
esac
