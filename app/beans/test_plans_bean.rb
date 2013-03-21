class TestPlansBean
  attr_reader :planName,:owner,:countBean,:testSuiteExecutedId,:testPlanId
  def initialize(planName,owner,countBean,testSuiteExecutedId,testPlanId)
    @planName=planName;
    @owner=owner;
    @countBean=countBean;
    @testSuiteExecutedId=testSuiteExecutedId;
    @testPlanId=testPlanId;
  end
end