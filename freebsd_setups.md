# FreeBSD 设置

以下服务全部在FreeBSD Jail容器里面安装和设置。采用的是Thin Jail.

## Jail

### 设置Jail

```SHELL
# sysrc jail_enable="YES"
# sysrc jail_parallel_start="YES"

# zfs create -o mountpoint=/usr/local/jails zroot/jails
# zfs create zroot/jails/media
# zfs create zroot/jails/templates
# zfs create zroot/jails/containers
```

### Jail 设施文件

`/etc/jail.conf`里面：

```SHELL
.include "/etc/jail.conf.d/*.conf";
```

### 制作 Thin Jail

按照版本数字该命令

```SHELL
# zfs create -p zroot/jails/templates/14.1-RELEASE

# fetch https://download.freebsd.org/ftp/releases/amd64/amd64/14.1-RELEASE/base.txz -o /usr/local/jails/media/14.1-RELEASE-base.txz
# tar -xf /usr/local/jails/media/14.1-RELEASE-base.txz -C /usr/local/jails/templates/14.1-RELEASE --unlink

# cp /etc/resolv.conf /usr/local/jails/templates/14.1-RELEASE/etc/resolv.conf
# cp /etc/localtime /usr/local/jails/templates/14.1-RELEASE/etc/localtime

# freebsd-update -b /usr/local/jails/templates/14.1-RELEASE/ fetch install

# zfs snapshot zroot/jails/templates/14.1-RELEASE@base
```

制作Thin Jail

```SHELL
# zfs clone zroot/jails/templates/14.1-RELEASE@base zroot/jails/containers/<name of jail>
```

## DNS设置

搜索`bind`安装包。本文件以`bind918`为例。

```SHELL
# pkg search bind
# pkg install bind918
```

FreeBSD的`bind9`设置在`/usr/local/etc/named/`目录下。设置文件`named.conf`。DNS Zone文件地址在设置文件里。

## MySQL设置

```SHELL
# pkg install mysql84-server
# sysrc mysql_enable="YES"
# service mysql-server start
# mysql_secure_installation
```

制作用户`haotian`

```SQL
GRANT ALL ON haotiandb.* TO 'haotian'@'%' IDENTIFIED BY '<password>';
```
