class HandlerUtils
  # calculates passed,failed,skipped,total counts information and returns countInfoBean containing them
  def self.getCountInfoBean(testPlanExecutedId)
    testCaseDetailsDBObj=TestCaseDetailsDb.new();
    if(testPlanExecutedId==nil) then
      raise "Expecting Plan Executed Id"
    end
    passedCount = testCaseDetailsDBObj.getResultCount("Passed",testPlanExecutedId);
    failedCount = testCaseDetailsDBObj.getResultCount("Failed",testPlanExecutedId);
    skippedCount = testCaseDetailsDBObj.getResultCount("skipped",testPlanExecutedId);
    executedCount=(passedCount+failedCount);
    totalCasesCount= (passedCount+failedCount+skippedCount);

    Rails.logger.info("passedCount #{passedCount} , failedCount"+
    "#{failedCount}, skippedCount #{skippedCount}");
    countInfoObj=CountInfoBean.new(passedCount,failedCount,skippedCount,totalCasesCount,executedCount);
    return countInfoObj
  end

  def self.getCountInfoBeanCobrandWise(testPlanExecutedId,cobrand)
    testCaseDetailsDBObj=TestCaseDetailsDb.new();
    if(testPlanExecutedId==nil) then
      raise "Expecting Plan Executed Id"
    end
    passedCount = testCaseDetailsDBObj.getCobrandsWiseResult("Passed",testPlanExecutedId,cobrand);
    failedCount = testCaseDetailsDBObj.getCobrandsWiseResult("Failed",testPlanExecutedId,cobrand);
    skippedCount = testCaseDetailsDBObj.getCobrandsWiseResult("skipped",testPlanExecutedId,cobrand);
    executedCount=(passedCount+failedCount);
    totalCasesCount= (passedCount+failedCount+skippedCount);

    Rails.logger.info("passedCount #{passedCount} , failedCount"+
    "#{failedCount}, skippedCount #{skippedCount}");
    countInfoObj=CountInfoBean.new(passedCount,failedCount,skippedCount,totalCasesCount,executedCount);
    return countInfoObj
  end

end