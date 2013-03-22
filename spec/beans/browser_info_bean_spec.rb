require 'spec_helper'

alias :doing :lambda

describe BrowserInfoBean do
  let(:browserName){"firefox"}
  let(:testPlanExecId){200}
  let(:host){"localhost:4444"}
  before(:each) do
  #mocking objects of browserInfoBean
    @browserInfoObj = mock(BrowserInfoBean)
    @browserInfoObj.stub(:testPlanExecutedId).and_return(:testPlanExecId)
    @browserInfoObj.stub(:browser).and_return(:browserName)
    @browserInfoObj.stub(:windowsHost).and_return(:host)
    timebean=mock(TimeBean)
    timebean.stub(:startTime).and_return("9:40am")
    timebean.stub(:endTime).and_return("10:50am")
    timebean.stub(:totalTime).and_return("1hr 10mins")
    @browserInfoObj.stub(:timeBean).and_return(timebean)
     countbean=double(CountInfoBean)
    countbean.stub(:passedCount).and_return(10)
    countbean.stub(:failedCount).and_return(10)
    countbean.stub(:skippedCount).and_return(10)
    countbean.stub(:executed).and_return(20)
    countbean.stub(:totalCount).and_return(30)
    @browserInfoObj.stub(:countBean).and_return(countbean)
    @actualBrowserInfoObj=BrowserInfoBean.new(:browserName,:testPlanExecId,:host,
    TimeBean.new("9:40am","10:50am","1hr 10mins"),CountInfoBean.new(10,10,10,30,20))
  end

  describe "#new" do
    it "should have two arguments for initialize()" do
      doing{
        BrowserInfoBean.new
      }.should raise_exception ArgumentError
    end
  end

  describe "#testPlanExecutedId" do
    it "returns the correct testPlanExecutedId" do
      @browserInfoObj.testPlanExecutedId.should == 
      @actualBrowserInfoObj.testPlanExecutedId
    #.should eql
    end
    it "both classes should match" do
      @browserInfoObj.testPlanExecutedId.should equal(:testPlanExecId)
    end
  end

  describe "#host" do
    it "returns the expected host" do
      @browserInfoObj.windowsHost.should eql(@actualBrowserInfoObj.windowsHost)
    #.should eql
    end
  end

  describe "#browser" do
    it "returns expected value of browser" do
      @browserInfoObj.browser.should eql(@actualBrowserInfoObj.browser)
    end
  end

  describe "#timeBean" do
    it "startTime should match" do
      @browserInfoObj.timeBean.startTime.should eql(
                                          @actualBrowserInfoObj.timeBean.startTime)
    end
    it "endTime should match" do
      @browserInfoObj.timeBean.endTime.should eql(
                                          @actualBrowserInfoObj.timeBean.endTime)
    end
    it "totalTime should match" do
      @actualBrowserInfoObj.timeBean.totalTime.should eql(@browserInfoObj.timeBean.totalTime)
    end
  end
    
     describe "#countBean" do
    it "should return the correct passedCount" do
      
      (@actualBrowserInfoObj.countBean.passedCount).should eq @browserInfoObj.countBean.passedCount
    end
    
    it "should return the correct failedCount" do
      (@actualBrowserInfoObj.countBean.failedCount).should eq @browserInfoObj.countBean.failedCount
    end
    
    it "should return the correct skippedCount" do
      (@actualBrowserInfoObj.countBean.skippedCount).should eq @browserInfoObj.countBean.skippedCount
    end
    
    it "should return the correct executedCount" do
      (@actualBrowserInfoObj.countBean.executed).should eq @browserInfoObj.countBean.executed
    end
    
    it "should return the correct totalCount" do

      (@actualBrowserInfoObj.countBean.totalCount).should eq @browserInfoObj.countBean.totalCount
    end
  end

end