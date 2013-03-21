class HomeController < ApplicationController
  attr_accessor :teamname
  def home
    @suite_name = params[:suite_name]
    @suite_object = TestSuite.where(:suite_name => 'usetestsuite').all.first;

    suite_Executed_Id = TestSuiteExecuted.where(:test_suite_id =>@suite_object.testsuite_id_pk).select(:testsuite_executed_id).first #recent

    @test_suite_executed=TestSuiteExecuted.find(suite_Executed_Id)
   
    @test_plan_name = TestPlan.where(:test_suite_id => @suite_object.testsuite_id_pk).select(:plan_name)
    
    @plans_Executed = TestPlanExecuted.where(:test_suite_executed_id => suite_Executed_Id)


    @plans_info = Array.new
    
      @plans_Executed.each do |plan_executed|
      plan_info=TestSuitesPlanInfo.new
      test_plan_executed_id=plan_executed.testplan_executed_id
      plan_info.planName=TestPlan.where(:testplan_id_pk => plan_executed.test_plan_id).select(:plan_name).first.plan_name;
      plan_info.owner='sqat';
      plan_info.passedCount = 10;#TestCaseExecuted.count(:conditions =>"test_plan_executed_id =>1" )
      plan_info.failedCount = 1;#TestCaseExecuted.where("test_plan_executed_id =>? AND result =>? ",plan_executed.testplan_executed_id,"failed")
      plan_info.skippedCount = 1;#TestCaseExecuted.where("test_plan_executed_id =>? AND result =>? ",plan_executed.testplan_executed_id,"skipped")
      plan_info.totalCasesCount=12;
      @plans_info.push(plan_info) 
      end 
   end





  def home1
    @teamList = TestSuite.select(:teamname).uniq
    @team_name = params[teamnames]=='useteam'?'useteam':'sqatteam' # to get dynamic argument
    @suiteNamesOfTeam = TestSuite.where(:teamname => @team_name).select("suite_name")
  end

  def teamList

    #@teamList=TestSuite.select("teamname").uniq
  end

  def suiteList_of_team
    #@suites_list_of_team=TestSuite.find_by_teamname;
    #@suites_list_of_team=TestSuite.where("teamname = ?", params[:teamname])
    team_name = params[:teamname] # to get dynamic argument
    @suiteNamesOfTeam = TestSuite.where(:teamname => team_name).select("suite_name")
  end

  def suiteInfo
    # @suiteInfo=TestSuite.where(:id => user_id).pluck(:user_name)

    suite_Id = TestSuite.where("suite_name = ?", params[:suite_name]).pluck(:testsuite_id_pk)
    #suite_Executed_Id = TestSuite.where("test_suite_id = :suite_Id",{:suite_Id=>suite_Id}).pluck(:testsuite_executed_id)
    suite_Executed_Id = TestSuite.where("test_suite_id = suite_Id").pluck(:testsuite_executed_id)
    @suite_Info=TestSuite.find(suite_Executed_Id)
    @plans_Executed = TestSuite.find(suite_Executed_Id)
  end

  def planInfo
  end
end

class TestSuitesPlanInfo
  attr_accessor :planName,:failedCount,:passedCount,:skippedCount,:totalCasesCount,:owner
end