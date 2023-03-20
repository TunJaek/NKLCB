<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MainMenu</title>
<script src="resources/js/common.js"></script>
<link rel="stylesheet" href="resources/css/mainMenu.css">
<link rel="stylesheet" href="resources/css/common.css">
</head>
<body onLoad="pageInit('${param.message}')">
<div id="headerBox">
		    <div id="header" class="fontcolor">땜빵</div>
	<div id="menu">
	   <div class="box">
	      <div class="box1">
			<button class="bottonM" onClick="moveStep1()"><div class="title">청소<br>•<br>집안일</div></button>
			<button class="bottonM" onClick="moveStep2()"><div class="title">배달<br>•<br>장보기</div></button>
			<button class="bottonM" onClick="moveStep3()"><div class="title">가구<br>조립 • 설치</div></button>
			<button class="bottonM" onClick="moveStep4()"><div class="title">용달<br>•<br>화물운송</div></button>
	      </div>
	      
	      <div class="box2">
			<button class="bottonM" onClick="moveStep5()"><div class="title">산후 • 육아<br>• 아이 돌봄</div></button>
			<button class="bottonM" onClick="moveStep6()"><div class="title">등하원<br>도우미</div></button>
			<button class="bottonM" onClick="moveStep7()"><div class="title">벌레<br>•<br>쥐잡기</div></button>
			<button class="bottonM" onClick="moveStep8()">마이페이지</button>
	      </div>
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
function moveStep1(){
	location.href="cleaning.jsp"
}

function moveStep2(){
	location.href="delivery.jsp"
}

function moveStep3(){
	location.href="furniture.jsp"
}

function moveStep4(){
	location.href="cargo.jsp"
}

function moveStep5(){
	location.href="baby.jsp"
}

function moveStep6(){
	location.href="kindergarten.jsp"
}

function moveStep7(){
	location.href="bug.jsp"
}

function moveStep8(){
	location.href="group-step1.jsp"
}

function accessCall(){
	const form = createForm("", "Access", "post");
	const enterData = document.getElementById("enterData");
	
	let group = [];
	let submitResult = false;
	
	group.push(document.getElementsByName("storeCode")[0]);
	group.push(document.getElementsByName("empCode")[0]);
	group.push(document.getElementsByName("empPin")[0]);
	
	for(let i = 0; i < group.length; i++){
		submitResult = accessLengthCheck(group[i]);
		if(!submitResult) break;
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