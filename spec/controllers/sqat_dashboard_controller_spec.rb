require 'spec_helper'
require_relative '../../app/controllers/sqat_dashboard_controller' 

describe SqatDashboardController do

  
  describe "GET 'testCaseDetails'" do
=begin    
      it "returns http success" do
        get :testCaseDetails ,{:tpeid => [271],:cobrand => 'snapfish'}
        response.should be_success
      end
=end
  
  
    it "checking return type" do
      
      returnValue=SqatDashboardController.any_instance.stub(:testCaseDetails).and_return("testcase details")
      
      SqatDashboardController.new.testCaseDetails.should eq("testcase details")
    end
    
  end #describe testCaseDetails

end #describe SqatDashboardController