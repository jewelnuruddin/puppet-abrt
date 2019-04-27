require 'spec_helper'

describe 'abrt' do
  let(:title) { 'abrt' }
  let(:node) { 'localhost' }
#  it { is_expected.to compile }
#  it { is_expected.to compile.with_all_deps }
  context 'RedHat' do
    let(:facts) { {
      :osfamily => 'RedHat',
      :operatingsystem => 'CentOS'
      :architecture => 'x86_64',
    } }
   end
end

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
