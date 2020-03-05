var INTERVAL = 2000; //Time between requests
var locked = false; //Lock to avoid a request while a previous one is been handled
var dictionary = createDictionary();
var port=id_game=="memGame"?"8080":"9090";
var ip = "localhost";
var url="http://"+ip+":"+port;//URL where the robot is listening
getIP();

function getIP(){
	ip = location.search.indexOf("?ip=")!==-1 ? location.search.replace("?ip=","") : "";
	if(ip.length == 0){
		$.ajax({
			url: 'http://freegeoip.net/json/',
			type: 'POST',
			dataType: 'jsonp',
			success: function(location) {
				var ipTablet = location.ip;
				console.log(ipTablet);
				var ipTokens = ipTablet.split(".");
				ip=ipTokens[0]+"."+ipTokens[1]+"."+ipTokens[2]+"."+(parseInt(ipTablet.split(".")[3])-50);
				console.log(ip);
				url="http://"+ip+":"+port;
				startPolling();
			}
		});
	}else{
		url="http://"+ip+":"+port;
		startPolling();
	}
}

function extractResponseContent(response,key){
	return response.substring(response.indexOf(key)).replace(key,"").replace(/\s+/g,'');
}

function handleReqContent(command){
	var reqContent = "";
	switch(id_game){
		case "memGame":
			reqContent = translateNumber(command);  	
			if(reqContent>0 && reqContent<=2*NUMBER_PAIRS) toggleCard('card'+reqContent);
			break;
		case "diffGame":
			reqContent = command;
			if(reqContent !== "-1")
				showDifference(reqContent);
			break;	
	}
	
}
function askForAction(){
	locked=true;
	var success=function(response){
		//console.out("ME RESPONDEN: "+response)
		var key = "";
		if(key==="CLOSE"){
			window.open("init.html","_self");
		}
		switch(phase){
			case 1:
				key="Level:";
				var level = translateNumber(extractResponseContent(response,key));  	
				if(level>0 && level<4) selectLevel(level);				
				break;
			case 2:
				key = "Requested content:";
				var command = extractResponseContent(response,key);
				if(command=="hint") getHint();
				else{
					handleReqContent(command);
				}	
				break;
			case 3:
				key="Restart:";
				var confirmation = extractResponseContent(response,key).toLowerCase();
				if(confirmation==="ok") reloadGame();
				break;
		}
		
		locked=false;
	};
	
	$.post(url,success);//,function(){locked=false;});
}
function startPolling(){
	changePhase(1)
	setInterval(function () {if(!locked) askForAction()}, INTERVAL);
}
function createDictionary(){
	var dic = new Array();
	dic["one"]=1;	dic["two"]=2;	dic["three"]=3;	dic["four"]=4;
	dic["five"]=5;	dic["six"]=6;	dic["seven"]=7;	dic["eight"]=8;
	dic["nine"]=9;  dic["ten"]=10;  dic["eleven"]=11; dic["twelve"]=12;
	dic["easy_level"]=1; dic["medium_level"]=2; dic["hard_level"]=3;
	return dic;
}
function translateNumber(numberName){
	return dictionary[numberName.toLowerCase()];
}
function changePhase(next){
	phase=next;
	$.post(url,{Phase: next});
}
function sendSuccess(found){
	$.post(url,{partialSuccess: found});
}
