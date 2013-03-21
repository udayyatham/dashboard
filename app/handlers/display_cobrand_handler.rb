require_relative '../beans/time_bean'

require_relative '../beans/count_info_bean'
require_relative '../beans/test_suites_bean'
require_relative '../beans/test_plans_bean'
require_relative '../beans/cobrand_info_bean'
require_relative '../beans/browser_info_bean'
require_relative '../beans/plans_wise_cobrands_info_bean'

require_relative '../dao/test_suite_details_db'
require_relative '../dao/test_plan_details_db'
require_relative '../dao/test_case_details_db'

require_relative '../utils/handler_utils/'
class DisplayCobrandHandler
  
  
=begin
 Based on input , cobrand wise for every browser -> testcaseExecution's passed,failed,skipped counts 
 are retrieved and stored in cobrandWiseBrowswerHash
 @param suiteExecutedId
 @param planId
 @return cobrandWiseBrowswerHash
=end
  def getCobrandWiseBrowswersInfo(suiteExecutedId,planId)
    testplanExecutedObj=TestPlanDetailsDb.new.getTestPlanExecutedList(suiteExecutedId,planId);
    raise "Testplan Executed object not found" unless testplanExecutedObj
    raise "Expecting single Testplan Executed object" if testplanExecutedObj.length > 1
    testplanExecutedId=testplanExecutedObj[0].testplan_executed_id
     Rails.logger.info("testplanExecutedId #{testplanExecutedId}");
    #returns cobrands -> browserwise -> passed,failed,skipped counts of testcases Executed
    testCaseExecutedList=TestCaseDetailsDb.new.getAllrecords(testplanExecutedId);
    cobrandWiseBrowswerHash=Hash.new
    
    testCaseExecutedList.each do |testCaseExecuted|
      cobrandName=testCaseExecuted.cobrand;
      Rails.logger.info("cobrandName #{cobrandName}");
      browserInfobean=getBrowserInfoBean(testCaseExecuted,
            testplanExecutedId,testplanExecutedObj[0].windows_host);
      cobrandInfobean=cobrandWiseBrowswerHash.fetch(cobrandName,nil);
    
      if !(cobrandInfobean) then
        cobrandInfobean=CobrandInfoBean.new(cobrandName,testplanExecutedId)
        cobrandInfobean.addBrowserInfoBean(browserInfobean)
        cobrandWiseBrowswerHash.store(cobrandName,cobrandInfobean)
        Rails.logger.info("cobrand stored in cobrandWiseBrowswerHash #{cobrandName}");
      else
      # Every, testplanExecutionId : browser-wise, will not have double entry of cobrands
        Rails.logger.info("cobrand already exists : #{cobrandName} add info of browser #{browserInfobean.browser}");
        cobrandInfobean.addBrowserInfoBean(browserInfobean);
      end
    end
    suiteName=TestSuiteDetailsDb.new.getSuiteName(suiteExecutedId)[0].suite_name;
    plansWiseCobrandsInfoBeanObj=PlansWiseCobrandsInfoBean.new(cobrandWiseBrowswerHash,
    testplanExecutedObj[0].environment,testplanExecutedObj[0].release,suiteName);
    return plansWiseCobrandsInfoBeanObj;
  end
  
  #returns the browserInfoBean
  def getBrowserInfoBean(testCaseExecuted,testplanExecutedId,windowsHost)
      browser=testCaseExecuted.browser
      passedCount=testCaseExecuted.passcount.to_i
      failedCount=testCaseExecuted.failedcount.to_i
      skippedCount=testCaseExecuted.skippedcount.to_i 
      #gets startime,endtime,totaltime of testplanExecution time in a particular browser 
      browserExecutionTime=TestCaseDetailsDb.new.getBrowserExecutionTime(testplanExecutedId,browser);
      raise "browserExecutionTime not found" unless browserExecutionTime
      #time
      timeBeanObj=TimeBean.new(browserExecutionTime[0].starttime,browserExecutionTime[0].endtime,
      browserExecutionTime[0].totaltime)
      #passed,failed,skipped count
      countBean=CountInfoBean.new(passedCount,failedCount,skippedCount,
      (passedCount+failedCount+skippedCount),(passedCount+failedCount));
      
      #browser info
      browserInfobean=BrowserInfoBean.new(browser,testplanExecutedId,
      windowsHost,timeBeanObj,countBean);
      return browserInfobean;
  end

end