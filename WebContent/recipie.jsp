<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="bean.ParkingDetailBean" %>
<%@ page import="bean.VehicleBean" %>

<jsp:useBean id="lConnector" class="database.LotConnector"/>
<jsp:useBean id="pConnector" class="database.ParkingDetailConnector"/>
<jsp:useBean id="vConnector" class="database.VehicleConnector"/>

<%
	request.setCharacterEncoding("UTF-8");
%>

<%	
	String numbStr = request.getParameter("numb");
	int numb = 0;
	if (numbStr != null) {
		numb = Integer.parseInt(numbStr);
	}
	String durationTime = request.getParameter("durationTime");
	String price = request.getParameter("price");
	ParkingDetailBean pbean = pConnector.readParkingDetailByNumb(numb);
	int lotNumb = pbean.getPlot();
	String lot = lConnector.readLotNameByNumb(lotNumb);
	Timestamp now = new Timestamp(System.currentTimeMillis());
    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss");
    int carNumb = pbean.getVeid();
    VehicleBean vBean = vConnector.readParkedVehicleByNumb(carNumb);
    String realCarNumb = vBean.getCnum();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<div style="width: 100vw; height: 100vh; display: flex; flex-direction: column; ">
		<h3>영 수 증</h3><br>
		<p>주차장: <%=lot%></p>
		<p>날짜: <%=simpleDateFormat.format(now.getTime())%></p>
		<p>=========================</p>
		<p>차량번호&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;머무른 시간&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;요금</p>
		<p>=========================</p>
		<p><%=realCarNumb%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=durationTime%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=price%>원</p>
		<p>------------------------------------------</p>
	</div>
</body>
</html>