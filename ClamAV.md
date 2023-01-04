# ClamAV

[TOC]

## <u>文档标识</u>

| 文档名称 | ClamAV   |
| -------- | -------- |
| 版本号   | <V1.0.0> |

## <u>文档修订历史</u>

| 版本   | 日期     | 描述   | 文档所有者 |
| ------ | -------- | ------ | ---------- |
| V1.0.0 | 2023.1.4 | create | 杨丝雨     |
|        |          |        |            |
|        |          |        |            |

## <u>相关文档参考</u>

[官网地址]: www.clamav.net
[源码包下载地址]: www.clamav.net/downloads
[官网文档手册地址]: https://docs.clamav.net/



## ClamAV介绍

------

ClamAV是 Linux 操作系统上最流行的防病毒软件、GPL 协议免费发布、用于检测木马，病毒，恶意软件和其他恶意威胁的一个开源杀毒引擎。

------

## ClamAV 的特点

![img](https://pic1.zhimg.com/80/v2-04ee1aa57a4ed2ed644bc292352f39c0_1440w.webp)

## clamscan常用参数选项

| 选项                     | 适用的文件类型‍                  | 执行命令示例                                            |
| ------------------------ | ------------------------------- | ------------------------------------------------------- |
| -r                       | 所有文件                        | /usr/local/clamav/bin/clamscan -r                       |
| --unrar                  | .rar 文件                       | /usr/local/clamav/bin/clamscan --unrar                  |
| --arj                    | .arj 文件                       | /usr/local/clamav/bin/clamscan --arj                    |
| --unzoo                  | .zoo 文件                       | /usr/local/clamav/bin/clamscan --unzoo                  |
| --lha                    | .lzh 文件                       | /usr/local/clamav/bin/clamscan --lha                    |
| --jar                    | .jar 文件                       | /usr/local/clamav/bin/clamscan --jar                    |
| --deb                    | .deb 安装包‍                     | /usr/local/clamav/bin/clamscan --deb                    |
| --tar                    | .tar 文件                       | /usr/local/clamav/bin/clamscan --tar                    |
| --tgz                    | .tar.gz                         | /usr/local/clamav/bin/clamscan --tgz                    |
| --log=FILE/-l FILE       | 增加扫描日志                    | /usr/local/clamav/bin/clamscan -l /var/log/clamscan.log |
| --move=directory         | 把病毒文件移动到目录directory下 | /usr/local/clamav/bin/clamscan --move /root             |
| --copy=directory         | 把病毒文件复制到目录directory下 | /usr/local/clamav/bin/clamscan --copy /root             |
| --remove                 | 删除病毒文件                    | /usr/local/clamav/bin/clamscan --move /abc              |
| --quiet                  | 输出错误消息                    | /usr/local/clamav/bin/clamscan --quiet                  |
| --infected/-i            | 输出感染文件                    | /usr/local/clamav/bin/clamscan -i                       |
| --suppress-ok-results/-o | 跳过扫描OK的文件‍                | /usr/local/clamav/bin/clamscan -o                       |

## ClamAV安装

------

- **安装epel源**

```shell
yum -y install epel-release && yum clean all && yum makecache
```

- **安装ClamAV**

```shell
yum install clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd -y
```

- **手动更新病毒库**

```shell
freshclam
```

