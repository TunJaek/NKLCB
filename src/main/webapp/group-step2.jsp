<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMBER JOIN</title>
<script src="resources/js/common.js"></script>
<link rel="stylesheet" href="resources/css/step2.css">
<link rel="stylesheet" href="resources/css/common.css">
</head>
<body onLoad="pageInit('${param.message}', 'group-step1.jsp')">
	<div id="headerBox">
		<div id="header" class="fontcolor"><div class="title">땜빵<br>고수 회원가입</div></div>
		<div id="menu">
			<div class="box"> 
			<div id="enterData">
		      <input class="textbox" type="text" name="ID" placeholder=" 아이디 : 5 ~ 20자 이내로 작성해주세요">
		      <input class="textbox" type="password" name="Password" placeholder=" 비밀번호 : 8 ~ 20자 이내로 작성해주세요">
		      <input class="textbox" type="text" name="PhoneNumber" placeholder=" 연락처를 입력해주세요">
		    </div>
		    
		    <div class="job">활동분야를 선택해주세요 (중복선택가능)</div>
		     <div class="Z">
		      <button class="buttonZ" onClick="clickMenuButtonZ(0)">청소 • 집안일</button>
		      <button class="buttonZ" onClick="clickMenuButtonZ(1)">배달 • 장보기</button>
		      <button class="buttonZ" onClick="clickMenuButtonZ(2)">가구<br>조립 • 설치</button>
		      <button class="buttonZ" onClick="clickMenuButtonZ(3)">용달 • 화물<br>운송</button>
		     </div>
		     
		     <div class="Z">
		      <button class="buttonZ" onClick="clickMenuButtonZ(4)">산후 • 육아 • 아이 돌봄</button>
		      <button class="buttonZ" onClick="clickMenuButtonZ(5)">등하원 도우미</button>
		      <button class="buttonZ" onClick="clickMenuButtonZ(6)" >벌레 • 쥐잡기</button>
		     </div>
		     
		    <div class="job">성별을 선택해주세요</div>
		      <button class="buttonX" onClick="clickMenuButtonX(0)">남자</button>
		      <button class="buttonX" onClick="clickMenuButtonX(1)">여자</button>
		    <div>
				<button class="buttonS" onClick="serverCallMem()">가입하기</button>
				<button class="buttonS" onClick="moveMain()">MAIN</button>
		    </div>
		    
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
function moveMain() {
	location.href = "index.jsp"
}

let menuButtonZ = document.querySelectorAll('.buttonZ');
let menuButtonX = document.querySelectorAll('.buttonX');
let selectButtonZ = [];
let selectButtonX = [];
	function clickMenuButtonZ(idx) {
		if (!menuButtonZ[idx].classList.contains('button-active')) {
			menuButtonZ[idx].classList.add('button-active');
			selectButtonZ.push(idx);
		}else{
			menuButtonZ[idx].classList.remove('button-active');
			
			for(let i = 0; i < selectButtonZ.length; i++){
				if(selectButtonZ[i] == idx){
					selectButtonZ.splice(i,1);
				}
			}
		}
	}
	
	
	function clickMenuButtonX(idx) {

		for (let i = 0; i < menuButtonX.length; i++) {
			menuButtonX[i].classList.remove('button-active');
			selectButtonX.splice(i,1);
		}
		menuButtonX[idx].classList.add('button-active');
		selectButtonX.push(idx);
	}
	
	function serverCallMem() {
		const form = createForm("", "JoinAccess", "post");
		const enterData = document.getElementById("enterData");

		let group = [];
		let submitResult = false;

		//배열에 담긴 숫자를 7자리로 변환
		let sb = [];
		for (let i = 0; i < 7; i++) {
			for (let idx = 0; idx < selectButtonZ.length; idx++) {
				if (i === selectButtonZ[idx]) {
					sb.push('1');
					break;
				}
			}
			if (sb.length != (i + 1))
				sb.push('0');
		}
		
		let sbString = sb.join();
		sbString = sbString.replaceAll(',', '');
		
		if (selectButtonX == 0) {
			selectButtonX = 'ML';
		} else {
			selectButtonX = 'FM';
		}

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
			form.appendChild(createInputBox("hidden", "JOB", sbString, ""));
			form.appendChild(createInputBox("hidden", "SEX", selectButtonX, ""));
			document.body.appendChild(form);
			form.submit();
		}
	}
</script>
</body>
</html>