Blog.Views.SqatDashboard ||= {}

class Blog.Views.SqatDashboard.BrowserwiseInfoView extends Backbone.View
  template : JST["backbone/templates/sqat_dashboard/browserwiseinfo"]
  
    tagName: "div"
    
   render: ->
   
    $(@el).text("Hello world!")
    return this
  