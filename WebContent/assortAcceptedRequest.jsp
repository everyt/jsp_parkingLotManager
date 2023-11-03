<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="bean.LotBean" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="lConnector" class="database.LotConnector"/>
<%
	String link = request.getParameter("link");
	boolean login = false;
	String numb = "";
	Cookie[] cookies = request.getCookies();
	for (int i = 0; i < cookies.length; i++) {
		if ("numb".equals(cookies[i].getName())) {
			numb = cookies[i].getValue();
			login = true;
		}
	}
%>
<script>
	if (<%=login%> === true) {
		const contentFrame = parent.document.getElementById("content");
        contentFrame.src = '<%=link%>' + '?numb=' + `<%=numb%>`;
	} else {
		alert("로그인이 필요한 메뉴입니다.");
	}
	location.href = "topBar.jsp";
</script>