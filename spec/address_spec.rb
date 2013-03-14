$:.unshift File.expand_path('../lib', __FILE__)

require 'rspec'
require 'valid_addr.rb'

describe Address do

  subject{Address.new('24611 116th AVE SE')}

  it 'should have a number' do
    subject.number.should == 24611
  end

  it 'should have a name' do
    subject.name.should == '116'
  end

  it 'should put a suffix in the @suffix variable if it has one' do
    subject.suffix.should == 'TH'
  end


end