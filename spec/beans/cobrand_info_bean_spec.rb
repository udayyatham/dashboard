require 'spec_helper'

alias :doing :lambda

describe CobrandInfoBean do
  let(:cobrndName){"Snapfish"}

  let(:browserName){"firefox"}
  let(:testPlanExecId){200}
  let(:host){"localhost:4444"}

  before(:each) do
    @browserInfoObj1 = mock(BrowserInfoBean)
    @browserInfoObj1.stub(:testPlanExecutedId).and_return(:testPlanExecId)
    @browserInfoObj1.stub(:browser).and_return(:browserName)
    @browserInfoObj1.stub(:windowsHost).and_return(:host)
    timebean1=mock(TimeBean)
    timebean1.stub(:startTime).and_return("9:40am")
    timebean1.stub(:endTime).and_return("10:50am")
    timebean1.stub(:totalTime).and_return("1hr 10mins")
    @browserInfoObj1.stub(:timeBean).and_return(timebean1)

    @browserInfoObj2 = mock(BrowserInfoBean)
    @browserInfoObj2.stub(:testPlanExecutedId).and_return(:testPlanExecId)
    @browserInfoObj2.stub(:browser).and_return(:browserName)
    @browserInfoObj2.stub(:windowsHost).and_return(:host)
    timebean2=mock(TimeBean)
    timebean2.stub(:startTime).and_return("9:40am")
    timebean2.stub(:endTime).and_return("11:00am")
    timebean2.stub(:totalTime).and_return("1hr 20mins")
    @browserInfoObj2.stub(:timeBean).and_return(timebean2)
    #browserInfoBeanList
    @browserInfoBeanList=Array.new
    @browserInfoBeanList.push(@browserInfoObj1)
    @browserInfoBeanList.push(@browserInfoObj2)

    #mocking object of cobrandInfoBean
    @expectedCobrandInfoBeanObj = double(CobrandInfoBean)
    @expectedCobrandInfoBeanObj.stub(:cobrandName).and_return(:cobrndName)
    @expectedCobrandInfoBeanObj.stub(:browserInfoBeanList).and_return(@browserInfoBeanList)
    @expectedCobrandInfoBeanObj.stub(:testPlanExecutedId).and_return(200)
   
    #no setter method or constructor setting, for browserInfoBeanList
    #default it is Emty list just add objects to it using getter method
    @actualcobrandInfoBean=CobrandInfoBean.new(:cobrndName,200)
    @actualcobrandInfoBean.addBrowserInfoBean(@browserInfoObj1)
    @actualcobrandInfoBean.addBrowserInfoBean(@browserInfoObj2)

  end
  
  describe "#new" do
    it "should have two arguments for initialize()" do
      doing{
        CobrandInfoBean.new
      }.should raise_exception ArgumentError
    end
  end

  describe "#cobrandName" do
    it "returns the correct cobrandName" do
      @expectedCobrandInfoBeanObj.cobrandName.should eql @actualcobrandInfoBean.cobrandName
    end
  end

  describe "#browserInfoBeanList" do
    it "should return the correct browserInfoBeanList" do
      @expectedCobrandInfoBeanObj.browserInfoBeanList.should
      match_array(@actualcobrandInfoBean.browserInfoBeanList)
    end
  end

  describe "#testPlanExecutedId" do
    it "should return correct testPlanExecutedId" do
      @actualcobrandInfoBean.testPlanExecutedId.should eq @expectedCobrandInfoBeanObj.testPlanExecutedId
    end
  end

end