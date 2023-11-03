<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="lConnector" class="database.LotConnector"/>
<%
	boolean login = false;
	String numb = "";
	Cookie[] cookies = request.getCookies();
	String name = "";
	for (int i = 0; i < cookies.length; i++) {
		if ("numb".equals(cookies[i].getName())) {
			numb = cookies[i].getValue();
			login = true;
			name = lConnector.readLotNameByNumb(Integer.parseInt(numb));
		}
	}
%>

<!DOCTYPE html>
<html>
<head>
	<script>
		function href(link) {
			const contentFrame = parent.document.getElementById("content"); // "contentFrame"은 embed 요소의 ID
	        contentFrame.src = link; // 다른 페이지의 경로
	    }
		function hrefWithNumb(link) {
			document.request.link.value = link;
			document.request.submit();
		}
	</script>
</head>
<body>
	<div style="width: screen; height: 70px; border-botton: 2px solid black; background-color: white; display: flex; flex-direction: column; justify-content: center; align-items: center;">
		<h1>주차장 통합 관리</h1>
		<div style="display: flex; align-items: center; justify-content: center;">
			<embed id="login" src="login.jsp" width="450px" height="50px" />
			<input type="button" value="메인 페이지" onClick="href('readLots.jsp')" style="margin: 5px;" />
			<input id="login5" type="button" value="주차장 추가" onClick="href('insertLot.jsp')" style="margin: 5px;" />
			<form name="request" method="post" action="assortAcceptedRequest.jsp">
				<input type="hidden" name="link">
				<div style="display: flex; align-items: center; justify-content: center;">
					<input id="login1" type="button" value="주차 차량 조회" onClick="hrefWithNumb('readParkedVehicles.jsp')" style="margin: 5px;" />
					<input id="login2" type="button" value="차량 출납 조회" onClick="hrefWithNumb('readParkingDetails.jsp')" style="margin: 5px;" />
					<input id="login3" type="button" value="신규 출납 기록" onClick="hrefWithNumb('insertParkingDetail.jsp')" style="margin: 5px;" />
					<input id="login4" type="button" value="주차장 정보 수정" onClick="hrefWithNumb('updateLot.jsp')" style="margin: 5px;" />
				</div>
			</form>
		</div>
	</div>
	<script>
		if (<%=login%>) {
			const contentFrame = document.getElementById("login");
	        contentFrame.src = 'logout.jsp?name=' + '<%=name%>';
			document.getElementById("login1").style.display = 'inline-block';
			document.getElementById("login2").style.display = 'inline-block';
			document.getElementById("login3").style.display = 'inline-block';
			document.getElementById("login4").style.display = 'inline-block';
			document.getElementById("login5").style.display = 'none';
		}
		if (!<%=login%>) {
			document.getElementById("login1").style.display = 'none';
			document.getElementById("login2").style.display = 'none';
			document.getElementById("login3").style.display = 'none';
			document.getElementById("login4").style.display = 'none';
			document.getElementById("login5").style.display = 'inline-block';
		}
	</script>
</body>
</html>