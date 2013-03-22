require 'spec_helper'

require_relative '../../app/models/test_plan_executed'

alias :doing :lambda
describe DisplayCobrandHandler do
  before(:each) do
    #get testplan executed Id based on suiteExecutedId and plan Id
    @testplanExecuted=mock(TestPlanExecuted);
    @testplanExecuted.stub(:environment).and_return("stg8")
    @testplanExecuted.stub(:release).and_return(123)
    @testplanExecuted.stub(:starttime).and_return("10:30am")
    @testplanExecuted.stub(:endtime).and_return("11:30am")
    @testplanExecuted.stub(:totaltime).and_return("1hr")
    @testplanExecuted.stub(:windows_host).and_return("localhost")
    @testplanExecuted.stub(:testplan_executed_id).and_return(442)
    @displayCobrandHandler=DisplayCobrandHandler.new
    TestPlanDetailsDb.any_instance.stub(:getTestPlanExecutedList).and_return(@testplanExecuted)
    
    
    #get all the records from TestcaseExecuted based on testplanExecutedId
    @testcaseExecuted1=mock(TestCaseExecuted);
    @testcaseExecuted1.stub(:cobrand).and_return("snapfish")
    @testcaseExecuted1.stub(:result).and_return("passed")
    @testcaseExecuted1.stub(:failed_reason).and_return("")
    @testcaseExecuted1.stub(:failed_url).and_return("")
    @testcaseExecuted1.stub(:test_plan_executed_id).and_return(5)
    @testcaseExecuted1.stub(:totaltime).and_return("30min")
    @testcaseExecuted1.stub(:starttime).and_return("10:30am")
    @testcaseExecuted1.stub(:endtime).and_return("11:00am")
    @testcaseExecuted1.stub(:browser).and_return("firefox")
    
    @testcaseExecuted2=mock(TestCaseExecuted);
    @testcaseExecuted2.stub(:cobrand).and_return("snapfish uk")
    @testcaseExecuted2.stub(:result).and_return("passed")
    @testcaseExecuted2.stub(:failed_reason).and_return("")
    @testcaseExecuted2.stub(:failed_url).and_return("")
    @testcaseExecuted2.stub(:test_plan_executed_id).and_return(2)
    @testcaseExecuted2.stub(:totaltime).and_return("30min")
    @testcaseExecuted2.stub(:starttime).and_return("11:00am")
    @testcaseExecuted2.stub(:endtime).and_return("11:30am")
    @testcaseExecuted2.stub(:browser).and_return("googlechrome")
    TestCaseDetailsDb.any_instance.stub(:getAllrecords).and_return([@testcaseExecuted1,@testcaseExecuted2]);
    
    
    #iterate all the testcaseExecuted records and  make a map of cobrands  ,ArrayList of browser Information 
    @browserInfoObj1 = double(BrowserInfoBean)
    @browserInfoObj1.stub(:testPlanExecutedId).and_return(@testcaseExecuted1.test_plan_executed_id)
    @browserInfoObj1.stub(:browser).and_return(@testcaseExecuted1.browser)
    @browserInfoObj1.stub(:windowsHost).and_return("localhost")
    timebean1=mock(TimeBean)
    #in this scenario only one testcase is considered to be executed for "FIREFOX" browser
    timebean1.stub(:startTime).and_return(@testcaseExecuted1.starttime)#first testcase start time
    timebean1.stub(:endTime).and_return(@testcaseExecuted1.endtime)#last testcase end time
    timebean1.stub(:totalTime).and_return("30min")#end time - start time 
    @browserInfoObj1.stub(:timeBean).and_return(timebean1)
    
    @browserInfoObj2 = double(BrowserInfoBean)
    @browserInfoObj2.stub(:testPlanExecutedId).and_return(@testcaseExecuted2.test_plan_executed_id)
    @browserInfoObj2.stub(:browser).and_return(@testcaseExecuted2.browser)
    @browserInfoObj2.stub(:windowsHost).and_return("localhost")
    #in this scenario only one testcase is considered to be executed for "GOOGLE CHROME" browser
    timebean2=mock(TimeBean)
    timebean2.stub(:startTime).and_return(@testcaseExecuted2.starttime)#first testcase start time(if more than one testcase)
    timebean2.stub(:endTime).and_return(@testcaseExecuted2.endtime)#last testcase end time(if more than one testcase)
    timebean2.stub(:totalTime).and_return("30min")#end time - start time (above)
    @browserInfoObj2.stub(:timeBean).and_return(timebean2)
    
    #ArrayList of browser Information actually for all browsers (but here only for firefox)
    browser_list_snapfish =Array.new
    browser_list_snapfish.push(@browserInfoObj1);

    #for google chrome only
    browser_list_snapfishUk =Array.new
    browser_list_snapfishUk.push(@browserInfoObj2);
    
    cobrandInfoBean1=CobrandInfoBean.new(@testcaseExecuted1.cobrand,@testcaseExecuted1.test_plan_executed_id)
    cobrandInfoBean1.addBrowserInfoBean(browser_list_snapfish);
    
    cobrandInfoBean2=CobrandInfoBean.new(@testcaseExecuted2.cobrand,@testcaseExecuted2.test_plan_executed_id)
    cobrandInfoBean2.addBrowserInfoBean(browser_list_snapfishUk);
    
    @CobrandWiseBrowserListHash=Hash.new
    @CobrandWiseBrowserListHash.store(@testcaseExecuted1.cobrand,cobrandInfoBean1)
    #@CobrandWiseBrowserListHash.store(@testcaseExecuted2.cobrand,cobrandInfoBean2)
    
    #settting actual instance to return mocked data
  
  #mock data for ":getBrowserExecutionTime" of TestCaseDetailsDb db hit for method #getCobrandWiseBrowswersInfo  
    @timedata =mock();
    @timedata.stub(:starttime).and_return("11:00am")
    @timedata.stub(:endtime).and_return("11:30am")
    @timedata.stub(:totaltime).and_return("30min")
    TestCaseDetailsDb.any_instance.stub(:getBrowserExecutionTime).and_return([@timedata]);
    
         #mock data for ":getAllrecords" of TestCaseDetailsDb db hit for method #getCobrandWiseBrowswersInfo
     @browserData1=mock();
     @browserData1.stub(:browser).and_return("firefox")
     @browserData1.stub(:cobrand).and_return("snapfish")
     @browserData1.stub(:passcount).and_return("10")
     @browserData1.stub(:failedcount).and_return("1")
     @browserData1.stub(:skippedcount).and_return("0")
     
     @browserData2=mock();
     @browserData2.stub(:browser).and_return("firefox")
     @browserData2.stub(:cobrand).and_return("snapfish")
     @browserData2.stub(:passcount).and_return("10")
     @browserData2.stub(:failedcount).and_return("1")
     @browserData2.stub(:skippedcount).and_return("0")
     
    TestCaseDetailsDb.any_instance.stub(:getAllrecords).and_return([@browserData1,@browserData2]);
    
    #mock data for ":getTestPlanExecutedList" of TestPlanDetailsDb db hit for method #getCobrandWiseBrowswersInfo
    @testplanExecuted=mock();
    @testplanExecuted.stub(:testplan_executed_id).and_return(5)
    @testplanExecuted.stub(:windows_host).and_return("localhost")
    @testplanExecuted.stub(:environment).and_return("stg8")
    @testplanExecuted.stub(:release).and_return("v1")
    
    @testCaseExecuted=@browserData1
    @testplanExecutedId=@browserInfoObj1.testPlanExecutedId
    @windowsHost=@browserInfoObj1.windowsHost
    TestPlanDetailsDb.any_instance.stub(:getTestPlanExecutedList).and_return([@testplanExecuted]);
   
    #mock data for ":getSuiteName" of TestSuiteDetailsDb db hit for method #getCobrandWiseBrowswersInfo
    @suiteobj=mock()
    @suiteobj.stub(:suite_name).and_return("Smoke Test Suite")
    TestSuiteDetailsDb.any_instance.stub(:getSuiteName).and_return([@suiteobj]);
    
    ########## mocked above objects for db hits of #getCobrandWiseBrowswersInfo ########## 
    
    #prepared expected planexecuted object
    @expectedplansWiseCobrandsInfoBean=PlansWiseCobrandsInfoBean.new(
    @CobrandWiseBrowserListHash,@testplanExecuted.environment,@testplanExecuted.release,@suiteobj.suite_name)
  end

  #for getBrowserInfo bean method
  describe "#getBrowserInfoBean" do
    
    it "should return expected testPlanExecutedId" do
      testCaseExecuted=@browserData1
      testplanExecutedId=@browserInfoObj1.testPlanExecutedId
      windowsHost=@browserInfoObj1.windowsHost
      DisplayCobrandHandler.new.getBrowserInfoBean(testCaseExecuted,testplanExecutedId,windowsHost).testPlanExecutedId
      .should == @browserInfoObj1.testPlanExecutedId
    end
    it "should return expected browser" do
      testCaseExecuted=@browserData1
      testplanExecutedId=@browserInfoObj1.testPlanExecutedId
      windowsHost=@browserInfoObj1.windowsHost
      DisplayCobrandHandler.new.getBrowserInfoBean(testCaseExecuted,testplanExecutedId,windowsHost).browser.should eq @browserInfoObj1.browser
    end
    it "should return expected windowsHost" do
      testCaseExecuted=@browserData1
      testplanExecutedId=@browserInfoObj1.testPlanExecutedId
      windowsHost=@browserInfoObj1.windowsHost
      DisplayCobrandHandler.new.getBrowserInfoBean(testCaseExecuted,testplanExecutedId,windowsHost).windowsHost.should eq @browserInfoObj1.windowsHost
    end
    
    describe  "should return expected timeBean" do
    it "should correct startTime" do
      DisplayCobrandHandler.new.getBrowserInfoBean(
      @testCaseExecuted,@testplanExecutedId,@windowsHost).timeBean.startTime.should eq @browserInfoObj2.timeBean.startTime
    end
    it "should correct endTime" do
      DisplayCobrandHandler.new.getBrowserInfoBean(
      @testCaseExecuted,@testplanExecutedId,@windowsHost).timeBean.endTime.should eq @browserInfoObj2.timeBean.endTime
    end
    
    it "should correct totalTime" do
      DisplayCobrandHandler.new.getBrowserInfoBean(
      @testCaseExecuted,@testplanExecutedId,@windowsHost).timeBean.totalTime.should eq @browserInfoObj2.timeBean.totalTime
    end
      
    end
  end


  describe "#getCobrandWiseBrowswersInfo" do
    before(:each) do
       DisplayCobrandHandler.any_instance.stub(:getBrowserInfoBean).and_return(@browserInfoObj2)
    end
    it "should exist" do
      @displayCobrandHandler.should respond_to :getCobrandWiseBrowswersInfo 
    end
    
    it "should match expected hash keys in planWiseCobrandInfoBean" do
      DisplayCobrandHandler.new.getCobrandWiseBrowswersInfo(
      400,1).cobrandInfoBeanHash.keys.should eq    @expectedplansWiseCobrandsInfoBean.cobrandInfoBeanHash.keys
    end
    it "should match expected hash values cobrand should be same in planWiseCobrandInfoBean" do
      DisplayCobrandHandler.new.getCobrandWiseBrowswersInfo(
      400,1).cobrandInfoBeanHash["snapfish"].cobrandName.should eq @expectedplansWiseCobrandsInfoBean.cobrandInfoBeanHash["snapfish"].cobrandName
    end
    it "should match expected hash values cobrand should be same in planWiseCobrandInfoBean" do
      DisplayCobrandHandler.new.getCobrandWiseBrowswersInfo(
      400,1).cobrandInfoBeanHash["snapfish"].testPlanExecutedId.should eq @expectedplansWiseCobrandsInfoBean.cobrandInfoBeanHash["snapfish"].testPlanExecutedId
    end
    
    
  
    it "should match expected environment in planWiseCobrandInfoBean" do
      DisplayCobrandHandler.new.getCobrandWiseBrowswersInfo(
      400,1).environment.should eq @expectedplansWiseCobrandsInfoBean.environment
    end
    
       it "should match expected release in planWiseCobrandInfoBean" do
      DisplayCobrandHandler.new.getCobrandWiseBrowswersInfo(
      400,1).release.should eq @expectedplansWiseCobrandsInfoBean.release
    end
    
       it "should match expected suite_name in planWiseCobrandInfoBean" do
      DisplayCobrandHandler.new.getCobrandWiseBrowswersInfo(
      400,1).suiteName.should eq @expectedplansWiseCobrandsInfoBean.suiteName
    end
      
    
  end


end
