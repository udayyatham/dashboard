require_relative '../models/test_case'
require_relative '../models/test_case_executed'
class TestCaseDetailsDb
  #returns the count of passed/failed/skipped
  def getResultCount(resultStatus,testPlanExecutedId)
    return TestCaseExecuted.count_by_sql("SELECT COUNT(*) FROM test_case_executed s WHERE
    s.test_plan_executed_id = #{testPlanExecutedId} AND s.result='#{resultStatus}'")
  #use single quotes for strings in sql query '  '
  #example :   ' #{variable} '
  end

  #returns list of cobrands based on suiteId and testPlanExecution Id
  def getCobrands(testPlanExecutedId,testSuiteExecutedId)
    return TestCaseExecuted.where(:test_suite_executed_id =>testSuiteExecutedId,
    :test_plan_executed_id =>testPlanExecutedId).select(:cobrand).uniq
  end

=begin
  Testcases are retrieved based on the testplanExecutedId,cobrand,browser
  if browser is not specified then all the browsers related testcases will be returned  
 @param planExecutedId
 @param cobrand
 @param browser
=end  
  def getTestcaseDetails(planExecutedId,cobrand,browser=nil)
    unless browser
    Rails.logger.info("All browsers")
    return TestCaseExecuted.find_by_sql("
    SELECT tce.result,tce.failed_reason,tce.failed_url,tce.failed_screenshot,
    tce.starttime,tce.endtime,tce.totaltime ,tce.browser,tpe.windows_host,tc.case_no,tc.case_description
    FROM Test_Case_Executed tce, Test_Plan_Executed tpe,Test_Case tc
    WHERE tce.test_plan_executed_id = tpe.testplan_executed_id AND
    tce.test_case_id = tc.TestCase_id_Pk AND 
    tce.cobrand='#{cobrand}'  
    AND tpe.testplan_executed_id=#{planExecutedId} 
    order by tce.result, tce.testcase_executed_id")
    end
    Rails.logger.info("Browser  Specificed : #{browser}");
    TestCaseExecuted.find_by_sql("
    SELECT tce.result,tce.failed_reason,tce.failed_url,tce.failed_screenshot,
    tce.starttime,tce.endtime,tce.totaltime ,tce.browser,tpe.windows_host,tc.case_no,tc.case_description
    FROM Test_Case_Executed tce, Test_Plan_Executed tpe,Test_Case tc
    WHERE tce.test_plan_executed_id = tpe.testplan_executed_id AND
    tce.test_case_id = tc.TestCase_id_Pk AND 
    tce.cobrand='#{cobrand}'  
    AND tpe.testplan_executed_id=#{planExecutedId} 
    And tce.browser='#{browser}'
    order by tce.result, tce.testcase_executed_id")
    
    end
  
  
  def getCobrandsWiseResult(resultStatus,testPlanExecutedId,cobrand)
    return TestCaseExecuted.count_by_sql("SELECT COUNT(*) FROM test_case_executed s WHERE
    s.test_plan_executed_id = #{testPlanExecutedId} AND s.result='#{resultStatus}' AND cobrand ='#{cobrand}'")
  end

  #returns list of cobrands based on testPlanExecution Id
  def getAllrecords(testPlanExecutedId)
    return TestCaseExecuted.find_by_sql("select cobrand, browser,
    COALESCE(sum(CASE WHEN result='Passed' THEN 1 ELSE 0  END),0) passcount, 
    COALESCE(sum(CASE WHEN result='Failed' THEN 1 ELSE 0  END),0) failedcount, 
    COALESCE(sum(CASE WHEN result='Skipped' THEN 1 ELSE 0  END),0) skippedcount 
    from test_case_executed where test_plan_executed_id =#{testPlanExecutedId} group by cobrand,
     browser order by cobrand, browser")
  end
  
    #get startime,endtime,totaltime of testplanExecution time in a particular browser
  def getBrowserExecutionTime(testPlanExecutedId,browser)
     return TestCaseExecuted.find_by_sql("select  starttime,endtime,starttime-endtime as totaltime 
     from(select min(starttime) as starttime ,max(endtime) as endtime  
     from test_case_executed where test_plan_executed_id =#{testPlanExecutedId} and browser='#{browser}')e")
  end
  
end