Blog.Views.SqatDashboard ||= {}

class Blog.Views.SqatDashboard.SuiteInfoView extends Backbone.View
  template : JST["backbone/templates/sqat_dashboard/suiteinfo"]
  
    tagName: "div"
    
   render: ->
   
    $(@el).text("Hello world!")
    return this
  