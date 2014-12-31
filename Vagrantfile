# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"

CPUS = 4
RAM  = (4 * 1024).to_s
INSTANCE_IP = "192.168.33.10"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "hashicorp/precise64"

  config.vm.network :private_network, ip: INSTANCE_IP
  config.ssh.forward_agent = true

  # Only mount a "bridge" directory if it exists on the host filesystem.
  if File.exists? File.join(File.dirname(__FILE__), 'bridge')
    config.vm.synced_folder "./bridge", "/home/vagrant/bridge"
  end

  config.vm.provider :virtualbox do |vb|
    vb.gui = false

    vb.customize ["modifyvm", :id, "--memory", RAM, "--cpus", CPUS]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

    vb.customize ["setextradata", :id,
      "VBoxInternal2/SharedFoldersEnableSymlinksCreate/bridge", 1
    ]
  end

  config.vm.provision "shell", path: "provision.sh", privileged: false
end
