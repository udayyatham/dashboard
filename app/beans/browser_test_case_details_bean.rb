class BrowserTestCaseDetailsBean
  attr_reader  :browserName,:browserVersion,:windowsHost,:testCaseDetailsBeanList
  
  def initialize(browserName,browserVersion,windowsHost,testCaseDetailsBeanList)
      @browserName=browserName
      @browserVersion=browserVersion
      @windowsHost=windowsHost
      @testCaseDetailsBeanList=testCaseDetailsBeanList
  end
end