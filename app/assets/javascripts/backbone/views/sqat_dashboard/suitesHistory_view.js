		var SuitesList = Backbone.View.extend({
			initialize : function() {
				this.suitesTemplate = $('#suiteNames').children();
			},
			el : '#suiteNames',
			events : {
				"click button" : "render",
			},
			render : function(ev) {
				var recentSuiteExecutedDiv = document.getElementById($(ev.target).attr('id')).parentNode.nextSibling;
				console.log('clicked target\'s id: ' + $(ev.target).attr('id'));
				console.log('clicked target\'s, parent\'s id: ' + document.getElementById($(ev.target).attr('id')).parentNode.id);
				console.log('clicked on' + recentSuiteExecutedDiv.id);
				var data = this.model.get('data');
				var selectedValue = $(ev.target).val();
				if ($(ev.target).text() == '+') {
					$(ev.target).text("-");
					for (var teamName in data) {
						var suiteHash = data[teamName];
						for (var suiteName in suiteHash) {
							console.log("selected value : " + selectedValue + " (suiteName==selectedValue)" + (suiteName == selectedValue));
							if (suiteName == selectedValue) {
								suiteExecutedList = suiteHash[suiteName];
								//print only when clicked on button link in anchor tags gerating a link dynamically

								var historydiv = recentSuiteExecutedDiv;
								var ul = document.createElement("ul");
								var numCount = 0;
								for (var index = 0; index < suiteExecutedList.length; index++) {
									var suiteExecutedObj = suiteExecutedList[index];
									var li = document.createElement("li");
									var a = document.createElement("a");
									a.href = 'testSuiteExecutedInfo?seid=' + suiteExecutedObj.suiteExecutedId;
									a.id='suiteExecuteLinkId'+(++numCount);
									a.target = '_self';
									a.appendChild(document.createTextNode(suiteExecutedObj.startTime));
									li.appendChild(a);
									ul.appendChild(li);
								}
								historydiv.appendChild(ul);
								break;
							}
						}

					}
				} else {
					//clear the context
					$(ev.target).text("+");
					$("#" + recentSuiteExecutedDiv.id).empty();
				}

			}
			
		});