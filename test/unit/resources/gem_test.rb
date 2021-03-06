# encoding: utf-8
# author: Christoph Hartmann
# author: Dominik Richter
# author: Joe Nuspl

require 'helper'
require 'inspec/resource'

describe 'Inspec::Resources::Gem' do
  it 'verify gem package detail parsing' do
    resource = load_resource('gem', 'rubocop')
    pkg = {
      name: 'rubocop',
      version: '0.33.0',
      type: 'gem',
      installed: true,
    }
    _(resource.installed?).must_equal true
    _(resource.info).must_equal pkg
    _(resource.gem_binary).must_equal 'gem'
  end

  it 'specifying gem binary' do
    resource = load_resource('gem', 'pry', '/opt/ruby-2.3.1/embedded/bin/gem')
    pkg = {
      name: 'pry',
      version: '0.10.4',
      type: 'gem',
      installed: true,
    }
    _(resource.installed?).must_equal true
    _(resource.info).must_equal pkg
    _(resource.gem_binary).must_equal '/opt/ruby-2.3.1/embedded/bin/gem'
  end

  it 'verify gem in :chef' do
    resource = load_resource('gem', 'chef-sugar', :chef)
    pkg = {
      name: 'chef-sugar',
      version: '3.4.0',
      type: 'gem',
      installed: true,
    }
    _(resource.installed?).must_equal true
    _(resource.info).must_equal pkg
    _(resource.gem_binary).must_equal '/opt/chef/embedded/bin/gem'
  end

  it 'verify gem in :chef on windows' do
    resource = MockLoader.new(:windows).load_resource('gem', 'json', :chef)
    pkg = {
      name: 'json',
      version: '1.8.3',
      type: 'gem',
      installed: true,
    }
    _(resource.installed?).must_equal true
    _(resource.info).must_equal pkg
    _(resource.gem_binary).must_equal 'c:\opscode\chef\embedded\bin\gem'
  end

  it 'verify gem in :chef_server' do
    resource = load_resource('gem', 'knife-backup', :chef_server)
    pkg = {
      name: 'knife-backup',
      version: '0.0.12',
      type: 'gem',
      installed: true,
    }
    _(resource.installed?).must_equal true
    _(resource.info).must_equal pkg
    _(resource.gem_binary).must_equal '/opt/opscode/embedded/bin/gem'
  end
end
