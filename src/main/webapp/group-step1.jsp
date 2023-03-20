<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMBER JOIN</title>
<script src="resources/js/common.js"></script>
<link rel="stylesheet" href="resources/css/step1.css">
<link rel="stylesheet" href="resources/css/common.css">
</head>
<body onLoad="pageInit('${param.message}', 'group-step1.jsp')">
	<div id="headerBox">
		<div id="header" class="fontcolor"><div class="title">땜빵<br>회원가입</div></div>
		<div id="menu">
			<div class="box"> 
			<div id="enterData">
		      <input class="textbox" type="text" name="ID" placeholder=" 아이디 : 5 ~ 20자 이내로 작성해주세요">
		      <input class="textbox" type="password" name="Password" placeholder=" 비밀번호 : 8 ~ 20자 이내로 작성해주세요">
		      <input class="textbox" type="text" name="PhoneNumber" placeholder=" 연락처를 입력해주세요">
		    </div>
					<button class="bottonS" onClick="serverCallMem()">가입하기</button>
					<button class="bottonS" onClick="moveMain()">MAIN</button>
			</div>
		</div>
	</div>

	<!-- MessageBox -->
	<div id="lightBox" style="display: none">
		<div id="messageZone">
			<div id="messageContent">Server Message</div>
		</div>
		<div id="messageAction">
			<button class="button solo" onClick="disableMessage()">확인</button>
		</div>
	</div>
	
	<!-- JavaScript -->
<script>

function moveMain(){
	location.href="index.jsp"
}

	function serverCallMem() {
		const form = createForm("", "JoinAccess", "post");
		const enterData = document.getElementById("enterData");

		let group = [];
		let submitResult = false;

		group.push(document.getElementsByName("ID")[0]);
		group.push(document.getElementsByName("Password")[0]);
		group.push(document.getElementsByName("PhoneNumber")[0]);

		for (let i = 0; i < group.length; i++) {
			submitResult = lengthCheck(group[i]);
			if (!submitResult) {
				if (group[i] = group[0]) {
					alert("아이디를 5~20자로 입력해주세요");
					break;
				} else if (group[i] = group[1]) {
					alert("비밀번호를 8~20자로 입력해주세요");
					break;
				} else if (group[i] = group[2]) {
					alert("휴대폰 번호를 11자로 입력해주세요");
					break;
				}
			}
		}
		if (submitResult) {
			form.appendChild(enterData);
			document.body.appendChild(form);
			form.submit(); //submit() : form에 담긴 정보를 백엔드 server로 보낸다
		}
	}
</script>
</body>
</html>