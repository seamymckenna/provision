require 'json'
require 'pry'

#variable configurations
container_name = 'httpd' || ENV['container_name']
containers_per_host = 5 || ENV['containers_per_host']

my_json = {
    'ips' => hosts.each {|a| a.ip },
    'total_packages' => 'todo',
    'total_containers' => 0,
    'total_servers' => hosts.length,
    'total_windows' => hosts.count {|a| /win/ =~ a.platform },
    'total_linux' => hosts.length - agents.count {|a| /win/ =~ a.platform },
    'docker_hosts' => 0,
    'web_servers' => 0,
    'sql_servers' => 0,

}

test_name "Provision Hosts for Discovery" do
  
  #Install agent on each host,
  #We use the agent as a handy way to install docker engine , a webserver via puppet modules
  #Also provides us a way to count packages via puppet resource
  hosts.each{ |host| install_puppet_agent_on host }

  #Install docker on each ubuntu host
  hosts.select{|a| a.name.include? 'ubuntu' }.each do |ubuntu|
    my_json['docker_hosts']+=1
    on ubuntu, "puppet module install garethr-docker"
    on ubuntu, "puppet apply --modulepath=/etc/puppetlabs/code/environments/production/modules -e \"include 'docker'\""
    containers_per_host.times do
      my_json['total_containers']+=1
      on ubuntu, "docker pull #{container_name}"
      on ubuntu, "docker run -d  #{container_name}"
    end
  end

  #Install functioning webserver on each centos host functioning webserver
  hosts.select{|a| a.name.include? 'centos' }.each do |centos|
    my_json['web_servers']+=1
    on centos, "puppet module install puppetlabs-apache --version 2.1.0"
    on centos, "puppet apply --modulepath=/etc/puppetlabs/code/environments/production/modules -e \"include class { 'apache': }\""
  end

end

# Create a JSON file containing the Inventory which can be displayed and parsed later
File.open("inventory.json","w") do |f|
  f.write(JSON.pretty_generate(my_json))
end







