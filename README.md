# vagrant-sawtooth-grafana-influx
Sawtooth with grafana and influx

## 安装Vagrant
[从这儿下载](https://www.vagrantup.com/downloads.html)

## 机器说明
### xyd-sawtooth-dev-build
这台虚拟机安装了编译一个sawtooth trasaction processor所必须要的依赖.

当然如果你们自己写的processor里面有其他依赖, 请ssh到此机器手动安装

需要切换到root账户进行操作
```
vagrant ssh xyd-sawtooth-dev-build
sudo su
```

编译好的transaction processor可以放到/share/bin目录下, 这样其他虚拟机也可以访问

### xyd-sawtooth-grafana-influx
这台机器安装了性能监控工具

在浏览器中打开 http://192.168.57.223:3000即可访问

初始账号密码: admin/admin

### xyd-sawtooth-node-*
这些是sawtooth的validator节点
```
vagrant ssh xyd-sawtooth-node-1
```
不清楚是sawtooth的bug还是什么, settings-tp创建的poet文件属于root:root组
需要收到更改一下
```
sudo su
chown sawtooth:sawtooth /var/lib/sawtooth/poet*
```

## 需要翻墙
在创建xyd-sawtooth-dev-build的时候需要翻墙....
