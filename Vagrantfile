Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/groovy64"
    config.vm.network "private_network", ip: "192.168.99.10"
    config.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end
  end