require 'spec_helper'

require_relative '../../app/beans/browser_test_case_details_bean'

describe BrowserTestCaseDetailsBean do
  before(:each) do
    @instance=BrowserTestCaseDetailsBean.new("firefox","12.0","localhost","testCaseDetailsBeanList")
  end

  it { @instance.should respond_to(:browserName) }
  it { @instance.should respond_to(:browserVersion) }
  it { @instance.should respond_to(:windowsHost) }
  it { @instance.should respond_to(:testCaseDetailsBeanList) }
  it "returns the correct browserName" do
    @instance.browserName.should eql "firefox"
  end
  it "returns the correct browserName" do
    @instance.browserVersion.should eql "12.0"
  end
  it "returns the correct browserName" do
    @instance.windowsHost.should eql "localhost"
  end
  it "returns the correct browserName" do
    @instance.testCaseDetailsBeanList.should eql "testCaseDetailsBeanList"
  end
end
