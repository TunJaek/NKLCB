<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMBER JOIN :: Employee Step</title>
<script src="resources/js/common.js"></script>
<link rel="stylesheet" href="resources/css/mainpos.css">
<link rel="stylesheet" href="resources/css/common.css">
</head>
<body onLoad="pageInit('${param.message}')">
<div id="headerBox">
		    <div id="header" class="fontcolor">NKLCB.POS</div>
	<div id="menu">
	   <div class="box">
	     <div id="enterData">
	   	 <!-- 로그인 Box -->
	        ${levInfo }
			<input class="textbox" type="text" name="empName" placeholder="Enter Employee Code"> 
			<input class="textbox" type="password" name="empPin" placeholder="Enter Passcode">
	     </div>

			<button class="bottonL" onClick="registration()" >NEXT</button>
			<button class="bottonP" onClick="movePage('group-step3')" >PREV</button>
			<button class="bottonS" onClick="movePage('mainpos.jsp')">MAIN</button>
	   </div>
	</div>
</div>

<!-- MessageBox -->
	<div id="lightBox" style="display: none">
		<div id="messageZone">
			<div id="messageContent">Server Message</div>
		</div>
		<div id="messageAction">
			<div class="button solo" onClick="disableMessage()">확인</div>
		</div>
	</div>
	
	<!-- JavaScript -->
<script>
/*
function registration(){
	const form = createForm("", "MemberJoin", "post");	
	const enterData = document.getElementById("enterData");
	let group = [];
	let submitResult = false;
	
	group.push(document.getElementsByName("groupName")[0]);
	group.push(document.getElementsByName("groupCeo")[0]);
	group.push(document.getElementsByName("groupPin")[0]);
	
	for(let idx=0; idx<group.length; idx++){
		submitResult = lengthCheck(group[idx]);
		if(submitResult) form.appendChild(group[idx]);	
		else break;
	}
	
	if(submitResult){
		enterData.appendChild(form);
		form.submit();
	}
}
*/
</script>
</body>
</html>