		var TeamsList = Backbone.View.extend({
			initialize : function() {
				this.teamsTemplate = $('#teamNames').children();
				//calling on initialize of object
				this.render();
				this.printSuites();
			},
			el : '#teamNames',
			events : {
				"change .select-team" : "printSuites"
			},

			printSuites : function() {
				var data = this.model.get('data');
				var selectedValue = document.getElementById("teamNameList").value;
				$('#suiteslist').empty();
				console.log("selected value" + selectedValue);
				for (var teamName in data) {
					if (teamName == selectedValue) {
						var suiteHash = data[teamName];
						var count = 0;
						var selectObj = document.getElementById("suiteslist");

						for (var suiteName in suiteHash) {
							//alert('suiteName '+suiteName);
							var suiteContainerDiv = document.createElement("div");
							suiteContainerDiv.id = "suiteContainerDiv" + (++count);
							var buttonSuiteAnchorDiv = document.createElement("div");
							buttonSuiteAnchorDiv.id = "buttonSuiteAnchorDiv" + count;
							buttonSuiteAnchorDiv.className = "navigation-node";
							var suiteNameAnchor = document.createElement("a");
							suiteNameAnchor.appendChild(document.createTextNode(suiteName));
							suiteNameAnchor.href = 'testSuiteExecutedInfo?seid=' + suiteHash[suiteName][0].suiteExecutedId;
							suiteNameAnchor.id='suiteExecuteLinkId'+ (++count);
							var button = document.createElement("button");
							button.appendChild(document.createTextNode('+'));
							button.id = 'suitebutton' + (count);
							button.className = "suitbutton";
							button.value = suiteName;
							buttonSuiteAnchorDiv.appendChild(button);
							buttonSuiteAnchorDiv.appendChild(suiteNameAnchor);
							suiteContainerDiv.appendChild(buttonSuiteAnchorDiv);
							var suitesHistoryMenuDiv = document.createElement("div");
							suitesHistoryMenuDiv.id = "suitesHistoryMenuDiv" + (count);
							suiteContainerDiv.appendChild(suitesHistoryMenuDiv);
							selectObj.appendChild(suiteContainerDiv);
						}

					}

				}

			},
			render : function() {
				var data = this.model.get('data');
				var index = 0;
				for (var key in data) {
					var selectObj = document.getElementById("teamNameList");
					var opt = document.createElement("option");
					opt.appendChild(document.createTextNode(key));
					if (index == 0) {
						opt.selected = 'selected'; ++index;
					}
					opt.value = key;
					selectObj.appendChild(opt);
				}
			}
		});