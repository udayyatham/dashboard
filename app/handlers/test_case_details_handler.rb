require_relative '../beans/time_bean'
require_relative '../beans/test_case_details_bean'
require_relative '../beans/browser_test_case_details_bean'
require_relative '../dao/test_case_details_db'
class TestCaseDetailsHandler


def getTestCaseDetailsBean(testplanExecutedId,cobrand,browser)
    
Rails.logger.info("Testcases to be retrieved for testplanExecutedId #{testplanExecutedId}");
    testCaseDetailsDb=TestCaseDetailsDb.new
  #  browserwiseTestCaseDetails=Hash.new
    browserTestCaseDetailsBeanList=Array.new
    raise "testplanId is expected" unless testplanExecutedId
    raise "cobrand is expected" unless cobrand
     
  #consider browser 
   casesRecord=if browser
      Rails.logger.info("testplanExecutedId #{testplanExecutedId} for -> cobrand #{cobrand}, and browser #{browser}");
      testCaseDetailsDb.getTestcaseDetails(testplanExecutedId,cobrand,browser)
    else
      Rails.logger.info("testplanExecutedId #{testplanExecutedId} for cobrand #{cobrand}");
      testCaseDetailsDb.getTestcaseDetails(testplanExecutedId,cobrand)
    end
      
      testCaseDetailsBeanList = Array.new
      browse=nil
      host=nil
      case_info=nil
      
      casesRecord.each do |caseInfo|
        caseNo=caseInfo.case_no
        caseDescription=caseInfo.case_description
        host=caseInfo.windows_host
        startTime=caseInfo.starttime
        endTime=caseInfo.endtime
        toatalTime=caseInfo.totaltime
        result=caseInfo.result
        failedReason=caseInfo.failed_reason
        failedUrl=caseInfo.failed_url
        failedSceenShot=caseInfo.failed_screenshot
        browse=caseInfo.browser

        timebean=getTimebeanObj(startTime,endTime,toatalTime)

        case_info=TestCaseDetailsBean.new(caseNo,caseDescription,result,failedReason,failedSceenShot,failedUrl,timebean)

        testCaseDetailsBeanList.push(case_info);
      end
        browserwiseTestCase_info=BrowserTestCaseDetailsBean.new(browse,nil,host,testCaseDetailsBeanList)
        browserTestCaseDetailsBeanList.push(browserwiseTestCase_info)
    
        return browserTestCaseDetailsBeanList;  
  end
  

  def getTimebeanObj(startTime,endTime,totalTime)
    return TimeBean.new(startTime,endTime,totalTime);
  end
  
end



=begin
  def getTestCaseDetailsBean(palnExecutedIDList,cobrand)
      puts "Nunber of plans executed: "
      print palnExecutedIDList.length
  
      testCaseDetailsDb=TestCaseDetailsDb.new
      browserwiseTestCaseDetails=Hash.new
      palnExecutedIDList.each do |planExecutedID|
  
        casesRecord=testCaseDetailsDb.getTestcaseDetails(planExecutedID,cobrand)
        testCaseBeanList = Array.new
        browse=nil
        casesRecord.each do |caseInfo|
          caseNo=caseInfo.case_no
          caseDescription=caseInfo.case_description
          host=caseInfo.windows_host
          startTime=caseInfo.starttime
          endTime=caseInfo.endtime
          toatalTime=caseInfo.totaltime
          result=caseInfo.result
          failedReason=caseInfo.failed_reason
          failedUrl=caseInfo.failed_url
          failedSceenShot=caseInfo.failed_screenshot
          browse=caseInfo.browser
  
          timebean=getTimebeanObj(startTime,endTime,toatalTime)
  
          case_info=TestCaseDetailsBean.new(caseNo,caseDescription,result,failedReason,failedSceenShot,failedUrl,timebean)
  
          testCaseBeanList.push(case_info);
        end
          browserwiseTestCaseDetails[browse]=testCaseBeanList
      end
          return browserwiseTestCaseDetails;  
    end
    
    def hello
    return TimeBean.new(startTime,endTime,totalTime);
  end
=end
