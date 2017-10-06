require 'rake'

task :provision do
  hosts = ENV['hosts'] || 'centos6-64-ubuntu1404-64-redhat6-64-windows2016-64'
  puts `beaker --provision --hosts #{hosts} --tests provision.rb --preserve-hosts -k ~/.ssh/id_rsa-acceptance`
  print File.read('inventory.json')
end
