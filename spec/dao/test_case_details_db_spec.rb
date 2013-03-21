require 'spec_helper'

describe TestCaseDetailsDb do
  
  before(:each) do
    @testCaseDetailsDBOBJ=TestCaseDetailsDb.new
    @caseActiveRecord=@testCaseDetailsDBOBJ.getTestcaseDetails(485,'snapfish')
  end
  it "checking the instance of class" do
    @testCaseDetailsDBOBJ.should be_an_instance_of(TestCaseDetailsDb)
  end
  
  it "should raise an ArgumentError error if no parameters passed" do
    expect { @testCaseDetailsDBOBJ.getTestcaseDetails(271) }.to raise_error(ArgumentError)
  end
  
  it "Checking the ActiveRecord attribute result" do
    @caseActiveRecord.first.result.should eq('Failed')
  end
  
   it "Checking the ActiveRecord attribute case_no" do
    @caseActiveRecord.first.case_no.should eq("24")
  end
  
  it "Checking the ActiveRecord attribute failed_reason" do
    @caseActiveRecord.first.failed_reason.should_not be_nil
  end
  
  it "Checking the ActiveRecord attribute case_description" do
    @caseActiveRecord.first.case_description.should_not be_empty
  end
  
  it "Checking the ActiveRecord attribute failed_screenshot" do
    @caseActiveRecord.first.failed_screenshot.should_not be_nil
  end
  
  it "Checking the ActiveRecord attribute failed_url" do
    @caseActiveRecord.first.failed_url.should_not be_nil
  end
  
  it "Checking the ActiveRecord attribute starttime" do
    @caseActiveRecord.first.starttime.should_not be_nil
  end
  
  it "Checking the ActiveRecord attribute endtime" do
    @caseActiveRecord.first.endtime.should_not be_nil
  end
  
  it "Checking the ActiveRecord attribute totaltime" do
    @caseActiveRecord.first.totaltime.should_not be_nil
  end
  
end
 