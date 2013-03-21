require_relative '../models/test_suite'
require_relative '../models/test_suite_executed'

class TestSuiteDetailsDb #DAO class

  #return the suite name based on Team name
  def  getSuiteNames(teamName)
    return TestSuite.select("suite_name").where("teamname = ?",teamName);
  end
  
  #returns all the team names
  def getTeamNames
    #return TestSuite.
  end
  
  def getTestSuiteId(suiteName)
       return TestSuite.where(:suite_name =>suiteName ).select(:testsuite_id_pk)
  end
  #returns suiteName based on SuiteExecutedId 
  def getSuiteName(suiteExecutedId)
    suiteExecutedObj=TestSuiteExecuted.select(:test_suite_id).where(:testsuite_executed_id =>suiteExecutedId)
    suiteId=suiteExecutedObj[0].test_suite_id
    return TestSuite.where(:testsuite_id_pk =>suiteId ).select(:suite_name)
  end
  
  #returns first record
  def getSuiteExectedObj(suiteId)
    return TestSuiteExecuted.find(:all,:conditions => { :test_suite_id =>suiteId}).last
  end
  def getSuitExecutedObject(suiteExecutedId)
    return TestSuiteExecuted.find(:all,:conditions => {:testsuite_executed_id =>suiteExecutedId})
  end
  def getSuiteName(testSuiteExecutedId)

  return TestSuite.find_by_sql("select suite_name from test_suite where testsuite_id_pk =(SELECT test_suite_id FROM test_suite_executed tse WHERE
    tse.testsuite_executed_id = #{testSuiteExecutedId} )")
  end
  
  
  #retrieves recent executed testsuites
  def getNTestSuiteExecuted(suiteId,records)
    return TestSuiteExecuted.find_by_sql("SELECT testsuite_executed_id,starttime,endtime  FROM test_suite_executed where test_suite_id= '#{suiteId}' ORDER BY endtime DESC LIMIT #{records}");
  end

    
  #returns all unique teamNames
  def getAllTeamNames
    return TestSuite.find_by_sql("select DISTINCT teamname from test_suite");
  end 
    


end