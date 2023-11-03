<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Vector" %>
<%@ page import="bean.VehicleBean" %>

<jsp:useBean id="lConnector" class="database.LotConnector"/>
<jsp:useBean id="pConnector" class="database.ParkingDetailConnector"/>
<jsp:useBean id="vConnector" class="database.VehicleConnector"/>

<%	
	String numbStr = request.getParameter("numb");
	int numb = 0;
	if (numbStr != null) {
		numb = Integer.parseInt(numbStr);
	}
	String parkinglotName = lConnector.readLotNameByNumb(numb);
	Vector<VehicleBean> vector = vConnector.readParkedVehicles(numb);
%>
<script>
</script>
<html>
	<head>
		<title>주차장 주차 현황</title>
	</head>
	<body>
	    <div style="display: flex; justify-content: center; align-items: center; font-size: 12px;">
			<div style="display: flex; flex-direction: column; justify-content: center; align-items: center; height: screen; width: screen;">
	  		    <h3><%= parkinglotName %>: 주차 현황</h3>
	  		    <h4>주차된 차량: <%= vector.size() %>대</h4>
		        <div style="display: flex;">
		            <p style="width: 8vw">index</p>
		            <p style="width: 18vw">차량 번호</p>
		            <p style="width: 10vw">회원 유무</p>
		            <p style="width: 10vw">차량 크기</p>
		            <p style="width: 18vw">주차한 시간</p>
		        </div>
	        <%
	         	if(vector.isEmpty()) {
	         		out.println("<div style='display: flex; border-top: 2px solid black;'><p>주차중인 차량이 없습니다.</p></div>");
	         	} else {
	         		for (int i = 0; i < vector.size(); i++) {
	         			VehicleBean bean = (VehicleBean)vector.get(i);
	        %>
		        <div style="display: flex; border-top: 2px solid black;">
		            <p style="width: 8vw"><%=bean.getNumb()%></p>
		            <p style="width: 18vw"><%=bean.getCnum()%></p>
		            <p style="width: 10vw"><%=bean.getRegi()%></p>
		            <p style="width: 10vw"><%=bean.getType()%></p>
		            <p style="width: 18vw"><%=pConnector.readParkingDetailByNumb(bean.getDeta()).getEnte().toString()%></p>
		        </div>
		    <%
		         	}
				}
			%>
			</div>
	    </div>
	</body>
</html>