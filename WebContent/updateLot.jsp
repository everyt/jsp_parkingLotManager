<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Vector" %>
<%@ page import="bean.ParkingDetailBean" %>
<%@ page import="bean.LotBean" %>

<jsp:useBean id="lConnector" class="database.LotConnector"/>

<%	
	String numb = request.getParameter("numb");
	int intNumb = 0;
	if (numb != null) {
		intNumb = Integer.parseInt(numb);
	} else {
		System.out.println("잘못된 접근입니다.");
	}
	LotBean lBean = lConnector.readLotByNumb(intNumb);
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>주차장 정보 수정</title>
	<script type="text/javascript" src="JScript.js"></script>
</head>
<body>
	<form name="editPark" method="post" action="processUpdateLot.jsp">
		<div style="display: flex; justify-content: center; align-items: center;">
		<div style="display: flex; flex-direction: column; justify-content: center; height: screen; width: 30%;">
			<h1><%=lBean.getName()%>: 정보 수정</h1>
			<input name="name" size="15" placeholder='<%="주차장 이름: " + lBean.getName()%>' type="password" style="margin: 5px;" />
			<input name="pswd" size="15" placeholder='<%="비밀번호: " + lBean.getPswd()%>' type="password" style="margin: 5px;" />
			
			<input name="pric" size="15" placeholder='<%="기본 요금: " + lBean.getPric()%>' style="margin: 5px;" />
			<input name="perh" size="15" placeholder='<%="시간당 요금: " + lBean.getPerh()%>' style="margin: 5px;" />
			<input name="perd" size="15" placeholder='<%="일정액 요금: " + lBean.getPerd()%>' style="margin: 5px;" />
			<input name="free" size="15" placeholder='<%="무료 이용 가능 시간: " + lBean.getFree()%>' style="margin: 5px;" />
			
			<input type="button" value="수정" onClick="submit()" style="margin: 5px;" />
		</div>
		</div>
	</form>
</body>
</html>