elasticsearch_configure 'elasticsearch' do
  instance = search("aws_opsworks_instance", "self:true").first
  configuration ({
   'node.rack_id' => "#{instance['availability_zone']}"
  })
end
