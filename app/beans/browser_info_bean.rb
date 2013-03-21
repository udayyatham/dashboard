class BrowserInfoBean
attr_reader :browser,:testPlanExecutedId,:windowsHost,:timeBean,:countBean
  def initialize(browser,testPlanExecutedId,windowsHost,timeBean,countBean)     
    @browser=browser;
    @testPlanExecutedId=testPlanExecutedId;
    @windowsHost=windowsHost;
    @timeBean=timeBean;
    @countBean=countBean;
  end
end    