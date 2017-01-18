# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.guest = :windows
  config.vm.boot_timeout = 600
  config.vm.graceful_halt_timeout = 600
  config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
  config.vm.network :forwarded_port, guest: 3389, host: 3389, id: "rdp", auto_correct: true
  config.vm.communicator = "winrm"
  config.winrm.username = "vagrant"
  config.winrm.password = "vagrant"

  config.vm.provider "virtualbox" do |vb|
	  vb.gui = false

	  #disable "vb.name" to get unique Virtualbox VM Name from vagrant convention
	  #vb.name = box_name		#//vb.name is VirtualBox GUI's VM Name.
  end
end
