function inputCheck() {
	if (document.addLot.pswd.value == "") {
		alert("주차장의 이름이 입력되지 않았습니다.");
		document.addLot.pswd.focus();
		return;
	}
	if (document.addLot.pswd.value == "") {
		alert("비밀번호가 입력되지 않았습니다.");
		document.addLot.pswd.focus();
		return;
	}
	if (document.addLot.pric.value == "") {
		document.addLot.pric.value = 0;
	}
	if (document.addLot.perh.value == "") {
		document.addLot.perh.value = 6000;
	}
	if (document.addLot.perd.value == "") {
		document.addLot.perd.value = 50000;
	}
	if (document.addLot.free.value == "") {
		document.addLot.free.value = 0;
	}
	
	document.addLot.submit();
}

function handleClick(numb, type) {
	document.LotList.numb.value = numb;
	document.LotList.type.value = type;
	document.LotList.submit();
}

function checkCnum(cnum) {
	url = "isRegisteredVehicle.jsp?cnum=" + cnum;
	window.open(url, "차량 등록 확인", "width=300,height=220");
}