# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.define "mdsgpp" do |env|
    env.vm.box = "fabio1079/xenial-rails5"
    env.vm.network "forwarded_port", guest: 3000, host: 3000
    env.vm.network "forwarded_port", guest: 8000, host: 8000
    env.vm.network "forwarded_port", guest: 8080, host: 8080
  end

  config.vm.provider "virtualbox" do |vb|
  # Display the VirtualBox GUI when booting the machine
  # vb.gui = true
  #
  # Customize the amount of memory on the VM:
    vb.memory = "1048"
  end

end
