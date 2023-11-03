<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Arrays" %>
<jsp:useBean id="lConnector" class="database.LotConnector"/>
<jsp:useBean id="lBean" class="bean.LotBean"/>
<jsp:setProperty name="lBean" property="*" />
<%	
		int result = lConnector.updateLot(lBean);
		String msg = "주차장 정보 수정에 실패했습니다.";
		String location = "updateLot.jsp";
		if(result > 0){
			msg = "주차장 정보 수정에 성공했습니다.";
			location = "readLots.jsp";
		}
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=location%>";
</script>