=begin
require_relative '../beans/time_bean'

require_relative '../beans/count_info_bean'
require_relative '../beans/test_suites_bean'
require_relative '../beans/test_plans_bean'

require_relative '../dao/test_suite_details_db'
require_relative '../dao/test_plan_details_db'
require_relative '../dao/test_case_details_db'
require_relative '../utils/handler_utils/'

class TestSuitesInfoHandlerccccccccccccccccccc

  @@testSuiteInfoHandler=TestSuitesInfoHandler.new();
  @testsuiteDetailsDBobj=TestSuiteDetailsDb.new();
  #provide only single object of home processor
  def self.getTestSuiteInfoHandler
    return @@testSuiteInfoHandler
  end

  #check if value is nil or its empty
  #value can be array or a string
  def checkNilOrEmpty(value,message)
    if(value == nil || value.length<=0) then
      raise(message);
    end
  end

  # returns TimeBean object containing startTime,EndTime,TotalTime
  def getTimebeanObj(startTime,endTime,totalTime)
    return TimeBean.new(startTime,endTime,totalTime);
  end


  #bug in selecting testsuiteExecuted-------------
  # returns the testsuitebean object when passed testSuiteName
  def getTestSuiteInfoBean(testSuiteName)
    #need to check negative scenarios
    #getSuite Id basedon suiteName given
    testsuiteId =@testsuiteDetailsDBobj.getTestSuiteId(testSuiteName);
    #gettting suite Executed object is not perfect need to fix
    Rails.logger.info("selected testsuites Id #{testsuiteId}");
    testSuiteExectedObj=@testsuiteDetailsDBobj.getSuiteExectedObj(testsuiteId);
    #now use suiteObject and build time bean object
    return testSuitesBean = constructSuiteBean(testSuiteExectedObj);
  end
  
  # returns the testsuitebean object when passed suiteExecutedId
  def getTestSuiteBean(suiteExecutedId)
   testSuiteExectedObj = @testsuiteDetailsDBobj.getSuitExecutedObject(suiteExecutedId);
   return testSuitesBean = constructSuiteBean(testSuiteExectedObj);
  end
  
  #construct and return the testsuiteBean by talking TestSuite ActiveRecord Object of particular suiteExecuteId
  def constructSuiteBean(testSuiteExectedObj)
     timebean=getTimebeanObj(testSuiteExectedObj.starttime,
    testSuiteExectedObj.endtime,testSuiteExectedObj.totaltime);

    testplanDetailsDbObj=TestPlanDetailsDb.new();
    #getPlansExecuecd for the suite execution requested
    plansExecutedList= testplanDetailsDbObj.getplanExecutedObjects(
    testSuiteExectedObj.testsuite_executed_id);
    #constructing testsuiteBean here
    testSuitesBean=TestSuitesBean.new(
    testSuiteName,testSuiteExectedObj.environment,testSuiteExectedObj.build_number,
    testSuiteExectedObj.servername,timebean,getPlansBean(plansExecutedList))
    Rails.logger.info("testSuitesBean #{testSuitesBean} for testsuiteName
     #{testSuitesBean.suiteName}");
     return testSuitesBean;
  end

  #returns an list of testplanObjectsBean
  #returns argument itself if no return type found after iterater
  def getPlansBean(plansExecutedList)
    testplanDetailsDbObj=TestPlanDetailsDb.new();
    testPlanBeanList = Array.new
    distinctTestPlanIdList=Array.new
    if plansExecutedList
      plansExecutedList.each do |plan_executed|
        if plan_executed then
          testplanObj=testplanDetailsDbObj.getplanObj(plan_executed.test_plan_id);
          planName= testplanObj ? (testplanObj.plan_name):(raise "testplan object
           not loaded properly")
          #continue if team name exists
          if( distinctTestPlanIdList.include? planName)
          next;
          else
          distinctTestPlanIdList.push(planName);
          plan_info=TestPlansBean.new(testplanObj.plan_name,testplanObj.owner,
          HandlerUtils.getCountInfoBean(plan_executed.testplan_executed_id),
         plan_executed.test_suite_executed_id,plan_executed.test_plan_id);
        testPlanBeanList.push(plan_info);
        end
        end
      end
    end
    Rails.logger.info("testPlanBeanList returned #{testPlanBeanList}");
    return testPlanBeanList
  end

end
=end
