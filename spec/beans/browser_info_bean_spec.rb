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
    @browserInfoObj.stub(:timeBean).and_return(
                                      TimeBean.new("9:40am","10:50am","1hr 10mins"))
    @browserInfoObj.stub(:countBean).and_return(CountInfoBean.new(15,1,1,17))
    
    @actualBrowserInfoObj=BrowserInfoBean.new(
    :browserName,:testPlanExecId,:host,
    TimeBean.new("9:40am","10:50am","1hr 10mins"),CountInfoBean.new(15,1,1,17)
    )
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
      @browserInfoObj.timeBean.totalTime.should eql(
                                          @actualBrowserInfoObj.timeBean.totalTime)
    end
  end
  
    describe "#countBean" do
    it ":passedCount should match" do
      @browserInfoObj.countBean.passedCount.should ==(
                                        @actualBrowserInfoObj.countBean.passedCount)
    end
    it ":failedCount should match" do
      @browserInfoObj.countBean.failedCount.should ==(
                                        @actualBrowserInfoObj.countBean.failedCount)
    end
    it ":skippedCount should match" do
      @browserInfoObj.countBean.skippedCount.should ==(
                                        @actualBrowserInfoObj.countBean.skippedCount)
    end
    
    it ":totalCount should match" do
      @browserInfoObj.countBean.totalCount.should ==(
                                        @actualBrowserInfoObj.countBean.totalCount)
    end
    
  end
end