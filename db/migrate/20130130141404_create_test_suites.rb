class CreateTestSuites < ActiveRecord::Migration
  def change
    create_table :test_suites do |t|
      t.integer :testsuite_id_pk
      t.string :suite_name
      t.string :suite_xml_file
      t.string :teamname
      t.text :suite_description

      t.timestamps
    end
  end
end
