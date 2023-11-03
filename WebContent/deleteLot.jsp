<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Arrays" %>
<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="lConnector" class="database.LotConnector"/>
<%	
		String numb = request.getParameter("numb");
		int intNumb = 0;
		if (numb != null) {
			intNumb = Integer.parseInt(numb);
		} else {
			System.out.println("잘못된 접근입니다.");
		}
		lConnector.deleteLot(intNumb);
		String msg = "주차장을 삭제했습니다.";
		String location = "readLots.jsp";
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=location%>";
</script>