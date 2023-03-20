/**
 * Smart POS - Common Function
 */
  /*PUBLIC IP 수집 */
 let publicIp;
 function getPublicIp(){
	/* ajax:: get >>https://api.ipity.org/format=ison*/
	return "106.243.194.229";
}
 
 function lengthCheck(obj) {
	//서버로 전송할 데이터 길이의 유효성 판단
	const dataLength = [["ID",5,20],["Password",8,20],["PhoneNumber",11,11]];
	let result = null;
	for(let recordIdx=0; recordIdx<dataLength.length; recordIdx++){
		if(obj.getAttribute("name") == dataLength[recordIdx][0]){
			result = (obj.value.length >= dataLength[recordIdx][1] &&
			          obj.value.length <= dataLength[recordIdx][2])? true : false;
			break;
		}
	}
	return result;
}

 function accessLengthCheck(obj) {
	//서버로 전송할 데이터 길이의 유효성 판단
	const dataLength = [["ID",5,20],["Password",8,20]];
	let result = null;
	for(let recordIdx=0; recordIdx<dataLength.length; recordIdx++){
	if(obj.getAttribute("name") == dataLength[recordIdx][0]){
			result = (obj.value.length >= dataLength[recordIdx][1] &&
			          obj.value.length <= dataLength[recordIdx][2])? true : false;
			if(!result){alert("에러");}
		}
			break;
			}
	return result;
}	

/* FORM 생성 */
function createForm(name, action, method){
	publicIp= getPublicIp();
	const form = document.createElement("form");
	if(name != "") form.setAttribute("name", name);
	form.setAttribute("action", action);
	form.setAttribute("method", method);
	return form;
}

/* Input Box 생성*/
function createInputBox(type, name, value, placeholder){
	const input = document.createElement("input");
	input.setAttribute("type", type);//hidden
	input.setAttribute("name", name);//백엔드에서 쓸 이름
	if(value != "") input.setAttribute("value", value);//sbString
	if(placeholder != "") input.setAttribute("placeholder", placeholder);
	return input;
}
 
/* 페이지 이동 */
function movePage(targetPage){
	
	const form = createForm("", "MovePage", "get");
	const input = createInputBox("hidden", "target", targetPage, "");
	
	let group = [];
	group.push(document.getElementsByName("id")[0]); 

	form.appendChild(group[0]);
	form.appendChild(input);
	document.body.appendChild(form);
	
	form.submit();	
	
}

/* Page Initialize */
function pageInit(message){
	let serverMessage = message
	if(message != ''){
		document.getElementById("messageContent").innerText = serverMessage;
		document.getElementById("lightBox").style.display = "block";
	}
}

function disableMessage(){
	/*document.getElementById("messageTitle").innerText = "";*/
	document.getElementById("messageContent").innerText = "";
	document.getElementById("lightBox").style.display = "none";
}
