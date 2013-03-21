class CobrandInfoBean
  attr_reader :cobrandName,:browserInfoBeanList,:testPlanExecutedId
  def initialize(cobrandName,testPlanExecutedId)
    @cobrandName=cobrandName;
    @testPlanExecutedId=testPlanExecutedId;
    @browserInfoBeanList=Array.new;
  end
  
  def addBrowserInfoBean(bean)
    @browserInfoBeanList.push(bean)
  end
end