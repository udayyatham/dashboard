class Blog.Models.Sample extends Backbone.Model
 

  defaults:
    suite_description: null
   suite_name: null
   suite_xml_file: null
   teamname: null
   testsuite_id_pk: null
   
class Blog.Collections.SampleCollection extends Backbone.Collection
  model: Blog.Models.Sample
 
