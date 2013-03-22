require 'spec_helper'

describe TestSuiteDetailsDb do

  before(:each) do
    TestSuiteDetailsDb.any_instance.stub(:getSuiteNames).and_return(['i18ntestsuits','smoketestsuite'])
    TestSuiteDetailsDb.any_instance.stub(:getTestSuiteId).and_return([1])
    @testSuiteExecutedObj=mock(TestSuiteExecuted)
    @testSuiteExecutedObj.stub(:browser).and_return('firefox')
    @testSuiteExecutedObj.stub(:build_number).and_return(1234)
    @testSuiteExecutedObj.stub(:build_param).and_return(12345)
    @testSuiteExecutedObj.stub(:test_suite_id).and_return(150)
    @testSuiteExecutedObj.stub(:testsuite_executed_id).and_return([2])
    @testSuiteExecutedObj.stub(:servername).and_return('localhost')
    @testSuiteExecutedObj.stub(:jenkins_id).and_return(5678)
    @testSuiteExecutedObj.stub(:executedBranch).and_return('Integration')
    @testSuiteExecutedObj.stub(:environment).and_return('stg8')
    @testSuiteExecutedObj.stub(:release).and_return(2.0)
    @testSuiteExecutedObj.stub(:starttime).and_return("9:30 am")
    @testSuiteExecutedObj.stub(:endtime).and_return("10:40 am")
    @testSuiteExecutedObj.stub(:totaltime).and_return("1hr 10mins")
    TestSuiteDetailsDb.any_instance.stub(:getSuiteExectedObj).and_return(@testSuiteExecutedObj)
    TestSuiteDetailsDb.any_instance.stub(:getSuiteName).and_return('SmokeTestSuite')
    TestSuiteDetailsDb.any_instance.stub(:getAllTeamNames).and_return(["use","cart"])
    
    @actualTestSuiteDetailsDbObj=TestSuiteDetailsDb.new
    
    
    @expectedTestSuiteDetailsDbObj=double(TestSuiteDetailsDb)
    @expectedTestSuiteDetailsDbObj.stub(:getSuiteExectedObj).and_return(@testSuiteExecutedObj)
    @expectedTestSuiteDetailsDbObj.stub(:getSuiteName).and_return('SmokeTestSuite')
    @expectedTestSuiteDetailsDbObj.stub(:getSuiteNames).and_return(['i18ntestsuits','smoketestsuite'])
    @expectedTestSuiteDetailsDbObj.stub(:getTestSuiteId).and_return([1])
    @expectedTestSuiteDetailsDbObj.stub(:getAllTeamNames).and_return(["use","cart"])
    
    
  end

  describe "#getSuiteNames" do
    it "should return suiteNames basTestSuiteDetailsDb.newed on team Name" do
      @expectedTestSuiteDetailsDbObj.getSuiteNames("sqat").should =~ (@actualTestSuiteDetailsDbObj.getSuiteNames)
    end
  end

  describe "#getTestSuiteId" do
    it "should return suiteNames based on team Name" do
      @expectedTestSuiteDetailsDbObj.getTestSuiteId("sqat").should =~ (@actualTestSuiteDetailsDbObj.getTestSuiteId)
    end
  end

  describe "#getSuiteExectedObj" do

    it "should return correct " do
      @testSuiteExecutedObj.browser.should 
      eq(@actualTestSuiteDetailsDbObj.getSuiteExectedObj.browser)
    end

    it "should return correct " do
      @expectedTestSuiteDetailsDbObj.getSuiteExectedObj.build_number.should 
      eq(@actualTestSuiteDetailsDbObj.getSuiteExectedObj.build_number)
    end

    it "should return correct " do
      @expectedTestSuiteDetailsDbObj.getSuiteExectedObj.build_param.should 
      eq(@actualTestSuiteDetailsDbObj.getSuiteExectedObj.build_param)
    end

    it "should return correct " do
      TestSuiteDetailsDb.new.getSuiteExectedObj.test_suite_id.should
       eq(@actualTestSuiteDetailsDbObj.getSuiteExectedObj.test_suite_id)
    end

    it "should return correct " do
      @expectedTestSuiteDetailsDbObj.getSuiteExectedObj.testsuite_executed_id.should 
      eq(@actualTestSuiteDetailsDbObj.getSuiteExectedObj.testsuite_executed_id)
    end

    it "should return correct " do
      @expectedTestSuiteDetailsDbObj.getSuiteExectedObj.servername.should
       eq(@actualTestSuiteDetailsDbObj.getSuiteExectedObj.servername)
    end

    it "should return correct " do
     @expectedTestSuiteDetailsDbObj.getSuiteExectedObj.jenkins_id.should 
     eq(@actualTestSuiteDetailsDbObj.getSuiteExectedObj.jenkins_id)
    end

    it "should return correct " do
      @expectedTestSuiteDetailsDbObj.getSuiteExectedObj.executedBranch.should 
      eq(@actualTestSuiteDetailsDbObj.getSuiteExectedObj.executedBranch)
    end

    it "should return correct " do
      @expectedTestSuiteDetailsDbObj.getSuiteExectedObj.environment.should 
      eq(@actualTestSuiteDetailsDbObj.getSuiteExectedObj.environment)
    end

    it "should return correct " do
      @expectedTestSuiteDetailsDbObj.getSuiteExectedObj.release.should 
      eq(@actualTestSuiteDetailsDbObj.getSuiteExectedObj.release)
    end

    it "should return correct " do
      @expectedTestSuiteDetailsDbObj.getSuiteExectedObj.starttime.should 
      eq(@actualTestSuiteDetailsDbObj.getSuiteExectedObj.starttime)
    end

    it "should return correct " do
      @expectedTestSuiteDetailsDbObj.getSuiteExectedObj.endtime.should 
      eq(@actualTestSuiteDetailsDbObj.getSuiteExectedObj.endtime)
    end

    it "should return correct " do
      @expectedTestSuiteDetailsDbObj.getSuiteExectedObj.totaltime.should 
      eq(@actualTestSuiteDetailsDbObj.getSuiteExectedObj.totaltime)
    end

  end

  describe "#getSuiteName" do
    it "should return suiteNames based on team Name" do
      @expectedTestSuiteDetailsDbObj.getSuiteName(2).should eq(@actualTestSuiteDetailsDbObj.getSuiteName)

    end
  end
  
  
  describe "#getUniqueTeamNames" do
    it "should return unique teamName" do
      @actualTestSuiteDetailsDbObj.getAllTeamNames.should =~ (@expectedTestSuiteDetailsDbObj.getAllTeamNames)
    end
    
  end

end