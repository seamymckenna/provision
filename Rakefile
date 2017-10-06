require 'rake'

task :provision do
  hosts = ENV['hosts'] || 'centos7-64-ubuntu1604-64-redhat7-64-windows2016-64'
  `beaker --provision --hosts #{hosts} --tests provision.rb --preserve-hosts -k ~/.ssh/id_rsa-acceptance`
  print File.read('inventory.json')
end
