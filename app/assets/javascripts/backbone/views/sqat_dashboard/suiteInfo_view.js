SuiteInfoView = Backbone.View.extend({
			initialize : function() {
				this.suiteInfoTemplate = $('#suiteNames').children();
			},
			el : '#suiteNames',
			events : {
				"click a" : "getSuiteBean"
			},
			
			getSuiteBean :function(event){
		 	var hrefValue = $(event.target).attr('href');
		 	var parameters = hrefValue.split("?");
		 	//alert("parameters:"+parameters);
		 	var param=parameters[1].split("=")
		 	//alert("param:"+param[1]);
		 	event.preventDefault();
		 		var suiteModelFetch = new SuiteModel({seid:param[1]});
			suiteModelFetch.urlRoot = suiteModelFetch.urlRoot + 'seid='+param[1]
			suiteModelFetch.fetch({
				success : function(suiteDetails) {
					//alert("suiteDetails:"+suiteDetails);
					//var cobrand_html = "<span style='color:red'>" +  suiteDetails.get('automationServer') + "</span>";
					
					
			var cobrand_html="<table width='100%' border='0' cellpadding='4' cellspacing='1' bordercolor='#CCCCCC' \
			bgcolor='#CCCCCC'><tr bgcolor='#FFFFFF'><td width='20%'>TestSuite: </td><td width='80%'>"+ suiteDetails.get('suiteName')+"</td></tr> \
			<tr bgcolor='#FFFFFF'><td>Environment: </td><td>"+ suiteDetails.get('environment')+"</td></tr>\
			<tr bgcolor='#FFFFFF'><td>Build Number: </td><td>"+ suiteDetails.get('buildNumber')+"</td></tr> \
			<tr bgcolor='#FFFFFF'><td>Automation Server: </td><td>"+ suiteDetails.get('automationServer')+"</td></tr> \
			<tr bgcolor='#FFFFFF'><td>Start Time: </td><td>"+ suiteDetails.get('timeBean').startTime+"</td></tr> \
			<tr bgcolor='#FFFFFF'><td>End Time: </td><td>"+ suiteDetails.get('timeBean').endTime+"</td></tr> \
			<tr bgcolor='#FFFFFF'><td>Total Time: </td><td>"+ suiteDetails.get('timeBean').totalTime+" minutes </td></tr> \
			</table><br/><br/> \
			<table id='suiteInfo' width='100%' bordertestPlan_executed_id='0' cellpadding='0' cellspacing='0' bgcolor='#CCCCCC'> \
			<tr> \
			<td> \
			<table width='100%' border='0' cellspacing='1' cellpadding='1'> \
			<tr align='center'> \
				<td width='20%' height='30' bgcolor='#333333'><b><font color='#FFFFFF'>Plan Names</font></b></td> \
				<td width='20%' bgcolor='#333333'><b><font color='#FFFFFF'>Owner Name</font></b></td> \
				<td width='15%' bgcolor='#333333'><b><font color='#FFFFFF'>Total Cases</font></b></td> \
				<td width='15%' bgcolor='#333333'><b><font color='#FFFFFF'>Executed</font></b></td> \
				<td width='15%' bgcolor='#669933'><b><font color='#FFFFFF'>Passed</font></b></td> \
				<td width='15%' bgcolor='#FF3300'><b><font color='#FFFFFF'>Failed</font></b></td> \
			</tr>" ;
			
			for(var i=0;i<suiteDetails.get('testPlanBeanlist').length;i++){
				
				var plan_html= "<tr align='center' bgcolor='#FFFFFF'> \
				<td height='30'><a  id='panlinfolink' class='planInfo' href='displaycobrandWise?pid="+suiteDetails.get('testPlanBeanlist')[i].testPlanId+"\
				&seid="+suiteDetails.get('testPlanBeanlist')[i].testSuiteExecutedId+"'><b><u>"+suiteDetails.get('testPlanBeanlist')[i].planName+"</u></b></a></td> \
				<td>"+suiteDetails.get('testPlanBeanlist')[i].owner+"</td> \
				<td>"+suiteDetails.get('testPlanBeanlist')[i].countBean.totalCount+"</td> \
				<td>"+suiteDetails.get('testPlanBeanlist')[i].countBean.executed+"</td> \
				<td>"+suiteDetails.get('testPlanBeanlist')[i].countBean.passedCount+"</td> \
				<td>"+suiteDetails.get('testPlanBeanlist')[i].countBean.failedCount+"</td> </tr>";
				
				cobrand_html= cobrand_html+plan_html;
			}
			
				cobrand_html=cobrand_html+"</table>" ;
					$('#suitedeatailsdiv').html(cobrand_html);
				}
				
			});
		 }	
		});