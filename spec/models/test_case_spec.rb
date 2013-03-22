require 'spec_helper'

describe TestCase do
  
  it { should respond_to(:testcase_id_pk) } 
  it { should respond_to(:case_description) }
  it { should respond_to(:case_no) }
  it { should respond_to(:owner) }
  it { should respond_to(:test_plan_id) }
  it { should respond_to(:test_suite_id) }
end
