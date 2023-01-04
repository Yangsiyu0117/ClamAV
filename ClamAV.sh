#!/bin/bash
# date : 2023.1.4
# Use：Centos 7
# Install ClamAV

#骚气颜色
show_str_Black()
{
        echo -e "\033[30m $1 \033[0m"
}
show_str_Red()
{
        echo -e "\033[31m $1 \033[0m"
}
show_str_Green()
{
        echo -e "\033[32m $1 \033[0m"
}
show_str_Yellow()
{
        echo -e "\033[33m $1 \033[0m"
}
show_str_Blue()
{
        echo -e "\033[34m $1 \033[0m"
}
show_str_Purple()
{
        echo -e "\033[35m $1 \033[0m"
}
show_str_SkyBlue()
{
        echo -e "\033[36m $1 \033[0m"
}
show_str_White()
{
        echo -e "\033[37m $1 \033[0m"
}


###
### Install ClamAV
###
### Usage:
###   bash ClamAV.sh -h       
### Options:
###  h  -h --help    Show this message.
###  remove    uninstall ClamAV


help() {
    sed -rn 's/^### ?//;T;p' "$0"
}

if  [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]] || [[ "$1" == "h" ]]; then
    help
    exit 1
fi



function write_header(){
	show_str_Red "**********************************************************************************"
    	show_str_Yellow "                                  ${proc}"
	show_str_Red "**********************************************************************************"
}

function run_ok(){
	echo -e "\033[42;31m SUCCESS \033[0m"
}

install_clamav(){
	if [[ `yum list installed | grep epel-release | wc -l` -eq 0 ]]; then
		#statements
		yum -y install epel-release >& /dev/null
		yum clean all >& /dev/null
		yum makecache >& /dev/null
	fi
	if [[ `yum list installed | grep clamav | wc -l` -eq 0 ]]; then
		#statements
		yum install clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd -y  >& /dev/null
		# update 病毒库
		freshclam  >& /dev/null
		proc=ClamAV
		write_header;
		run_ok;
	else
		show_str_Red "--------------------------------------------"
		show_str_Red "|                  警告！！！              |"
		show_str_Red "|    ClamAV install already exists！       |"
		show_str_Red "--------------------------------------------"
	    exit 0
	fi
	

}

uninstall_clamav(){
	yum -y remove clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd  >& /dev/null
	exit 0
}

case $1 in
	remove )
		uninstall_clamav;
		;;
esac

function onCtrlC () {
			        #捕获CTRL+C，当脚本被ctrl+c的形式终止时同时终止程序的后台进程
			        kill -9 ${do_sth_pid} ${progress_pid}
			        echo
			        echo 'Ctrl+C is captured'
			        exit 1
			}

			do_sth() {
			        #运行的主程序
			        install_clamav;
			}

			progress() {
			        #进度条程序
			        local main_pid=$1
			        local length=20
			        local ratio=1
			        while [ "$(ps -p ${main_pid} | wc -l)" -ne "1" ] ; do
			                mark='>'
			                progress_bar=
			                for i in $(seq 1 "${length}"); do
			                        if [ "$i" -gt "${ratio}" ] ; then
			                                mark='-'
			                        fi
			                        progress_bar="${progress_bar}${mark}"
			                done
			                printf "Progress: ${progress_bar}\r"
			                ratio=$((ratio+1))
			                #ratio=`expr ${ratio} + 1`
			                if [ "${ratio}" -gt "${length}" ] ; then
			                        ratio=1
			                fi
			                sleep 0.1
			        done
			}

			do_sth &
			do_sth_pid=$(jobs -p | tail -1)

			progress "${do_sth_pid}" &
			progress_pid=$(jobs -p | tail -1)

			wait "${do_sth_pid}"
			printf "Progress: done                \n"