class Blog.Routers.SqatDashboardsRouter extends Backbone.Router
  initialize: (options) ->
    console.log('initialize method  ');
    alert("initialize method");
    @data = new Blog.Collections.SqatDashboardsCollection
    @data.reset options.param1
    alert("data"+@data);

  routes:
    "testsuitesInfo/:suitename"    : "testsuitesInfo"
    "displaycobrandWise/:pid/:seid" : "browserwiseInfo"
   
  testsuitesInfo: ->
    console.log("testsuitesInfo");
    alert("testsuitesInfo");
    @view = new Blog.Views.SqatDashboard.SuiteInfoView(collection: @data)
    $("#subdiv2").html(@view.render().el)
    alert("exit");
    
  browserwiseInfo: ->
    console.log("browserwiseInfo");
    alert("browserwiseInfo");
    @view = new Blog.Views.SqatDashboard.BrowserwiseInfoView(collection: @data)
    $("#subdiv2").html(@view.render().el)
    alert("exit");
    