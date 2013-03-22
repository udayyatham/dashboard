require 'spec_helper'
describe ApplicationHelper do
  it "should return default title 'SQAT DashBoard', when pageTitle is empty" do
    ApplicationHelper::full_title("").should 
    eq('SQAT DashBoard')
  end
  
  it "should return default title 'SQAT DashBoard', when pageTitle is nil" do
     ApplicationHelper::full_title(nil).should 
    eq('SQAT DashBoard')
  end
  
  it "should append page_title to default title when page_title is provided" do
    ApplicationHelper::full_title("TestSuites Info").should 
    eq("SQAT DashBoard | TestSuites Info")
  end

end