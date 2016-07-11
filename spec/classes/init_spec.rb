require 'spec_helper'

describe 'abrt' do
  context 'with defaults for all parameters on RedHat' do
    let :facts do
      {
        :kernel   => 'Linux',
        :osfamily => 'RedHat',
      }
    end

    context "on el6" do
      let :facts do
        super().merge({
          :operatingsystemmajrelease => '6',
        })
      end
      it { is_expected.to compile.with_all_deps }
      it { should contain_class('abrt') }
    end

    context "on el7" do
      let :facts do
        super().merge({
          :operatingsystemmajrelease => '7',
        })
      end
      it { is_expected.to compile.with_all_deps }
      it { should contain_class('abrt') }
    end
  end
end
