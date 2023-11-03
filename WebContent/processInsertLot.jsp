<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="lConnector" class="database.LotConnector"/>
<jsp:useBean id="lBean" class="bean.LotBean"/>
<jsp:setProperty name="lBean" property="*"/>
<%	
		int numb = lConnector.insertLot(lBean);
		String msg = "주차장 등록이 실패했습니다.";
		String location = "insertLot.jsp";
		if(numb > 0){
			msg = "새 주차장을 등록했습니다.";
			location = "readLots.jsp";
		}
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=location%>";
</script>