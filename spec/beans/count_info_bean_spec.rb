require 'spec_helper'
describe CountInfoBean do
  before(:each) do
    @expectedCountInfoBean=double(CountInfoBean)
    @expectedCountInfoBean.stub(:passedCount).and_return(10)
    @expectedCountInfoBean.stub(:failedCount).and_return(10)
    @expectedCountInfoBean.stub(:skippedCount).and_return(10)
    @expectedCountInfoBean.stub(:executed).and_return(20)
    @expectedCountInfoBean.stub(:totalCount).and_return(30)
    @actualCountInfoBean=CountInfoBean.new(10,10,10,30,20)
  end
  describe "#countBean" do
    it "should return the correct passedCount" do
      @expectedCountInfoBean.passedCount.should eq(@actualCountInfoBean.passedCount)
    end
    
    it "should return the correct failedCount" do
      @expectedCountInfoBean.failedCount.should eq(@actualCountInfoBean.failedCount)
    end
    
    it "should return the correct skippedCount" do
      @expectedCountInfoBean.skippedCount.should eq(@actualCountInfoBean.skippedCount)
    end
    
    it "should return the correct executedCount" do
      @expectedCountInfoBean.executed.should eq(@actualCountInfoBean.executed)
    end
    
    it "should return the correct totalCount" do
      @expectedCountInfoBean.totalCount.should eq(@actualCountInfoBean.totalCount)
    end
  end
end
