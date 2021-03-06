require 'spec_helper'

describe 'java::set_java_home' do
  context 'set_java_home'do
    let(:chef_run) do
      runner = ChefSpec::Runner.new
      runner.node.set['java']['java_home'] = '/opt/java'
      runner.converge(described_recipe)
    end
    it 'it should set the java home environment variable' do
      expect(chef_run).to run_ruby_block('set-env-java-home')
      expect(chef_run).to_not run_ruby_block('Set JAVA_HOME in /etc/environment')
    end

    it 'should create the profile.d directory' do
      expect(chef_run).to create_directory('/etc/profile.d')
    end

    it 'should create jdk.sh with the java home environment variable' do
      expect(chef_run).to render_file('/etc/profile.d/jdk.sh').with_content('export JAVA_HOME=/opt/java')
    end
  end

  context 'set_java_home_environment' do
    let(:chef_run) do
      runner = ChefSpec::Runner.new
      runner.node.set['java']['java_home'] = '/opt/java'
      runner.node.set['java']['set_etc_environment'] = true
      runner.converge(described_recipe)
    end
    it 'it should set the java home environment variable' do
      expect(chef_run).to run_ruby_block('set-env-java-home')
    end

    it 'should create the profile.d directory' do
      expect(chef_run).to create_directory('/etc/profile.d')
    end

    it 'should create /etc/environment with the java home  variable' do
      expect(chef_run).to run_ruby_block('Set JAVA_HOME in /etc/environment')
    end
  end
end
