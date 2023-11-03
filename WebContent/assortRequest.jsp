<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Arrays" %>
<jsp:useBean id="connector" class="database.LotConnector"/>
<%		
		String numb = request.getParameter("numb");
		int intNumb = 0;
		if (numb != null) {
			intNumb = Integer.parseInt(numb);
		} else {
			System.out.println("잘못된 접근입니다.");
		}
		String type = request.getParameter("type");
		String pwd = connector.readLotPswdByNumb(intNumb);
		String adminPwd = "1q2w3e4r"; // 보안이 문제가 되면 언제든지 db에서 불러오게 할 수도 있음, 아예 체킹을 백엔드단으로 넘기거나. (그러면 jsp가 하나 더 필요하겠지...)
%>
<html>
	<head>
		<title>비밀번호 확인</title>
		<script>
			function push() {
				const inputPwd = document.checkPwd.parkinglotPwd.value;
				const serverPwd = '<%=pwd%>';
				const adminPwd = '<%=adminPwd%>';
				if (inputPwd === serverPwd || inputPwd === adminPwd) {
					const type = '<%=type%>';
					let loc;
					
					if (type === 'updateLot') {
						loc = 'updateLot.jsp';
					} else if (type === 'readParkingDetails') {
						loc = 'readParkingDetails.jsp';
					} else if (type === 'readParkedVehicles') {
						loc = 'readParkedVehicles.jsp';
					} else if (type === 'insertParkingDetail') {
						loc = 'insertParkingDetail.jsp';
					} else if (type === 'deleteLot') {
						loc = 'deleteLot.jsp';
					} else {
						alert('비정상적인 접근입니다.');
						loc = 'readLots.jsp';
					}
					
					location.href = loc + '?numb=' + <%=numb%>;
				} else {
					alert('비밀번호가 틀렸습니다.');
				}
			}
		</script>
	</head>
	<body>
		<form name="checkPwd">
			<div style="display: flex; flex-direction: col; justify-content: center; align-items: center; height: screen; width: screen;">
				<p>비밀번호 입력</p>
				<input name="parkinglotPwd" size="15" placeholder="비밀번호" type="password" />
				<input type="button" value="확인" onClick="push()" />
			</div>
		</form>
	</body>
</html>