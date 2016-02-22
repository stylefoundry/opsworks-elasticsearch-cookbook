require_relative 'spec_helper'

shared_examples_for 'elasticsearch plugin' do |plugin_name, args = {}|
  expected_user = args[:user] || (package? ? 'root' : 'elasticsearch')
  expected_group = args[:group] || expected_user || 'elasticsearch'
  expected_home = args[:home] || (package? ? '/usr/share/elasticsearch' : '/usr/local/elasticsearch')
  expected_plugin = args[:plugin] || "#{expected_home}/plugins/#{plugin_name}"
  expected_response_code = args[:response_code] || 200

  describe file(expected_plugin) do
    it { should be_directory }
    it { should be_owned_by expected_user }
    it { should be_grouped_into expected_group }
  end

  describe command("curl -s -o /dev/null -w \"%{http_code}\" http://127.0.0.1:9200/_plugin/#{plugin_name}/") do
    its(:stdout) { should match(/#{expected_response_code}/) }
  end
end
