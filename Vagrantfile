# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "https://googledrive.com/host/0B5KmyzksuKPHfkdiY3JjTmRUSzJBalpDU3RqSzk0RXhPb2J5T2hKUVA1WGdFbEtfbGxESTA/centos7.box"
  
  # Create a hostname for the box.
  config.vm.hostname = "local.esource.com"
  
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 22, host: 23200, host_ip: "127.0.0.1", id: "ssh", auto_correct: true
  config.vm.network "forwarded_port", guest: 3306, host: 34306, host_ip: "127.0.0.1", id: "mysql", auto_correct: true

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.220"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
    # Customize the memory on the VM:
    vb.memory = 4096;
    # Customize the number of CPUs on the VM:
    vb.cpus = 4
    # Customize the name of the VM:
    vb.name = "Drupal - Base Box"
  end
  #
  # View the documentation for the provider you're using for more
  # information on available options.
  
  # Ensure we are installing the correct version of chef for our cookbooks.
  Vagrant.configure("2") do |config|
    config.omnibus.chef_version = "12.4.1"
  end
  
  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = "chef-repo/cookbooks"
    # chef.roles_path = "chef-repo/roles"
    # chef.data_bags_path = "chef-repo/data_bags"
    # chef.add_role "web"
    
    # Add the main recipe.
    chef.add_recipe "drupal_box_wrapper"
  end
end
