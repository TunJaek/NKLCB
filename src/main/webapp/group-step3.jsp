<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMBER JOIN :: Store Step</title>
<script src="resources/js/common.js"></script>
<link rel="stylesheet" href="resources/css/mainpos.css">
<link rel="stylesheet" href="resources/css/common.css">
</head>
<body onLoad="pageInit('${param.message}')">
	<div id="headerBox">
		<div id="header" class="fontcolor">NKLCB.POS</div>
		<div id="menu">
		  <div class= "box2">
			<div class="box" style="display: block">
					<div id="enterData">
						<input class="textbox" type="text" name="storeCode" placeholder=" 사업자등록번호를 입력해주세요"> 
						<input class="textbox" type="text" name="storeName" placeholder=" 상점 상호명을 입력해주세요">
						<input class="textbox" type="text" name="storePhone" placeholder=" 대표 연락처를 입력해주세요">
					</div>
				<!-- div button -->
				<div class="vButton right" style="display: block" onClick="moveCommunicationBox(true)"></div>
				</div>

				<div class="box" style="display: none">
					<div id="enterData">
						<input class="textbox" type="text" name="storeZipcode" placeholder=" 상점우편번호를 입력해주세요" onClick="kakaoAPI('box')">
						<input class="textbox" type="text" name="storeADDR" placeholder=" 상점주소를 입력해주세요" readOnly> 
							<input class="textbox" type="text" name="storeADDRDTL" placeholder=" 상점상세주소를 입력해주세요"> 
							<input class="textbox" type="hidden" name="groupCode" value="${groupCode }"> 
							<input class="textbox" type="hidden" name="groupName" value="${groupName }">
					</div>
				<!-- div button -->
				<div class="vButton left" style="display: none" onClick="moveCommunicationBox(false)"></div>
				</div>
					
				<div>
					<button class="bottonL" onClick="regStore()">NEXT</button>
					<button class="bottonP" onClick="movePage('group-step1.jsp')">PREV</button>
					<button class="bottonS" onClick="movePage('mainpos.jsp')">MAIN</button>
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
			<div class="button solo" onClick="disableMessage()">확인</div>
		</div>
	</div>

	<!-- JavaScript -->
	<script>
		let process = false;
		function kakaoAPI(className) {
			const address = document.getElementsByClassName(className)[1]
					.querySelector("#enterData");
			address.children[0].setAttribute("value", "22223");
			address.children[1].setAttribute("value", "인천광역시 미추홀구 매소홀로488번길");
			address.children[2].setAttribute("value", "6-3");
		}
		function regStore() {
			if (process) {
				alert("서버전송준비");
			} else {
				const enterData = document.getElementsByClassName("enterData");
				box[0].style.display = "none";
				box[1].style.display = "block";
				process = !process;
			}
		}
		
		function moveCommunicationBox(direction) {
			const communicationBox = document.getElementsByClassName("box");
			const moveButton = document.getElementsByClassName("vButton");
			if (direction) {
				communicationBox[0].style.display = "none";
				moveButton[0].style.display = "none";
				communicationBox[1].style.display = "block";
				moveButton[1].style.display = "block";
			} else {
				communicationBox[0].style.display = "block";
				moveButton[0].style.display = "block";
				communicationBox[1].style.display = "none";
				moveButton[1].style.display = "none";
			}
		}
	</script>
</body>
</html>