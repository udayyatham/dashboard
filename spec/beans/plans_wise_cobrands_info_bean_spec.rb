require 'spec_helper'

alias :doing :lambda

describe PlansWiseCobrandsInfoBean do

  let(:cname){"Snapfish"}
  let(:env){"stg8"}
  let(:releaseNum){"version 1"}

  let(:browserName){"firefox"}
  let(:testPlanExecId){200}
  let(:host){"localhost:4444"}
  let(:env){"stg8"}
  let(:releaseNum){"version 1"}

  before(:each) do
  #mocking object of cobrandInfoBean
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
    browserInfoBeanList=Array.new
    browserInfoBeanList.push(browserInfoObj1)
    browserInfoBeanList.push(browserInfoObj2)
    #mocking object of cobrandInfoBean
    cobrandInfoBeanObj = double(CobrandInfoBean)
    cobrandInfoBeanObj.stub(:cobrandName).and_return(:cname)
    cobrandInfoBeanObj.stub(:browserInfoBeanList).and_return(@browserInfoBeanList)


    #{key=> cobrands}
    #{value=> cobrandInfoBeanObj}
    cobrandInfoBeanList=Array.new
    cobrandInfoBeanList.push(cobrandInfoBeanObj)
    #mocking object of PlansWiseCobrandsInfoBean
    @expectedPlansWiseCobrandsInfoBeanObj =double(PlansWiseCobrandsInfoBean)
    @expectedPlansWiseCobrandsInfoBeanObj.stub(:cobrandInfoBeanList).and_return(cobrandInfoBeanList)
    @expectedPlansWiseCobrandsInfoBeanObj.stub(
    :testPlanExecutedIdList).and_return([1,2,3,4,5])
    @expectedPlansWiseCobrandsInfoBeanObj.stub(:environment).and_return(:env)
    @expectedPlansWiseCobrandsInfoBeanObj.stub(:release).and_return(:releaseNum)

    @actualplanWiseCobrandsInfoBean=PlansWiseCobrandsInfoBean.new(cobrandInfoBeanList,[1,2,3,4,5],:env,:releaseNum)

  end

  describe "#new" do
    it "should have four arguments for initialize()" do
      doing{
        PlansWiseCobrandsInfoBean.new
      }.should raise_exception ArgumentError
    end
  end

  describe "#environment" do
    it "environment should match" do
      @expectedPlansWiseCobrandsInfoBeanObj.environment.should
      be_hash_matching(@actualplanWiseCobrandsInfoBean.environment)
    end
  end
  describe "#release" do
    it "release should match" do
      @expectedPlansWiseCobrandsInfoBeanObj.release.should
      be_hash_matching(@actualplanWiseCobrandsInfoBean.release)
    end
  end

  describe "#cobrandHash" do
    it "cobrandHash should match" do
      @expectedPlansWiseCobrandsInfoBeanObj.cobrandInfoBeanList.should
      match_array(@actualplanWiseCobrandsInfoBean.cobrandInfoBeanList)
      #array.should =~ another_array
    end
  end

  describe "#testPlanExecutedId" do
    it "returns correct value of #testPlanExecutedId" do
      @expectedPlansWiseCobrandsInfoBeanObj.testPlanExecutedIdList.
      should =~ @actualplanWiseCobrandsInfoBean.testPlanExecutedIdList
    end
  end

end