require 'spec_helper'

describe TestSuiteExecuted do
 
  it { should respond_to(:browser) } 
  it { should respond_to(:build_number) }
  it { should respond_to(:build_param) }
  it { should respond_to(:endtime) }
  it { should respond_to(:environment) }
  it { should respond_to(:executedbranch) } 
  it { should respond_to(:jenkins_id) }
  it { should respond_to(:build_param) }
  it { should respond_to(:release) }
  it { should respond_to(:starttime) }
  it { should respond_to(:test_suite_id) }
  it { should respond_to(:testsuite_executed_id) }
  it { should respond_to(:totaltime) }
end
