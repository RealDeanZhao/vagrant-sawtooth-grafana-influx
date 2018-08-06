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

  config.vm.define "first" do |first|
      $ip = $seed_ip
      first.vm.hostname = "xyd-sawtooth-node-1"
      first.vm.network "private_network", ip: $ip
      # 第一台机器安装grafana
      first.vm.provision "shell", path: "install_grafana.sh"
      # 第一台机器安装influx_db
      config.vm.provision "shell", path: "install_influx.sh"
      # 配置sawtooth
      first.vm.provision "shell" do |s|
        s.path="config_sawtooth.sh"
        s.args= [$ip, 0]
      end
  end

  config.vm.define "second" do |second|
    $ip = "192.168.57.102"
    second.vm.hostname = "xyd-sawtooth-node-2"
    second.vm.network "private_network", ip: $ip
    # 配置sawtooth
    second.vm.provision "shell" do |s|
      s.path="config_sawtooth.sh"
      s.args= [$ip, 1, $seed_ip]
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
