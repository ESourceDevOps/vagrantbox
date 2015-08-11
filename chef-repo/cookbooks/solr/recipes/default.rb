#
# Cookbook Name:: solr
# Recipe:: default
#
# Copyright 2015, E Source Companies, LLC
#

# Installing Java and the Unzip utility.
execute "installing-java" do
	command "yum -y install java-1.8.0-openjdk unzip"
	not_if { File.directory?("/usr/lib/jvm") }
end


# Adding java home to profile and reloading.
bash "setting-java-home" do
	user "root"
	code <<-EOH
		echo 'export JAVA_HOME='$(readlink -f /usr/bin/java | sed "s:bin/java::") | tee -a /etc/profile
		source /etc/profile
	EOH
	not_if 'grep JAVA_HOME /etc/profile'
end

# Downloading solr.
remote_file '/tmp/solr-5.2.1.tgz' do
  source node['solr']['download_url']
  owner 'root'
  group 'root'
  mode '0775'
  action :create
end

# Extracting the SOLR tgz file.
execute "extracting-solr" do
	command "tar xzvf solr-5.2.1.tgz"
	cwd "/tmp"
	not_if { File.directory?("/tmp/solr-5.2.1") }
end

port = node.default['solr']['port']
datadir = node.default['solr']['datadir']
solr_user = node.default['solr']['user']
solr_group = node.default['solr']['group']

# Creating the solr data directory.
directory "#{datadir}" do
	owner "root"
	group "root"
	mode "0755"
	action :create
	recursive true
	not_if { File.directory?("#{datadir}") }
end

# Installing SOLR.
execute "installing-solr" do
	user "root"
	command "bin/install_solr_service.sh /tmp/solr-5.2.1.tgz -d #{datadir} -p #{port} -u #{solr_user}"
	cwd "/tmp/solr-5.2.1"
	not_if { File.exists?("/etc/init.d/solr") }
end

# Creating solr cores.
node.default['solr']['cores'].each do |core|
	coredir = "#{datadir}/data/#{core}"
	
	# Creating core data directory.
	directory "#{coredir}/data" do
		owner solr_user
		group solr_group
		mode "0755"
		action :create
		recursive true
		not_if { File.directory?("#{coredir}/data") }
	end
	
	# Creating core conf directory.
	directory "#{coredir}/conf" do
		owner solr_user
		group solr_group
		mode "0755"
		action :create
		recursive true
		not_if { File.directory?("#{coredir}/conf") }
	end
	
	# Creating configuration files.
	node['solr']['conf_files'].each do |file|
		cookbook_file "#{coredir}/conf/#{file}" do
			source "#{file}"
			owner solr_user
			group solr_group
			mode "0775"
			not_if { File.exists?("#{coredir}/conf/#{file}") }
		end
	end
	
	# Creating core properties.
	file "#{coredir}/core.properties" do
		content "name=#{core}"
		owner solr_user
		group solr_group
		mode "0775"
	end
	
	# Installing SOLR core.
	#execute "installing-solr-core-#{core}" do
		#user "root"
		#command "bin/solr create_core -c #{core} -p #{port}"
		#cwd "/tmp/solr-5.2.1"
		#not_if { File.directory?("#{datadir}/#{core}") }
	#end
end

# Creating solr.xml to persist cores.
cookbook_file "#{datadir}/data/solr.xml" do
  source "solr.xml"
  owner solr_user
  group solr_group
  mode "0775"
end

# Starting the solr service and enabling it on boot.
service "solr" do
	supports [ :restart, :start, :stop, :status ]
	action [ :enable, :restart ]
end