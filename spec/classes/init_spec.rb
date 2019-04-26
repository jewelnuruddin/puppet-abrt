#require 'spec_helper'

#describe 'abrt' do
#  on_supported_os.each do |os, facts|
#    context "with defaults on #{os}" do
#      let(:facts) do
#        facts.merge({:puppetmaster => 'localhost.localdomain'})
#      end
#      let(:params) { { :package_ensure => 'installed' } }
#      it { should compile.with_all_deps }
#      it { should contain_class('abrt') }
#    end
#  end
#end

require 'spec_helper'
describe 'abrt' do

  context 'with defaults for all parameters' do
    it { should contain_package('abrt').with_ensure('present')}
    it { should contain_service('abrtd').with_ensure('running') }
  end

  context 'with active => "false"' do
    let(:params) { {:active => false } }
    it { should contain_service('abrtd').with_ensure('stopped') }
  end

end
