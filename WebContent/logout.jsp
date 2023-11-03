<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<%
	String name = request.getParameter("name");
%>
<!DOCTYPE html>
<html>
<body>
	<form name="logoutForm" method="post" action="processLogout.jsp">
		<div style="display: flex; align-items: center; height: 20px; margin-top: 15px;">
			<p><%=name%></p>
			<input type="submit" value="로그아웃" style="margin: 5px" />
		</div>
	</form>
</body>
</html>