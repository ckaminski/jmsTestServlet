<html>
<head>
 <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script> 
 <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.18/jquery-ui.min.js" ></script> 
 
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
        //Update your dashboard gauge
        //salesGauge.setValue(data.value);

    }, dataType: "json", complete: startListener, timeout: 30000 });
}
</script>


</head>
<body>
Connection Factory: <select id="CFactory" name="CFactory"> <option value=""/> </select>  Custom: <input type="text" name="CFactoryCustom"/> <br/>
Source: <select id="Source" name="Source"> <option value="" /> </select>  Custom: <input type="text" name="SourceCustom"/> <br/>
ReplyTo:  <select id="ReplyTo" name="ReplyTo"> <option value=""/> </select>  Custom: <input type="text" name="ReplyToCustom"/> <br/>
<input type="radio" name="ConnectionType" value="Queue">Queue</input> 
<input type="radio" name="ConnectionType" value="Topic">Topic</input> 
<input type="submit" name="submitbutton" value="Start Listening" onClick='startListener()'/>
<br/> 
 
</body>
</html>
