require 'spec_helper'

require_relative '../../app/models/test_plan_executed'

alias :doing :lambda
describe DisplayCobrandHandler do

  let(:cname){"Snapfish"}
  let(:env){"stg8"}
  let(:releaseNum){"version 1"}

  let(:browserName){"firefox"}
  let(:testPlanExecId){271}
  let(:host){"localhost:4444"}

  context "getting cobrands" do
    before(:each) do
    #mocking object of cobrandInfoBean
      @browserInfoObj1 = mock(BrowserInfoBean)
      @browserInfoObj1.stub(:testPlanExecutedId).and_return(271)
      @browserInfoObj1.stub(:browser).and_return(:browserName)
      @browserInfoObj1.stub(:windowsHost).and_return(:host)
      @browserInfoObj1.stub(:timeBean).and_return(TimeBean.new("9:40am","10:50am","1hr 10mins"))
      @browserInfoObj1.stub(:countBean).and_return(CountInfoBean.new(2,0,0,2))
      
      
      BrowserInfoBean.new( browser,testPlanExecutedId,
    windowsHost,timeBeanObj,HandlerUtils.getCountInfoBean(testPlanExecutedId) );
      browserInfoObj2 = mock(BrowserInfoBean)
      browserInfoObj2.stub(:testPlanExecutedId).and_return(:testPlanExecId)
      browserInfoObj2.stub(:browser).and_return(:browserName)
      browserInfoObj2.stub(:windowsHost).and_return(:host)
      browserInfoObj2.stub(:timeBean).and_return(TimeBean.new("9:45am","10:50am","1hr 5mins"))
      browserInfoObj2.stub(:countBean).and_return(CountInfoBean.new(25,1,1,27))
      #browserInfoBeanList
      browserInfoBeanList=Array.new
      browserInfoBeanList.push(@browserInfoObj1)
      browserInfoBeanList.push(browserInfoObj2)

      #mocking object of cobrandInfoBean
      cobrandInfoBeanObj = double(CobrandInfoBean)
      cobrandInfoBeanObj.stub(:cobrandName).and_return(:cname)
      cobrandInfoBeanObj.stub(:browserInfoBeanList).and_return(browserInfoBeanList)

      testplanExecutedEntrySet=Hash.new
      testplanExecutedEntrySet[:starttime]="9:40am"
      testplanExecutedEntrySet[:endtime]="10:50am"
      testplanExecutedEntrySet[:totaltime]="1hr 10mins"
      testplanExecutedEntrySet[:browser]=:browserName
      testplanExecutedEntrySet[:testplanExecutedId]=271
      testplanExecutedEntrySet[:windowsHost]=:host

      @expectedDisplaycobrandhandlerObj = mock(DisplayCobrandHandler)
      @expectedDisplaycobrandhandlerObj.stub!(:getBrowserInfoBean).and_return(@browserInfoObj1)

      @actualDisplaycobrandhandlerObj=DisplayCobrandHandler.new
      @outputedgetBrowserInfoBean=@actualDisplaycobrandhandlerObj.getBrowserInfoBean(testplanExecutedEntrySet)

    end

    describe "getBrowserInfoBean" do

        describe "#testPlanExecutedId" do
          it "returns the correct testPlanExecutedId" do
            @expectedDisplaycobrandhandlerObj.getBrowserInfoBean.testPlanExecutedId.should ==
            @outputedgetBrowserInfoBean.testPlanExecutedId
          end
        end
  
        describe "#host" do
          it "returns the expected host" do
            @expectedDisplaycobrandhandlerObj.getBrowserInfoBean.windowsHost.should eql(
        @outputedgetBrowserInfoBean.windowsHost)
          #.should eql
          end
        end
  
        describe "#browser" do
          it "returns expected value of browser" do
            @expectedDisplaycobrandhandlerObj.getBrowserInfoBean.browser.should eql(
        @outputedgetBrowserInfoBean.browser)
          end
        end
  
        describe "#timeBean" do
          it "startTime should match" do
            @expectedDisplaycobrandhandlerObj.getBrowserInfoBean.timeBean.startTime.should eql(
                                            @outputedgetBrowserInfoBean.timeBean.startTime)
          end
          it "endTime should match" do
            @expectedDisplaycobrandhandlerObj.getBrowserInfoBean.timeBean.endTime.should eql(
                                            @outputedgetBrowserInfoBean.timeBean.endTime)
          end
          it "totalTime should match" do
            @expectedDisplaycobrandhandlerObj.getBrowserInfoBean.timeBean.totalTime.should eql(
                                           @outputedgetBrowserInfoBean.timeBean.totalTime)
          end
        end
  
        describe "#countBean" do
          it ":passedCount should match" do
            @expectedDisplaycobrandhandlerObj.getBrowserInfoBean.countBean.passedCount.should ==(
            @outputedgetBrowserInfoBean.countBean.passedCount)
          end
          it ":failedCount should match" do
            @expectedDisplaycobrandhandlerObj.getBrowserInfoBean.countBean.failedCount.should ==(
            @outputedgetBrowserInfoBean.countBean.failedCount)
          end
          it ":skippedCount should match" do
            @expectedDisplaycobrandhandlerObj.getBrowserInfoBean.countBean.skippedCount.should ==(
            @outputedgetBrowserInfoBean.countBean.skippedCount)
          end
  
          it ":totalCount should match" do
            @expectedDisplaycobrandhandlerObj.getBrowserInfoBean.countBean.totalCount.should ==(
            @outputedgetBrowserInfoBean.countBean.totalCount)
          end
  
        end
      end
  end
  

  
  describe "" do
  end

  
  describe "#gettestplanExecutedEntrySet" do
  end

  
  describe "#getBrowserWiseCobrandInfo" do
  end

  
end
