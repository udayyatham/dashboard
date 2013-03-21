class TestSuite < ActiveRecord::Base
  self.table_name = "test_suite"
  attr_accessible :suite_description, :suite_name, :suite_xml_file, 
  :teamname, :testsuite_id_pk
end
