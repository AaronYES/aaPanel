#! /bin/bash
# By Aaron
# https://github.com/AaronYES/aapanel

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

# 下载aapanel面板
function aapanel-install(){
wget -O "/root/aapanel-install.sh" "http://www.aapanel.com/script/install_6.0_en.sh"
red "下载完成,正在从官方安装原版aapanel面板."
bash "/root/aapanel-install.sh"
}

# 下载bt面板
function bt-install(){  
wget -O "/root/bt-install.sh" "http://download.bt.cn/install/install_6.0.sh"
red "下载完成,正在从官方安装原版宝塔面板.."
bash "/root/bt-install.sh"
}

# 降级aapanel 官网下载(最后一个无广告版本)
function downgrade-official(){
wget -O "/root/LinuxPanel_EN-6.8.23.zip" "http://node.aapanel.com/install/update/LinuxPanel_EN-6.8.23.zip"
blue "下载完成,正在降级."
unzip LinuxPanel_EN-6.8.23.zip
cd /root/panel
wget -O "/root/panel/downgrade.sh" "https://ghproxy.com/https://raw.githubusercontent.com/AaronYES/aapanel/main/downgrade.sh" 
bash "/root/panel/downgrade.sh"
red "降级成功."
rm /root/LinuxPanel_EN-6.8.23.zip /root/panel/ -rf
}

# 降级aapanel GitHub下载 (最后一个无广告版本)
function downgrade-github(){
wget -O "/root/LinuxPanel_EN-6.8.23.zip" "https://ghproxy.com/https://github.com/AaronYES/aapanel/releases/download/1.0/LinuxPanel_EN-6.8.23.zip"
blue "下载完成,正在降级."
unzip LinuxPanel_EN-6.8.23.zip
cd /root/panel
wget -O "/root/panel/downgrade.sh" "https://ghproxy.com/https://raw.githubusercontent.com/AaronYES/aapanel/main/downgrade.sh" 
bash "/root/panel/downgrade.sh"
red "降级成功."
rm /root/LinuxPanel_EN-6.8.23.zip /root/panel/ -rf
}

## 降级宝塔面板
function downgrade-bt(){
wget -O "/root/LinuxPanel-7.7.0.zip" "http://download.bt.cn/install/update/LinuxPanel-7.7.0.zip"
blue "下载完成,正在降级."
unzip LinuxPanel-7.7.0.zip
cd /root/panel
bash /root/panel/update.sh
red "降级成功."
rm /root/LinuxPanel-7.7.0.zip /root/panel/ -rf
sed -i "s|bind_user == 'True'|bind_user == 'Close'|" /www/server/panel/BTPanel/static/js/index.js
rm -f /www/server/panel/data/bind.pl
red "屏蔽绑定成功."
}

# aapanel 开心
function aapanel-happy(){
sed -i 's|"endtime": -1|"endtime": 999999999999|g' /www/server/panel/data/plugin.json
sed -i 's|"pro": -1|"pro": 0|g' /www/server/panel/data/plugin.json
chattr +i /www/server/panel/data/plugin.json
red "执行之前请手动打开一次软件商店"
red "开心成功."
}

# 清理垃圾
function clean-up-trash(){
rm LinuxPanel_EN-6.8.23.zip aapanel-zh-CN.tar.gz chinese.zip aapanel-install.sh bt-uninstall.sh panel/ -rf
red "清理成功."
red "如果想删除此脚本 请执行 rm aapanel.sh -rf "
}

# 卸载 aaPanel
function uninstall(){
wget -O "/root/bt-uninstall.sh" "http://download.bt.cn/install/bt-uninstall.sh"
bash "/root/bt-uninstall.sh"
red "卸载aaPanel成功."
}

# 汉化 sinicization
function sinicization(){
wget -O "/root/aapanel-zh-CN.tar.gz" "https://ghproxy.com/https://github.com/AaronYES/aapanel/releases/download/1.1/aapanel-zh-CN.tar.gz"
tar -zxvf aapanel-zh-CN.tar.gz
mv /root/server/panel/BTpanel/static/language/English/* /www/server/panel/BTPanel/static/language/English/
mv /root/server/panel/config/menu.json /www/server/panel/config/
rm /root/server/ -rf
/etc/init.d/bt restart
red "汉化aaPanel成功."
}

function sinicization-gacjie(){
# 汉化 来自 https://gitee.com/gacjie/aapanel_chinese 
wget -O /root/chinese.zip https://ghproxy.com/https://github.com/AaronYES/aaPanel/releases/download/1.2/aapanel_chinese-6.8.21.zip
unzip -o /root/chinese.zip -d /www/server/
rm /root/chinese.zip -rf
/etc/init.d/bt restart
red "汉化aaPanel成功."
}

# 菜单
function start_menu(){
    clear
    purple " 感谢使用aaPanel小助手."
    purple " https://github.com/AaronYES/aapanel"
    yellow " ————————————————————————————————————————————————"
    green " 1. CentOS/Debian/Ubuntu 安装 aaPanel"
    green " 2. CentOS/Debian/Ubuntu 安装 宝塔面板"
    yellow " ————————————————————————————————————————————————"
    green " 3. 降级 6.8.23 版本 aaPanel(官网)"
    green " 4. 降级 7.7.0  版本 宝塔面板(官网)"
    green " 5. 开心一下٩(ˊᗜˋ*)و"
    green " 6. 汉化 aaPanel (文件来自Gitee)"
    yellow " ————————————————————————————————————————————————"
    green " 8. 卸载 aaPanel"
    green " 9. 清理脚本产生垃圾文件"
    green " 0. 退出脚本"

    echo
    read -p "请输入数字:" menuNumberInput
    case "$menuNumberInput" in
        1 )
           aapanel-install
	    ;;
        2 )
           bt-install
        ;;
        3 )
           downgrade-official
        ;;
        4 )
           downgrade-bt
        ;;
        5 )
           aapanel-happy
        ;;
        6 )
           sinicization-gacjie
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
            red "请输入正确数字 !"
            start_menu
        ;;
    esac
}
start_menu "first"
