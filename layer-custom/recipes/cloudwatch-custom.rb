# Create script that pushes custom metrics into Cloudwatch
instance = search("aws_opsworks_instance", "self:true").first
template_vars = {}
template_vars['region'] = instance['region']
template "/usr/local/bin/cloudwatch-custom.sh" do
  source "elasticsearch.cloudwatch-custom.sh.erb"
  mode "0550"
  owner "root"
  group "root"
  variables template_vars
end

# Cron it so that it runs every minute
#
cron "cloudwatch-custom" do
  hour "*"
  minute "*"
  weekday "*"
  command "/usr/local/bin/cloudwatch-custom.sh"
end

