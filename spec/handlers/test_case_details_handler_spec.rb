require 'spec_helper'

require_relative '../../app/handlers/test_case_details_handler'
require_relative '../../app/beans/test_case_details_bean'
require_relative '../../app/beans/browser_test_case_details_bean'

describe TestCaseDetailsHandler do

  before(:each) do
  #@handler = double("TestCaseDetailsHandler")
    @handler=TestCaseDetailsHandler.new

  end

  it "checking the instance of class" do
    @handler.should be_an_instance_of(TestCaseDetailsHandler)
  end

  it "should raise an ArgumentError error if no parameters passed" do
    expect { @handler.getTestCaseDetailsBean }.to raise_error(ArgumentError)
  end

  it "should raise an ArgumentError error if no parameters passed" do
    expect { @handler.getTimebeanObj }.to raise_error(ArgumentError)
  end

  it "should return timebean when passed currect arguments" do
    timebeanobj=TimeBean.new("2013-02-07 17:04:47 UTC","2013-02-07 17:05:42 UTC","55 Secs")
    @handler.stub(:getTimebeanObj).and_return(timebeanobj)
    @handler.getTimebeanObj("2013-02-07 17:04:47 UTC","2013-02-07 17:05:42 UTC","55 Secs").should be(timebeanobj)
  end
  it "checking startTime" do
    timebeanobj=TimeBean.new("2013-02-07 17:04:47 UTC","2013-02-07 17:05:42 UTC","55 Secs")
    actual=@handler.getTimebeanObj("2013-02-07 17:04:47 UTC","2013-02-07 17:05:42 UTC","55 Secs")
    actual.startTime.should eq(timebeanobj.startTime)
  end

  it "Passing nil arguments to the getTimebeanObj should return timeben" do
    timebeanobj=TimeBean.new(nil,nil,nil)
    @handler.stub(:getTimebeanObj).and_return(timebeanobj)
    @handler.getTimebeanObj(nil,nil,nil).should be(timebeanobj)
  end

  it "checking return type" do
    timebean=TimeBean.new("2013-02-07 17:04:47 UTC","2013-02-07 17:05:42 UTC","55 Secs");
    case_info=TestCaseDetailsBean.new(2,"Verify secure page for Update Account conformation page(lite",
    "Passed","","","",timebean)
    testCaseDetailsBeanList=Array.new.push(case_info)
    browserwiseTestCase_info=BrowserTestCaseDetailsBean.new("firefox","","localhost:4444",testCaseDetailsBeanList)
    browserTestCaseDetailsBeanList=Array.new.push(browserwiseTestCase_info)
    @handler.stub(:getTestCaseDetailsBean).and_return(browserTestCaseDetailsBeanList)
    @handler.getTestCaseDetailsBean([271],"snapfish").should be(browserTestCaseDetailsBeanList)
  end

  it "cheching getTestcaseDetails method" do
    caseDetailsDBObj=TestCaseDetailsDb.new
    caseDetailsDBObj.stub(:getTestcaseDetails).and_return("activeRecordObj")
    caseDetailsDBObj.getTestcaseDetails().should eq("activeRecordObj")
  end

  it "cheching caseNo property" do
    actual=@handler.getTestCaseDetailsBean([485],"snapfish")
    actual.first.testCaseDetailsBeanList.first.caseNo.should eq("24")
  end
  
  it "checking browserName property" do
    actual=@handler.getTestCaseDetailsBean([485],"snapfish")
    actual.first.browserName.should eq("firefox")
  end
  
  it "cheching result property" do
    actual=@handler.getTestCaseDetailsBean([485],"snapfish")
    actual.first.testCaseDetailsBeanList.first.result.should eq("Failed")
  end

it "cheching description property" do
    actual=@handler.getTestCaseDetailsBean([485],"snapfish")
    actual.first.testCaseDetailsBeanList.first.description.should_not be_empty
  end
  
  it "cheching timeBean property" do
    actual=@handler.getTestCaseDetailsBean([485],"snapfish")
    actual.first.testCaseDetailsBeanList.first.timeBean.should_not be_nil
  end
  
  it "cheching failedReason property" do
    actual=@handler.getTestCaseDetailsBean([485],"snapfish")
    actual.first.testCaseDetailsBeanList.first.failedReason.should_not be_nil
  end
=begin

it "" do
timebean=TimeBean.new("2013-02-07 17:04:47 UTC","2013-02-07 17:05:42 UTC","55 Secs");
case_info=TestCaseDetailsBean.new(12,"Verify secure page for Update Account conformation page(lite",
"Passed","","","",timebean)
browserwiseTestCase_info=BrowserTestCaseDetailsBean.("firefox","","localhost:4444",testCaseDetailsBeanList)

order.calculate_total_price(stub(:price => 1.99),stub(:price => 2.99))

end
=end
end
