# OmniOS Setups

所有服务都是在 lipkg branded Zone容器里运行。

## Solaris Zone

设置[帮助](https://omnios.org/setup/zones)

```SHELL
# zfs create -o mountpoint=/zone rpool/zone
```

制作一个`test` Zone容器

```SHELL
# zonecfg -z test
zonecfg:test> create -t pkgsrc
zonecfg:test> set zonepath=/zones/test
zonecfg:test> exit

omnios# zonecfg -z test
zonecfg:test> add net
zonecfg:test:net> set physical=test0
zonecfg:test:net> set global-nic=auto
zonecfg:test:net> set allowed-address=172.27.10.100/24
zonecfg:test:net> set defrouter=172.27.10.254
zonecfg:test:net> end
zonecfg:test> add attr
zonecfg:test:attr> set name=resolvers
zonecfg:test:attr> set type=string
zonecfg:test:attr> set value=1.1.1.1,1.0.0.1
zonecfg:test:attr> end
zonecfg:test> add attr
zonecfg:test:attr> set name=dns-domain
zonecfg:test:attr> set type=string
zonecfg:test:attr> set value=omnios.org
zonecfg:test:attr> end
zonecfg:test> exit

omnios# zoneadm -z test install
```


## DNS Server

两种常用命令来找bind9安装包。

```SHELL
# pkg search bind9
# pkg list '*bind9*'
```

设置文件在`/etc/opt/ooce/named-9.18/`地址下。
Zone 文件在`/var/opt/ooce/named/named-9.18/namedb/`地址下。
