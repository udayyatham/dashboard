require 'spec_helper'

describe TestSuite do
  
  before { @test_suite = TestSuite.new(testsuite_id_pk: "3", suite_description: "Suite description3", 
    suite_name: "suite name3", suite_xml_file: "Suite xml file3", teamname: "team name3")}
  
  subject { @test_suite }

  it { should respond_to(:testsuite_id_pk) } # @test_suite.should respond_to(:testsuite_id_pk)
  it { should respond_to(:suite_description) }
  it { should respond_to(:suite_name) }
  it { should respond_to(:suite_xml_file) }
  it { should respond_to(:teamname) }
end
