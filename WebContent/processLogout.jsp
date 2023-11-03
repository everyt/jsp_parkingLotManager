<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="bean.LotBean" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	Cookie[] cookies = request.getCookies();
	
	for(int i = 0; i < cookies.length; i++){
		cookies[i].setMaxAge(0);
		response.addCookie(cookies[i]);
	}
%>
<script>
	const contentFrame = parent.parent.document.getElementById("content"); // "contentFrame"은 embed 요소의 ID
    contentFrame.src = 'readLots.jsp';
	parent.document.getElementById("login1").style.display = 'none';
	parent.document.getElementById("login2").style.display = 'none';
	parent.document.getElementById("login3").style.display = 'none';
	parent.document.getElementById("login4").style.display = 'none';
	parent.document.getElementById("login5").style.display = 'inline-block';
	location.href = "login.jsp";
</script>