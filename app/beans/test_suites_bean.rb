class TestSuitesBean
  attr_reader :suiteName,:environment,:buildNumber,:automationServer,:timeBean,:testPlanBeanlist
  def initialize(suiteName,environment,buildNumber,automationServer,timeBean,testPlanBeanlist)
    @suiteName=suiteName;
    @environment=environment;
    @buildNumber=buildNumber;
    @automationServer=automationServer;
    @timeBean=timeBean;
    @testPlanBeanlist=testPlanBeanlist;
  end
end