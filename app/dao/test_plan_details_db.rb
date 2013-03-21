require_relative '../models/test_plan'
require_relative '../models/test_plan_executed'
class TestPlanDetailsDb
  #returns the array of testplanExecuted objects of that particular suiteExecutedObj
  def getplanExecutedObjects(suiteExecutedObjId)
      return TestPlanExecuted.where(:test_suite_executed_id =>suiteExecutedObjId)
  end

  #get plan Obj of 
  def getplanObj(plansId)
    return TestPlan.find(plansId)
  end

  # Based on the suiteExecutedId,PlanId provided tuples are returned as list 
  # from TestPlanExecuted table
  def getTestPlanExecutedList(suiteExecutedId,planId)
       return TestPlanExecuted.where(:test_suite_executed_id =>suiteExecutedId,
       :test_plan_id =>planId).select([:browser,:environment, 
       :release, :starttime, :endtime, :totaltime, :windows_host,
       :testplan_executed_id])
  end
  
end