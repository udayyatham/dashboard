require_relative '../handlers/test_suites_info_handler.rb'
class SqatDashboardController < ApplicationController
#################  
#generate a random number before logging that error and redirect to userfriendly page
#
#################
  def testsuitesInfo
  @suiteName=params[:suiteName]
    testSuiteInfoHandlerObj=TestSuitesInfoHandler.getTestSuiteInfoHandler();
    @suiteInfoBean=testSuiteInfoHandlerObj.getTestSuiteInfoBeanbyName(@suiteName);
    @teamWiseSuitesHash=testSuiteInfoHandlerObj.getTeamWiseSuitesHash();
    logger.debug {"teamWiseSuitesHash #{@teamWiseSuitesHash}"};
    logger.debug {"testsuitesInfo #{@suiteInfoBean.inspect}"};
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @teamWiseSuitesHash }
    end
  end
  
  def testSuiteExecutedInfo
    @testSuiteExecutedId=params[:seid]
      puts "suitename:#{@testSuiteExecutedId}"
      testSuiteInfoHandlerObj=TestSuitesInfoHandler.getTestSuiteInfoHandler();
      @suiteInfoBean=TestSuitesInfoHandler.new.getTestSuiteInfoBean(@testSuiteExecutedId);
      respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @suiteInfoBean }
    end
  end
  
  def index1
    @TestSuites = TestSuite.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @TestSuites }
    end
  end
 
  
  def displaycobrandWise
    #if testplan clicked display all the cobrandwise browser
    # wise info with testcases failed ,passed,total,time
    planId=params[:pid]
    planId ||=raise "Expecting parameters"
    logger.info "testsplanId #{planId}"
    suiteExecutionId=params[:seid]
    suiteExecutionId ||=raise "Expecting parameters"
    logger.info "suiteExecutionId #{suiteExecutionId}"
    displayCobrandHandlerObj=DisplayCobrandHandler.new;
    @plansWiseCobrandsInfoBeanObj=displayCobrandHandlerObj.getCobrandWiseBrowswersInfo(
    suiteExecutionId,planId);
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @plansWiseCobrandsInfoBeanObj }
    end
    
  end


  def testCaseDetails
 
    testplanExecutedId=params[:tpeid]
    cobrand=params[:cobrand] #"snapfish"
    browser=params[:bsr]
    testcaseHandler=TestCaseDetailsHandler.new
    @browserwisetestCaseInfo=testcaseHandler.getTestCaseDetailsBean(testplanExecutedId,cobrand,browser)

  end


end