class TestCaseDetailsBean
  attr_reader :caseNo,:description,:result,:failedReason,:failedScreenShot,:failedUrl,:timeBean
  
  def initialize(caseNo,description,result,failedReason,failedScreenShot,failedUrl,timeBean)
    @caseNo=caseNo
    @description=description
    @result=result
    @failedReason=failedReason
    @failedScreenShot=failedScreenShot
    @failedUrl=failedUrl
    @timeBean=timeBean
  end
end