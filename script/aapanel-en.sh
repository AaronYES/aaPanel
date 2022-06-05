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

# 安装aapanel面板
function aapanel-install(){
wget -O "/root/aapanel-install.sh" "http://www.aapanel.com/script/install_6.0_en.sh"
red "Installing the original aapanel panel from the official website."
bash "/root/aapanel-install.sh"
}

# 安装bt面板
function bt-install(){  
wget -O "/root/bt-install.sh" "http://download.bt.cn/install/install_6.0.sh"
red "The original BTPanel is being installed from the official website.."
bash "/root/bt-install.sh"
}

# 降级aapanel GitHub下载 (最后一个无广告版本)
function downgrade-aapanel(){
wget -O "/root/LinuxPanel_EN-6.8.23.zip" "https://ghproxy.com/https://github.com/AaronYES/aapanel/releases/download/1.0/LinuxPanel_EN-6.8.23.zip"
red "Download complete, downgrading."
unzip LinuxPanel_EN-6.8.23.zip
cd /root/panel
wget -O "/root/panel/downgrade.sh" "https://ghproxy.com/https://raw.githubusercontent.com/AaronYES/aapanel/main/script/downgrade.sh" 
bash "/root/panel/downgrade.sh"
red "Downgrade succeeded."
rm /root/LinuxPanel_EN-6.8.23.zip /root/panel/ -rf
}

## 降级宝塔面板
function downgrade-bt(){
wget -O "/root/LinuxPanel-7.7.0.zip" "https://ghproxy.com/https://github.com/AaronYES/aaPanel/releases/download/1.3/LinuxPanel-7.7.0.zip"
blue "Download complete, downgrading."
unzip LinuxPanel-7.7.0.zip
cd /root/panel
bash /root/panel/update.sh
red "Downgrade succeeded."
rm /root/LinuxPanel-7.7.0.zip /root/panel/ -rf
sed -i "s|bind_user == 'True'|bind_user == 'Close'|" /www/server/panel/BTPanel/static/js/index.js
rm -f /www/server/panel/data/bind.pl
red "Delete binding succeeded."
}

# 破解付费
function panel-happy(){
red "Please manually open the software store once before executing"
sed -i 's|"endtime": -1|"endtime": 999999999999|g' /www/server/panel/data/plugin.json
sed -i 's|"pro": -1|"pro": 0|g' /www/server/panel/data/plugin.json
chattr +i /www/server/panel/data/plugin.json
chattr -i /www/server/panel/data/repair.json
rm /www/server/panel/data/repair.json
cd /www/server/panel/data
wget https://ghproxy.com/https://raw.githubusercontent.com/AaronYES/aaPanel/main/resource/repair.json
chattr +i /www/server/panel/data/repair.json
red "cracked successfully."
}

# 清理垃圾
function clean-up-trash(){
rm LinuxPanel_EN-6.8.23.zip aapanel-zh-CN.tar.gz chinese.zip aapanel-install.sh bt-install.sh bt-uninstall.sh panel/ -rf
red "Cleaned up successfully."
red "If you want to remove this script, run "rm aapanel.sh -rf""
}

# 卸载 面板
function uninstall(){
wget -O "/root/bt-uninstall.sh" "http://download.bt.cn/install/bt-uninstall.sh"
bash "/root/bt-uninstall.sh"
red "Panel uninstalled successfully."
}

# 删掉日志文件，并且锁定文件防止写入
function log(){
echo "" > /www/server/panel/script/site_task.py
chattr +i /www/server/panel/script/site_task.py
rm -rf /www/server/panel/logs/request/*
chattr +i -R /www/server/panel/logs/request
}

function sinicization-gacjie(){
# 汉化 来自 https://gitee.com/gacjie/aapanel_chinese 
wget -O /root/chinese.zip https://ghproxy.com/https://github.com/AaronYES/aaPanel/releases/download/1.2/aapanel_chinese-6.8.21.zip
unzip -o /root/chinese.zip -d /www/server/
rm /root/chinese.zip -rf
/etc/init.d/bt restart
red "success."
}

# 菜单
function start_menu(){
    clear
    purple " Thank you for using the aaPanel tool."
    purple " https://github.com/AaronYES/aaPanel"
    yellow " ————————————————————————————————————————————————"
    green " 1. Install aaPanel on CentOS/Debian/Ubuntu"
    green " 2. Install BTPanel on CentOS/Debian/Ubuntu"
    yellow " ————————————————————————————————————————————————"
    green " 3. Downgrade to aaPanel version 6.8.23"
    green " 4. Downgrade to BTPanel version 7.7.0 "
    green " 5. Crack"
    green " 6. Change aaPanel language to Chinese"
    green " 7. Delete log files, lock file write permissions"
    yellow " ————————————————————————————————————————————————"
    green " 8. Uninstall the aaPanel panel"
    green " 9. Cleanup script produces junk files"
    green " 0. Exit"

    echo
    read -p "Please key in numbers:" menuNumberInput
    case "$menuNumberInput" in
        1 )
           aapanel-install
	    ;;
        2 )
           bt-install
        ;;
        3 )
           downgrade-aapanel
        ;;
        4 )
           downgrade-bt
        ;;
        5 )
           panel-happy
        ;;
        6 )
           sinicization-gacjie
        ;;
        7 )
           log
        ;;
        8 )
           uninstall
        ;;
        9 )
           clean-up-trash
        ;;
        0 )
            exit 1
        ;;
        * )
            clear
            red "Please enter the correct number!"
            start_menu
        ;;
    esac
}
start_menu "first"
