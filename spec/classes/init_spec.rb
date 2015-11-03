require 'spec_helper'
describe 'abrt' do

  context 'with defaults for all parameters' do
    it { should contain_class('abrt') }
  end
end
