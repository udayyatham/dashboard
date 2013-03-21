require_relative '../beans/time_bean'

require_relative '../beans/count_info_bean'
require_relative '../beans/test_suites_bean'
require_relative '../beans/test_plans_bean'

require_relative '../dao/test_suite_details_db'
require_relative '../dao/test_plan_details_db'
require_relative '../dao/test_case_details_db'
require_relative '../utils/handler_utils/'

class TestSuitesInfoHandler

  @@testSuiteInfoHandler=TestSuitesInfoHandler.new();
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
  def getTestSuiteInfoBeanbyName(testSuiteName)
    #need to check negative scenarios
    #getSuite Id basedon suiteName given
    testsuiteDetailsDBobj=TestSuiteDetailsDb.new();
    testsuiteId =testsuiteDetailsDBobj.getTestSuiteId(testSuiteName);
    #gettting suite Executed object is not perfect need to fix
    Rails.logger.info("selected testsuites Id #{testsuiteId}");
    testSuiteExectedObj=testsuiteDetailsDBobj.getSuiteExectedObj(testsuiteId);
    #now use suiteObject and build time bean object
    return testSuitesBean = constructSuiteBean(testSuiteExectedObj,testSuiteName);
  end
  
  # returns the testsuitebean object when passed suiteExecutedId
  def getTestSuiteInfoBean(suiteExecutedId)
    testsuiteDetailsDBobj=TestSuiteDetailsDb.new();
   testSuiteExectedObj = testsuiteDetailsDBobj.getSuitExecutedObject(suiteExecutedId);
   testSuite=testsuiteDetailsDBobj.getSuiteName(suiteExecutedId)
   return testSuitesBean = constructSuiteBean(testSuiteExectedObj[0],testSuite[0].suite_name);
  end
  
  #construct and return the testsuiteBean by talking TestSuite ActiveRecord Object of particular suiteExecuteId
  def constructSuiteBean(testSuiteExectedObj,testSuiteName)
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
 #returns Teamwise Suites Hash
  def getTeamWiseSuitesHash
    teamWiseSuitesHash=Hash.new();
    testsuiteDetailsDBobj=TestSuiteDetailsDb.new();
    #get All teamNames
    teamNames=testsuiteDetailsDBobj.getAllTeamNames
     raise "No teamNames found" unless teamNames
     teamNames.each do |testSuite|
       team=testSuite.teamname
       testSuitesHash=Hash.new();
       #get all suiteNames for TeamNames
       suiteNames=testsuiteDetailsDBobj.getSuiteNames(team);
       raise "No suiteNames found" unless suiteNames
       suiteNames.each do |suite|
          #getSuite Id basedon suiteName given
          testsuiteId =testsuiteDetailsDBobj.getTestSuiteId(suite.suite_name);
          raise "No testsuiteId found for #{suite}" unless testsuiteId     
          suiteId=testsuiteId[0].testsuite_id_pk
          Rails.logger.info("suiteId returned  #{suiteId}");
          testSuiteExecutedList=testsuiteDetailsDBobj.getNTestSuiteExecuted(suiteId,7);
          Rails.logger.info("testSuiteExecutedList returned  #{testSuiteExecutedList}");
          raise "Could Not retrieve testSuiteExecutedList #{suiteId}" unless testSuiteExecutedList
          testSuiteExecutedIdList=Array.new 
          testSuiteExecutedList.each do |testSuiteExecuted|
            suiteExecutedId=testSuiteExecuted.testsuite_executed_id
            Rails.logger.info("testSuiteExecutedId to be pushed  #{suiteExecutedId} for suiteName #{suite.suite_name}");
            testSuitesInfoForEachLink=TestSuitesInfoForLinks.new(suiteExecutedId,
                testSuiteExecuted.starttime,testSuiteExecuted.endtime)
                            
            testSuiteExecutedIdList.push(testSuitesInfoForEachLink);
          end
          #remove hash and store in a array of objects
       testSuitesHash.store(suite.suite_name,testSuiteExecutedIdList);
       end
      teamWiseSuitesHash.store(team,testSuitesHash);
     end
     return  teamWiseSuitesHash; 
  end
  

end