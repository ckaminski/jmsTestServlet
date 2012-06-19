<html>
<head>
 <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script> 
 <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.18/jquery-ui.min.js" ></script> 
 
<script type="text/javascript"> 
	$(document).ready(function() {
	   $.get('./jmsops/?action=jmsdata', function(data) { 
		  alert("data received: " + data); 
	   });
	 });
</script>


</head>
<body>
Connection Factory: <select name="CFactory"> <option value=""/> </select>  Custom: <input type="text" name="CFactoryCustom"/> <br/>
Source: <select name="Source"> <option value="" /> </select>  Custom: <input type="text" name="SourceCustom"/> <br/>
ReplyTo:  <select name="ReplyTo"> <option value=""/> </select>  Custom: <input type="text" name="ReplyToCustom"/> <br/>
<input type="radio" name="ConnectionType" value="Queue">Queue</input> 
<input type="radio" name="ConnectionType" value="Topic">Topic</input> 
<br/> 
 
</body>
</html>
