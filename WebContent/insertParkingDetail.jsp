<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:useBean id="lConnector" class="database.LotConnector"/>

<%
	request.setCharacterEncoding("utf-8");
	String numbStr = request.getParameter("numb");
	int numb = 0;
	if (numbStr != null) {
		numb = Integer.parseInt(numbStr);
	}
	String LotName = lConnector.readLotNameByNumb(numb);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>주차장 입출납 기록</title>
	<script type="text/javascript" src="JScript.js"></script>
</head>
<body>
	<script>
		function inputCheck2(type) {
			let form = document.addDetail;
			form.plot.value = '<%=numb%>'
			
			let number = form.cnum.value;
			if (number.length <= 0) {
				alert("차량 번호를 기재해 주세요.");
				return;
			}
			
			date = new Date().getTime();
			
			if (type === "enter") {
				form.ente.value = true;
			} else {
				form.ente.value = false;
			}
			
			form.submit();
		}
	</script>
	<form name="addDetail" method="post" action="processParkingDetail.jsp">
		<div style="display: flex; justify-content: center; align-items: center;">
			<div style="display: flex; flex-direction: column; justify-content: center; height: screen; width: 30%;">
				<p><%=LotName%>: 입출납 기록</p>
				<input name="ente" type="hidden" />
				<input name="plot" type="hidden" />
				<input name="cnum" size="15" placeholder="차량 번호" />
				<input type="button" value="등록 확인" onClick="checkCnum(this.form.cnum.value)"/>
				<select name="type">
					<option value="none">차량 크기 택1</option>
					<option value="1">소형</option>
					<option value="2">중형</option>
					<option value="3">대형</option>
				</select>
				<div style="display: flex; align-items: center;">
					<p>회원 여부</p>
					<input name="regi" size="15" type="checkbox" />
				</div>
				<div style="display: flex; align-items: center;">
					<p>일정액 여부</p>
					<input name="dayp" size="15" type="checkbox" />
				</div>
				<div style="display: flex; align-items:center;">
		 			<input type="button" value="입장" onClick="inputCheck2('enter')" />
		 			<input type="button" value="퇴장" onClick="inputCheck2('leave')" />
	 			</div>
 			</div>
		</div>
	</form>
</body>
</html>