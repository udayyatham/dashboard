require 'spec_helper'

describe TestPlanExecuted do
  
  it { should respond_to(:browser) } 
  it { should respond_to(:endtime) }
  it { should respond_to(:environment) }
  it { should respond_to(:release) }
  it { should respond_to(:starttime) }
  it { should respond_to(:testplan_executed_id) } 
  it { should respond_to(:test_plan_id) }
  it { should respond_to(:test_suite_executed_id) }
  it { should respond_to(:test_suite_id) }
  it { should respond_to(:totaltime) }
  it { should respond_to(:windows_host) }
end
