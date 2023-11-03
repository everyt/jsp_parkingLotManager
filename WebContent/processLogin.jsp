<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="bean.LotBean" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="lConnector" class="database.LotConnector"/>
<%
	String name = request.getParameter("name");
	String pswd = request.getParameter("pswd");
	
	int numb = lConnector.readLotNumbByName(name);
	
	int value = 0;
	
	int result = lConnector.login(name, pswd);
	if (result > 0) {
		//script로 embed 교체
		value = 1;
		Cookie cookie = new Cookie("numb", Integer.toString(numb));
		cookie.setMaxAge(3600);
		response.addCookie(cookie);
	}

%>
<script>
	if (<%=value%> === 1) {
		parent.document.getElementById("login1").style.display = 'inline-block';
		parent.document.getElementById("login2").style.display = 'inline-block';
		parent.document.getElementById("login3").style.display = 'inline-block';
		parent.document.getElementById("login4").style.display = 'inline-block';
		parent.document.getElementById("login5").style.display = 'none';
		location.href = "logout.jsp?name=" + '<%=name%>';
	} else {
		alert("로그인이 실패했습니다.");
		location.href = "login.jsp";
	}
</script>