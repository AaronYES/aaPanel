#! /bin/bash
# By Aaron
# https://github.com/AaronYES/aaPanel

#彩色
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}
purple(){
    echo -e "\033[35m\033[01m$1\033[0m"
}

function English(){
wget https://raw.githubusercontent.com/AaronYES/aaPanel/main/script/aapanel-en.sh  -O aapanel-en.sh && chmod +x aapanel-en.sh && clear && ./aapanel-en.sh
}

function Chinese(){
wget https://ghproxy.com/https://raw.githubusercontent.com/AaronYES/aaPanel/main/script/aapanel-zh.sh  -O aapanel-zh.sh && chmod +x aapanel-zh.sh && clear && ./aapanel-zh.sh
}

# 菜单
function start_menu(){
    clear
    purple " Thank you for using the aaPanel tool."
    purple " 请选择您的语言｜Please select your language"
    purple " GitHub：https://github.com/AaronYES/aapanel"
    yellow " ————————————————————————————————————————————————"
    green " 1. English"
    green " 2. 简体中文"
    yellow " ————————————————————————————————————————————————"
    green " 0. 退出脚本｜Exit"

    echo
    read -p "请输入数字｜Please key in numbers：" menuNumberInput
    case "$menuNumberInput" in
        1 )
           English
	    ;;
        2 )
           Chinese
        ;;
        0 )
            exit 1
        ;;
        * )
            clear
            red "请输入正确数字!｜Please enter the correct number!"
            start_menu
        ;;
    esac
}
start_menu "first"
