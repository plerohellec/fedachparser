require 'spec_helper'
require 'fedachparser'

class FedACHParser

  URL = 'http://www.fededirectory.frb.org/FedACHdir.txt'
  DBNAME = 'fedach'

  # Initialize and shutdown parser in all test except init tests
  RSpec.configure do |config|
    config.before(:each, :new => :false) do
      @f = FedACHParser.new URL, DBNAME, 'root', nil
    end

    config.after(:each, :new => :false) do
      @f.disconnect
    end
  end

  # test the constructor
  describe "new" do
    it "should instantiate" do
      lambda {
        @f = FedACHParser.new URL, DBNAME, 'root', nil
      }.should_not raise_exception
      @f.disconnect
    end

    it "should not instantiate if missing arguments" do
      lambda { FedACHParser.new }.should raise_exception
    end
  end

  # test the parsing independently
  describe "parse_line", :new => false do

    it "should extract routing number and name" do
      line = '011000015O0110000150020802000000000FEDERAL RESERVE BANK                1000 PEACHTREE ST N.E.              ATLANTA             GA303094470866234568111'
      # need to use send since the method is protected
      h = @f.send(:parse_line, line)
      h[:routing_number].should eq('011000015O')
      h[:name].should eq('FEDERAL RESERVE BANK                ')
    end

    it "should return nil for invalid data" do
      line = 'abcde'
      @f.send(:parse_line, line).should be nil
    end

  end

  # and finally the whole thing
  describe "download and parsing", :new => false do
    it "should not throw exception" do
      lambda {
        @f.download
        @f.store
      }.should_not raise_exception
    end
  end

end

