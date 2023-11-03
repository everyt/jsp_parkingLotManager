<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Arrays" %>
<jsp:useBean id="vConnector" class="database.VehicleConnector"/>
<%
	request.setCharacterEncoding("UTF-8");
	String cnum = request.getParameter("cnum");
	int veid = vConnector.readVehicleNumbByCnum(cnum);
	
	String msg = "";
	String location = "insertLot.jsp";
%>
<html>
<head>
	<title>차량 등록 확인</title>
</head>
<body>
	<div align="center">
		<br/><b><%=cnum%></b>
		<%
			if (veid > 0) {
				out.println("<p>등록되어 있는 차량 번호입니다.</p>");
			} else {
				out.println("<p>미등록 차량 번호입니다. 추가 정보를 기재해주세요.</p>");
			}
		%>
		<a href="#" onClick="self.close()">닫기</a>
	</div>
</body>
</html>