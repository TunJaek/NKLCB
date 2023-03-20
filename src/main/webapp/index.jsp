<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MAINPOS</title>
<script src="resources/js/common.js"></script>
<link rel="stylesheet" href="resources/css/index.css">
<link rel="stylesheet" href="resources/css/common.css">
</head>
<body onLoad="pageInit('${param.message}', 'group-step1.jsp')">
<div id="headerBox">
		    <div id="header" class="fontcolor">땜빵</div>
	<div id="menu">
	   <div class="box">
	     <div id="enterData">
			<input class="textbox" type="text" placeholder=" Enter ID" name="ID"> 
			<input class="textbox" type="password" placeholder=" Enter Passcode" name="Password">
	     </div>
			
			<button class="bottonJ" onClick="accessCall()">로그인</button>
			<button class="bottonJ" onClick="moveStep()">회원가입</button>
			<button class="bottonJ" onClick="moveStep()">고수가입</button>
	   </div>
	</div>
</div>

<!-- MessageBox -->
<div id="lightBox" style="display:none">
  <div id="messageZone">
    <div id="messageContent">Server Message</div>
  </div>
  <div id="messageAction">
    <div class="button solo" onClick="disableMessage()">확인</div>
  </div>
</div>
	<!-- JavaScript -->
<script>
function moveStep(){
	location.href="group-step1.jsp"
}
/*고수가입
function moveStep(){
	location.href="group-step1.jsp"
}
*/
function accessCall(){
	const form = createForm("", "Access", "post");
	const enterData = document.getElementById("enterData");
	
	let group = [];
	let submitResult = false;
	
	group.push(document.getElementsByName("ID")[0]);
	group.push(document.getElementsByName("Password")[0]);
	
	for(let i = 0; i < group.length; i++){
		submitResult =  accessLengthCheck(group[i]);
		if(!submitResult) alert("개빡쳐"); break;
	}
	
	if(submitResult){
		const hidden = createInputBox("hidden", "accessPublicIp", publicIp, "");
		form.appendChild(hidden);
		form.appendChild(enterData); //document : 스크립트 영역에서 html 영역으로 접근하기 위해서 쓰는 단어.
		document.body.appendChild(form);
		form.submit(); //submit() : form에 담긴 정보를 백엔드 server로 보낸다
	}
}
</script>
</body>
</html>