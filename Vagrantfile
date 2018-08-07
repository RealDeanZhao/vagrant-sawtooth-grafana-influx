# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  $host_ip = "192.168.57.1"
  $seed_ip = "192.168.57.101"
  # 设置虚拟机参数
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "512"
  end

  # 配置阿里云源
  config.vm.provision "shell", path: "apply_source_list.sh"

  # 安装sawtooth_sdk_go
  config.vm.provision "shell" do |s|
    s.path="install_go_sdk.sh"
    s.args= [1, $host_ip, 1081]
  end

  # 安装sawtooth
  config.vm.provision "shell", path: "install_sawtooth.sh"

  # 共享目录
  config.vm.synced_folder "share", "/share"

  # 代码目录
  config.vm.synced_folder "coderepos", "/coderepos"

  N = 1
  (0..N).each do |node_id|
    config.vm.define "xyd-sawtooth-node-#{node_id}" do |node|
      $ip = "192.168.57.#{101+node_id}"
      node.vm.hostname = "xyd-sawtooth-node-#{node_id}"
      node.vm.network "private_network", ip: $ip
      if node_id == 0
        # 第一台机器安装grafana
        node.vm.provision "shell" do |s|
          s.path= "install_grafana.sh"
          s.args= [$ip]
        end 
        # 第一台机器安装influx_db
        config.vm.provision "shell", path: "install_influx.sh"
        # 配置sawtooth
        node.vm.provision "shell" do |s|
          s.path="config_sawtooth.sh"
          s.args= [$ip, 0]
        end
      else
        node.vm.provision "shell" do |s|
          s.path="config_sawtooth.sh"
          s.args= [$ip, 1, $seed_ip]
        end
      end
    end
  end

  # 安装telegraf
  config.vm.provision "shell" do |s|
    s.path="install_telegraf.sh"
    s.args= [$seed_ip]
  end
  
  # 设置镜像
  config.vm.box = "ubuntu/xenial64"
end
