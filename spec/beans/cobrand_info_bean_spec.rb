require 'spec_helper'

alias :doing :lambda

describe CobrandInfoBean do
  let(:cname){"Snapfish"}

  
  let(:browserName){"firefox"}
  let(:testPlanExecId){200}
  let(:host){"localhost:4444"}
  
  
  before(:each) do
    browserInfoObj1 = mock(BrowserInfoBean)
    browserInfoObj1.stub(:testPlanExecutedId).and_return(:testPlanExecId)
    browserInfoObj1.stub(:browser).and_return(:browserName)
    browserInfoObj1.stub(:windowsHost).and_return(:host)
    browserInfoObj1.stub(:timeBean).and_return(TimeBean.new("9:40am","10:50am","1hr 10mins"))
    browserInfoObj1.stub(:countBean).and_return(CountInfoBean.new(15,1,1,17))

    browserInfoObj2 = mock(BrowserInfoBean)
    browserInfoObj2.stub(:testPlanExecutedId).and_return(:testPlanExecId)
    browserInfoObj2.stub(:browser).and_return(:browserName)
    browserInfoObj2.stub(:windowsHost).and_return(:host)
    browserInfoObj2.stub(:timeBean).and_return(TimeBean.new("9:45am","10:50am","1hr 5mins"))
    browserInfoObj2.stub(:countBean).and_return(CountInfoBean.new(25,1,1,27))
    #browserInfoBeanList
    @browserInfoBeanList=Array.new
    @browserInfoBeanList.push(browserInfoObj1)
    @browserInfoBeanList.push(browserInfoObj2)
    
    #mocking object of cobrandInfoBean
    @expectedCobrandInfoBeanObj = double(CobrandInfoBean)
    @expectedCobrandInfoBeanObj.stub(:cobrandName).and_return(:cname)
    @expectedCobrandInfoBeanObj.stub(:browserInfoBeanList).and_return(@browserInfoBeanList)

    #no setter method or constructor setting, for browserInfoBeanList
    #default it is Emty list just add objects to it using getter method
    @actualcobrandInfoBean=CobrandInfoBean.new(:cname)
    @actualcobrandInfoBean.browserInfoBeanList.push(browserInfoObj1)
    @actualcobrandInfoBean.browserInfoBeanList.push(browserInfoObj2)
    
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

  describe "#browserInfoBeanList" do
    it "should return the correct browserInfoBeanList" do
      @expectedCobrandInfoBeanObj.browserInfoBeanList.should
      match_array(@actualcobrandInfoBean.browserInfoBeanList)
    end
  end


end