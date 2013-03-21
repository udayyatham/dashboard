require 'spec_helper'

require_relative '../../app/beans/test_case_details_bean'

describe TestCaseDetailsBean do
  before(:each) do
    @instance=TestCaseDetailsBean.new("12","description","Passed","failedReason","failedScreenShot","failedUrl","timeBean")
  end

  it { @instance.should respond_to(:caseNo) }
  it { @instance.should respond_to(:description) }
  it { @instance.should respond_to(:result) }
  it { @instance.should respond_to(:failedReason) }
  it { @instance.should respond_to(:failedScreenShot) }
  it { @instance.should respond_to(:failedUrl) }
  it { @instance.should respond_to(:timeBean) }

  it "returns the correct caseNo" do
    @instance.caseNo.should eql "12"
  end
  it "returns the correct description" do
    @instance.description.should eql "description"
  end
  it "returns the correct result" do
    @instance.result.should eql "Passed"
  end
  it "returns the correct failedReason" do
    @instance.failedReason.should eql "failedReason"
  end
  it "returns the correct failedScreenShot" do
    @instance.failedScreenShot.should eql "failedScreenShot"
  end
  it "returns the correct failedUrl" do
    @instance.failedUrl.should eql "failedUrl"
  end
  it "returns the correct timeBean" do
    @instance.timeBean.should eql "timeBean"
  end
end
