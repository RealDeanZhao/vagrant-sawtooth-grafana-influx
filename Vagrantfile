# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  $seed_ip = "192.168.57.101"
  # 设置虚拟机参数
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "512"
  end

  # 配置阿里云源
  config.vm.provision "shell", path: "apply_source_list.sh"

  # 安装sawtooth
  config.vm.provision "shell", path: "install_sawtooth.sh"

  N = 2
  (0..N).each do |node_id|
    config.vm.define "xyd-sawtooth-node-#{node_id}" do |node|
      $ip = "192.168.57.#{101+node_id}"
      node.vm.hostname = "xyd-sawtooth-node-#{node_id}"
      node.vm.network "private_network", ip: $ip
      if node_id == 0
        # 第一台机器安装grafana
        node.vm.provision "shell", path: "install_grafana.sh"
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
