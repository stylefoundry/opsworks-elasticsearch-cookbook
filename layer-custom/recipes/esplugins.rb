script "install_plugin_es_hq" do
	interpreter "bash"
	user "root"
	cwd "#{node.elasticsearch[:dir]}/elasticsearch-#{node.elasticsearch[:version]}/bin/"
	code <<-EOH
  	plugin -install royrusso/elasticsearch-HQ
  	EOH
	not_if { File.exist?("#{node.elasticsearch[:dir]}/elasticsearch-#{node.elasticsearch[:version]}/plugins/HQ") }
end

#notifies :restart, 'service[elasticsearch]' unless node.elasticsearch[:skip_restart]
