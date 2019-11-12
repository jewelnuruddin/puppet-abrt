# ref: https://app.vagrantup.com/puppetlabs
nodes = [
  { :hostname => 'centos6',     :ip => '192.168.1.2',  :box => 'puppetlabs/centos-6.6-64-puppet' },
  { :hostname => 'centos7',     :ip => '192.168.1.3',  :box => 'puppetlabs/centos-7.2-64-puppet' },
  # https://app.vagrantup.com/bento/boxes/centos-8.0
  { :hostname => 'centos8',     :ip => '192.168.1.4',  :box => 'bento/centos-8.0' },
]

Vagrant.configure("2") do |config|
  nodes.each do |node|
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.box = node[:box]
      nodeconfig.vm.hostname = node[:hostname] + ".box"
      nodeconfig.vm.network :private_network, ip: node[:ip]

      memory = node[:ram] ? node[:ram] : 256;
      nodeconfig.vm.provider :virtualbox do |vb|
        vb.customize [
          "modifyvm", :id,
          "--cpuexecutioncap", "50",
          "--memory", memory.to_s,
        ]
      end
    end
  end

 config.vm.provision "shell", path: "script.sh"
  config.vm.provision :shell do |shell|
    script = "mkdir -p /etc/puppetlabs/code/environments/production/modules/abrt;" +
    "cp -r /vagrant/* /etc/puppetlabs/code/environments/production/modules/abrt/;" +
    #"puppet module --modulepath=/etc/puppetlabs/code/environments/production/modules/ install puppetlabs/concat --version=1.2.4;" +
    "puppet module --modulepath=/etc/puppetlabs/code/environments/production/modules/ install puppetlabs/concat --version=1.2.4 --ignore-dependencies;" +
    'export PATH=$PATH:/opt/puppetlabs/puppet/bin;' +
    'export MODULEPATH=/etc/puppetlabs/code/environments/production/modules/;' +
    "puppet apply --modulepath=$MODULEPATH \"$MODULEPATH\"abrt/tests/init.pp;"
    shell.inline = script
  end
end
