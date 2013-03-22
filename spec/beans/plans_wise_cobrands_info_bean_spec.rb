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
  let(:suitename){"SmokeTestSuite"}
  before(:each) do
  #mocking object of cobrandInfoBean
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
    countbean1=double(CountInfoBean)
    countbean1.stub(:passedCount).and_return(10)
    countbean1.stub(:failedCount).and_return(10)
    countbean1.stub(:skippedCount).and_return(10)
    countbean1.stub(:executed).and_return(20)
    countbean1.stub(:totalCount).and_return(30)
    countbean2=double(CountInfoBean)
    countbean2.stub(:passedCount).and_return(1)
    countbean2.stub(:failedCount).and_return(1)
    countbean2.stub(:skippedCount).and_return(1)
    countbean2.stub(:executed).and_return(2)
    countbean2.stub(:totalCount).and_return(3)
    cobrandInfoBeanHash=Hash.new
    cobrandInfoBeanHash.store(:snapfish,countbean1)
    cobrandInfoBeanHash.store(:snapfishuk,countbean2)
 
    #mocking object of PlansWiseCobrandsInfoBean
    @expectedPlansWiseCobrandsInfoBeanObj =double(PlansWiseCobrandsInfoBean)
    @expectedPlansWiseCobrandsInfoBeanObj.stub(:cobrandInfoBeanHash).and_return(cobrandInfoBeanHash)
    @expectedPlansWiseCobrandsInfoBeanObj.stub(:testPlanExecutedIdList).and_return([1,2,3,4,5])
    @expectedPlansWiseCobrandsInfoBeanObj.stub(:environment).and_return(:env)
    @expectedPlansWiseCobrandsInfoBeanObj.stub(:release).and_return(:releaseNum)
    @expectedPlansWiseCobrandsInfoBeanObj.stub(:suiteName).and_return(:suitename);
    @actualplanWiseCobrandsInfoBean=PlansWiseCobrandsInfoBean.new(cobrandInfoBeanHash,:env,:releaseNum,:suitename)

  end

  describe "#new" do
    it "should have four arguments for initialize()" do
      doing{
        PlansWiseCobrandsInfoBean.new
      }.should raise_exception ArgumentError
    end
  end

  describe "#cobrandHash" do
    it "cobrandHash should match" do
      @expectedPlansWiseCobrandsInfoBeanObj.cobrandInfoBeanHash.should
      be_hash_matching(@actualplanWiseCobrandsInfoBean.cobrandInfoBeanHash)
      #array.should =~ another_array
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
      eq(@actualplanWiseCobrandsInfoBean.release)
    end
  end
  
  describe "#suiteName" do
    it "suiteName should match" do
      @expectedPlansWiseCobrandsInfoBeanObj.suiteName.should
      eq(@actualplanWiseCobrandsInfoBean.suiteName)
    end
  end


end