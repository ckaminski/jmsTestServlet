<html>
<head>
 <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script> 
 <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.18/jquery-ui.min.js" ></script> 
 
 <link rel="stylesheet" type="text/css" href="css/styles.css" />

<script type="text/javascript" src="js/dialog.js"></script>
 
<script type="text/javascript"> 

$(document).ready(function() {
   $.get('./jmsops/?action=jmsdata', function(data) { 
	  //alert("JMSDATA: " + data);
	  var strs = data.split(";"); 
	  for ( idx in strs ) {
		  var value =  strs[idx];
		  //alert("Using value: " + value);
		  $('#CFactory').append($('<option>', { value : value }).text(value)); 
		  $('#Source').append($('<option>', { value : value }).text(value)); 
		  $('#ReplyTo').append($('<option>', { value : value }).text(value)); 
	  }
	  
   });
 });
	
function startListener() { 
	var argumentStr = 'ConnFactoryName=' + $('#CFactory').val() + '&ReplyToName=' + $('#ReplyTo').val();
	var urlString = "./jmsops/?action=jmsmessages&" + argumentStr;
	alert("Using URLString " + urlString);
	$.ajax({ url: urlString, success: function(data){
		alert("we have data" + data);
		addMessageToSidebar(data);

    }, dataType: "json", complete: startListener, timeout: 30000 });
}

var dialogtext = '<div id="dialog-overlay"></div><div id="dialog-box"><div class="dialog-content">' + 
                 '<div id="dialog-message"></div><a href="#" id="dialog-button">Close</a></div></div>'; 
                 
function newMessage() { 
	window.alert("hello world alert");
	popup("hello world!");
}

function addMessageToSidebar( data ) { 
	var sidebar = $("#leftbar"); 
	sideBar.innerHTML += "hello world."; 
	
}


</script> 


</head>
<body>

<div id="topbar"> 
Connection Factory: <select id="CFactory" name="CFactory"> <option value=""/> </select>  Custom: <input type="text" name="CFactoryCustom"/> <br/>
Source: <select id="Source" name="Source"> <option value="" /> </select>  Custom: <input type="text" name="SourceCustom"/> <br/>
ReplyTo:  <select id="ReplyTo" name="ReplyTo"> <option value=""/> </select>  Custom: <input type="text" name="ReplyToCustom"/> <br/>
<input type="radio" name="ConnectionType" value="Queue">Queue</input> 
<input type="radio" name="ConnectionType" value="Topic">Topic</input> 
<input type="submit" name="submitbutton" value="Start Listening" onClick='startListener()'/>
<input type="button" name="newmsgbutton" value="New Message"     onClick='newMessage()' />
</div> 

<div id="leftbar"> 
asdf
</div> 

<div id="content"> 
asdf123
</div>
 
</body>
</html>
