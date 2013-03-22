require 'spec_helper'

describe TestSuitesInfoHandler do
  
  before(:each) do
    @testSuitesInfoHandler=TestSuitesInfoHandler.new
  end
  
  describe "#getTeamNeamWiseSuitesHash" do
    it "should be present" do
      @testSuitesInfoHandler.should respond_to :getTeamWiseSuitesHash 
    end
    it "keys should be equal" do
      @testSuitesInfoHandler.getTeamWiseSuitesHash.keys.should =~ {"sqat"=>{"Smoke Test Suite"=>[439], "FET Test Suite"=>[481]}}.keys
    end
    it "values should be equal" do
      @testSuitesInfoHandler.getTeamWiseSuitesHash.values.should =~ {"sqat"=>{"Smoke Test Suite"=>[439], "FET Test Suite"=>[481]}}.values
    end
  end
  
  
end