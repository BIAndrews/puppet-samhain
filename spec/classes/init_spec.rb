require 'spec_helper'
describe 'samhain' do

  context 'with defaults for all parameters' do
    it { should contain_class('samhain') }
  end
end
