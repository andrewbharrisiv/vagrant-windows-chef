# -*- mode: ruby -*-
# vi: set ft=ruby :

# import ruby file utils library
require 'fileutils'

# Get absolute path of this directory
REPOSITORY_ROOT = File.expand_path File.dirname(__FILE__)

# set project specific variables
PROJECT_NAME = 'win2012r2'

# set default vagrant provider
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = 'win2012r2_core_virtualbox.box'

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = 'http://dcvmstorage.blob.core.windows.net/vagrant/win2012r2_core_virtualbox.box'

  # Configure guest settings
  config.vm.network :forwarded_port, guest: 80, host: 8080, id: 'http', autocorrect: true
  config.vm.network :forwarded_port, guest: 22, host: 2222, id: 'ssh', autocorrect: true
  config.vm.network 'private_network', type: 'dhcp'
  config.vm.communicator = 'winrm'

  # Synced Folders (update first param with foo.UI.Website dir in src)
  config.vm.synced_folder "src/TestSite", '/c/Website', type: 'rsync'
  config.vm.synced_folder "vagrant/chef", '/tmp/vagrant-chef-resources'

  # Virtual Box provider configuration
  config.vm.provider :virtualbox do |v, override|
    v.name = "vagrant_#{PROJECT_NAME}"
    v.gui = false
    v.memory = 2048
    v.cpus = 1
  end

  # Shell provisioner
  config.vm.provision :shell, :path => 'vagrant/shell/InstallChocolatey.ps1'
  config.vm.provision :shell, :path => 'vagrant/shell/InstallRuby.ps1'
  config.vm.provision :shell, :path => 'vagrant/shell/InstallChef.ps1'
  config.vm.provision :shell, :path => 'vagrant/shell/PrepareProvisioner.ps1'
  config.vm.provision :shell, :path => 'vagrant/shell/SetupIIS32Bit.ps1'

  # Ensure vagrant/chef/cookbooks directory exists so chef provisioner works correctly
  FileUtils.mkdir_p("#{REPOSITORY_ROOT}/vagrant/chef/cookbooks")

  # Chef provisioner
  config.vm.provision :chef_solo do |chef|
    # chef options
    chef.node_name = 'vagrant-windows'

    # chef solo only options
    chef.cookbooks_path = ['vagrant/chef/cookbooks', 'vagrant/chef/site_cookbooks']

    # provisioning config
    chef.add_recipe 'iis'
    chef.add_recipe 'vagrant_main'
  end

  # Setup file watchers on guest for building and compiling sites
  #config.vm.provision :shell, :path => 'vagrant/shell/SetupWatchers.ps1'

  # Configure ssh settings
  config.ssh.keep_alive = true

end
