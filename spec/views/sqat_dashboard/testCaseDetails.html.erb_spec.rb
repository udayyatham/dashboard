require 'spec_helper'

describe "sqat_dashboard/testCaseDetails.html.erb" do
  before(:each) do
    timebean=TimeBean.new("2013-02-07 17:04:47 UTC","2013-02-07 17:05:42 UTC","55 Secs");
    @case_info=TestCaseDetailsBean.new(2,"Verify secure page for Update Account conformation page(lite",
    "Passed","","","",timebean)
    testCaseDetailsBeanList=Array.new.push(@case_info)
    browserwiseTestCase_info=BrowserTestCaseDetailsBean.new("firefox","","localhost:4444",testCaseDetailsBeanList)
    browserTestCaseDetailsBeanList=Array.new.push(browserwiseTestCase_info)
    @browserwisetestCaseInfo=browserTestCaseDetailsBeanList
  end

  it "should have mainDiv" do
    render
    rendered.should have_selector("div", :id => 'mainDiv');
    rendered.should have_selector("div", :id => 'subDiv2');
    rendered.should have_selector("div", :id => 'subDiv1');
  end

  it "should have 'Browser'" do
    render
    expect(rendered).to match'Browser';
  end

  it "should have 'Version:'" do
    render
    expect(rendered).to match 'Version';
  end

  it "should have 'Description:'" do
    render
    expect(rendered).to match'Description';
  end
  
  it "should have Remote Client Host" do
    render
    expect(rendered).to match'Remote Client Host';
  end
  it "should have Test Case ID" do
    render
    expect(rendered).to match'Test Case ID';
  end
  it "should have Snapcat Host" do
    render
    expect(rendered).to match'Snapcat Host';
  end
  
  it "should have 'Email Id Used'" do
    render
    expect(rendered).to match'Email Id Used';
  end
  
  it "should have div" do
    render
    rendered.should have_selector("div",:class =>'toolbar');
  end
  
  it "should have table" do
    render
    rendered.should have_selector("table",:width=>"99%"); 
  end
  it "should have table" do
    render
    rendered.should have_selector("table",:bgcolor =>"#CCCCCC");
  end
  it "should have tr" do
    render
    rendered.should have_selector("tr",:bgcolor =>"#FFFFFF");
  end
=begin
  it "should have 'Failure Reason'" do
    @case_info.stub(:result).and_return('Failed')
    render
    expect(rendered).to match'Failure Reason';
  end

  it "should have 'Failed URL'" do
     @case_info.stub(:result).and_return('Failed')
    render
    expect(rendered).to match'Failed URL';
  end
    
  it "should have 'Failed Screenshot URL'" do
    render
    expect(rendered).to match'Failed Screenshot URL';
  end
=end  
  
end
