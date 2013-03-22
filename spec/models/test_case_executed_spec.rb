require 'spec_helper'

describe TestCaseExecuted do
   
    it { should respond_to(:cobrand) } 
    it { should respond_to(:endtime) }
    it { should respond_to(:failed_reason) }
    it { should respond_to(:failed_screenshot) }
    it { should respond_to(:failed_url) }
    it { should respond_to(:result) }
    it { should respond_to(:starttime) }
    it { should respond_to(:testcase_executed_id) }
    it { should respond_to(:test_case_id) }
    it { should respond_to(:test_plan_executed_id) }
    it { should respond_to(:test_plan_id) }
    it { should respond_to(:test_suite_executed_id) }
    it { should respond_to(:test_suite_id) }
    it { should respond_to(:totaltime) }
   
   
end
