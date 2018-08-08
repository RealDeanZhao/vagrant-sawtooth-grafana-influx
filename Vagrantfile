# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  $host_ip = "192.168.57.1"
  $seed_ip = "192.168.57.101"
  $dev_ip = "192.168.57.222"
  $grafana_ip = "192.168.57.223"
  $influx_ip = $grafana_ip
  # 设置虚拟机参数
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.cpus = 4
  end

  # 配置阿里云源
  config.vm.provision "shell", path: "apply_source_list.sh"

  # 安装sawtooth
  config.vm.provision "shell", path: "install_sawtooth.sh"

  # 共享目录
  config.vm.synced_folder "share", "/share"

  # 专门用来编译go transaction processor的机器
  config.vm.define "xyd-sawtooth-dev-build" do |build|
    build.vm.hostname = "xyd-sawtooth-dev-build"
    build.vm.network "private_network", ip: $dev_ip
     # sawtooth go 的编译环境
    build.vm.provision "shell" do |s|
      s.path="install_go_sdk.sh"
      s.args= [1, $host_ip, 1081]
    end
  end

  # grafana和influx都安装在这个机器上
  config.vm.define "xyd-sawtooth-grafana-influx" do |gi|
    gi.vm.hostname = "xyd-sawtooth-grafana-influx"
    gi.vm.network "private_network", ip: $grafana_ip
    # 安装grafana
    gi.vm.provision "shell" do |s|
      s.path= "install_grafana.sh"
      s.args= [$grafana_ip, $influx_ip]
    end 
    # 安装influx_db
    gi.vm.provision "shell", path: "install_influx.sh"
  end

  N = 2
  (1..N).each do |node_id|
    config.vm.define "xyd-sawtooth-node-#{node_id}" do |node|
      $ip = "192.168.57.#{100+node_id}"
      node.vm.hostname = "xyd-sawtooth-node-#{node_id}"
      node.vm.network "private_network", ip: $ip
      if node_id == 0
        # 配置sawtooth
        node.vm.provision "shell" do |s|
          s.path="config_sawtooth.sh"
          s.args= [$ip, ""]
        end
      else
        node.vm.provision "shell" do |s|
          s.path="config_sawtooth.sh"
          s.args= [$ip, $seed_ip]
        end
      end
      # 安装telegraf
      node.vm.provision "shell" do |s|
        s.path="install_telegraf.sh"
        s.args= [$influx_ip]
      end
    end
  end
  
  # 设置镜像
  config.vm.box = "ubuntu/xenial64"
end
