require 'spec_helper'

describe TestPlan do
 
  it { should respond_to(:testplan_id_pk) } 
  it { should respond_to(:owner) }
  it { should respond_to(:plan_description) }
  it { should respond_to(:plan_name) }
  it { should respond_to(:test_suite_id) }
  
end
