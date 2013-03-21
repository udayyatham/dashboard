		CobrandwisePlanInfoView = Backbone.View.extend({
		initialize : function() {
				this.suiteInfoTemplate = $('#suitedeatailsdiv').children();
			},
			el : '#suitedeatailsdiv',
		events : {
			"click #panlinfolink" : "getBean"

		},
		getBean : function(event) {
		
			var hrefValue = $("#panlinfolink").attr('href');
			var parameters = hrefValue.split("?");
			var individualParams = parameters[1].split("&");
			var param1 = individualParams[0].split("=");
			var param2 = individualParams[1].split("=");
			
			event.preventDefault();
			//alert("fetch function is called");
			var planModelFetch = new PlanModel({pid : 442,seid : 439});
			planModelFetch.urlRoot = planModelFetch.urlRoot + 'pid='+param1[1]+'&seid='+param2[1]
			planModelFetch.fetch({
				success : function(cobrandDetails) {
					//document.getElementById('back_button').style.display='';
					$('#back_button').css('display','');
					
					
					var planInfo_html="<div class='displaycobrandwise'>\
					<div class='infobar'>\
       				<label id='environment'>Environment : "+cobrandDetails.get('environment')+"</label>\
       				<label id='release'>Release : "+cobrandDetails.get('release')+"</label>\
        			<div class='clear'></div>\
    				</div>\
    				<div class='table-heading'>\
        			<ul><li class='col-1 heading'><b>Cobrand</b></li><li class='col-2 heading'><b>Browser</b></li><li class='col-3 heading'><b>Total Cases</b></li><li class='col-4 heading'><b>Executed</b></li><li class='col-5 heading green'><b>Passed</b></li><li class='col-6 heading red'><b>Failed</b></li></ul>\
        			<div class='clear'></div>\
   					</div>"
				    
					
					
					var cobrandBeanHash=cobrandDetails.get('cobrandInfoBeanHash');
					
					for (var key in cobrandBeanHash) { 
						
						var cobrandInfo_html=
						"<div class='cobrandDetails'>\
						<ul>\
       					<li class='col-1'>\
       					<a href='testCaseDetails?tpeid="+cobrandBeanHash[key].testPlanExecutedId+"&cobrand="+cobrandBeanHash[key].cobrandName+"'>\
                 		"+cobrandBeanHash[key].cobrandName+"</a>\
                 		 </li>\
                 		 <li class='colspan-5'>"
                 		 
                 		 var browserInfoBeanList=cobrandBeanHash[key].browserInfoBeanList;
                 		 
                 		 for(var i=0;i<browserInfoBeanList.length;i++){	
                 		 	var browserwiseCobrandInfo_html=
                 		 	"<div>\
                 		 	<ul class='repeatingcell clear'>\
                 		 	<li class='col-2' >\
                   			<a href='testCaseDetails?tpeid="+browserInfoBeanList[i].testPlanExecutedId+"&cobrand="+cobrandBeanHash[key].cobrandName+"\
                   			&bsr="+browserInfoBeanList[i].browser+"'>"+browserInfoBeanList[i].browser+"</a>\
                       		 </li>\
                       		 <li class='col-3'>"+browserInfoBeanList[i].countBean.totalCount+"</li>\
                       		 <li class='col-4'>"+browserInfoBeanList[i].countBean.executed+"</li>\
                 		 	 <li class='col-5'><font color=green>"+browserInfoBeanList[i].countBean.passedCount+"</font></li>\
                 		 	 <li class='col-6'><font color=red>"+browserInfoBeanList[i].countBean.failedCount+"</font></li>\
           					 </ul>\
           					 <div class='clear'></div>\
        					 </div>"
                 		 	cobrandInfo_html=cobrandInfo_html+browserwiseCobrandInfo_html;
                 		 }
                
						planInfo_html=planInfo_html+ cobrandInfo_html+ "</li></ul><div class='clear'></div></div>" ;
					}
					
					planInfo_html=planInfo_html+""+<%=link_to_function 'Back', 'history.back()'%>+"</div>"
					
									
					
					
					$('#suitedeatailsdiv').html(planInfo_html);
				}
			});
		}
	});