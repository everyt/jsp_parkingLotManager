<%@page import="bean.VehicleBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.lang.Math" %>
<%@ page import="bean.LotBean" %>
<%@ page import="bean.VehicleBean" %>
<%@ page import="bean.ParkingDetailBean" %>

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
	Vector<ParkingDetailBean> vector = pConnector.readParkingDetails(numb);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String search1Str = request.getParameter("search");
	String search2Str = request.getParameter("search2");
	Timestamp search1 = null;
	Timestamp search2 = null;
	int search = 0;
	if (search1Str != null) {
		search1 = new Timestamp(sdf.parse(search1Str).getTime());
		search2 = new Timestamp(sdf.parse(search2Str).getTime());
		search = 1;
	}
    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss");
%>
<html>
	<head>
		<title>주차장 입출납 내역</title>
	</head>
	<body>
	    <div style="display: flex; justify-content: center; align-items: center; font-size: 12px;">
			<div style="display: flex; flex-direction: column; justify-content: center; align-items: center; height: screen; width: screen;">
	  		    <h3><%= parkinglotName %>: 차량 입출납 내역</h3>
	  		    <form name="searchDetail" method="post" action="readParkingDetails.jsp">
	  		    <div>
	  		    	<input name="numb" type="hidden" />
	  		    	시작
	  		    	<input name="search" type="date" />
	  		    	끝
	  		    	<input name="search2" type="date" />
	  		    	<input type="submit" value="조회" />
	  		    </div>
	  		    </form>
		        <div style="display: flex;">
		            <p style="width: 4vw">index</p>
		            <p style="width: 10vw">차량 번호</p>
		            <p style="width: 6vw">차랑 크기</p>
		            <p style="width: 6vw">회원</p>
		            <p style="width: 6vw">일정액</p>
		            <p style="width: 6vw">주차중</p>
		            <p style="width: 18vw">주차한 시간</p>
		            <p style="width: 18vw">퇴장한 시간</p>
		            <p style="width: 12vw">머무른 시간</p>
		            <p style="width: 8vw">주차 요금</p>
		            <p style="width: 6vw">영수증</p>
		        </div>
		        <%
		         	if(vector.isEmpty()) {
		         		out.println("<div style='display: flex; border-top: 2px solid black;'><p>등록된 차량 입출납 내역이 없습니다.</p></div>");
		         	} else {
		         		for (int i = 0; i < vector.size(); i++) {
		         			ParkingDetailBean bean = (ParkingDetailBean)vector.get(i);
				            Timestamp enterTime = bean.getEnte();
				            int condition = 0;
				            if (search == 1) {
					            int comparison1 = search1.compareTo(enterTime);
					            int comparison2 = search2.compareTo(enterTime);
					            if (comparison1 <= 0 && comparison2 >= 0) {
					            	condition = 1;
					            }
				            } else if (search == 0) {
				            	condition = 1;
				            }
				            if (condition == 1) {
   		        %>
		        <div style="display: flex; border-top: 2px solid black;">
		            <p style="width: 4vw"><%=bean.getNumb()%></p>
		            <%
		            		VehicleBean vBean = vConnector.readParkedVehicleByNumb(bean.getVeid());
		            %>
		            <p style="width: 10vw"><%=vBean.getCnum()%></p>
		            <%
		            		String vehicleType = vBean.getType();
	            			String isRegistered = String.valueOf(vBean.getRegi());
	            			String isPayPerDay = String.valueOf(vBean.getDayp());
	            			String isParking = String.valueOf(vBean.getStat());
		            %>
		            <p style="width: 6vw"><%=vehicleType%></p>
		            <p style="width: 6vw"><%=isRegistered%></p>
		            <p style="width: 6vw"><%=isPayPerDay%></p>
		            <%
			            	Timestamp calcurTime = new Timestamp(System.currentTimeMillis());
				            
			            	if ((bean.getLeav() != null)) {
			            		calcurTime = bean.getLeav();
			            	}
				            LotBean lBean = lConnector.readLotByNumb(numb);
				            int BasePrice = lBean.getPric();
				            if ("false".equals(isRegistered)) {
					            if ("중형".equals(vehicleType)) {
					            	BasePrice = (int)Math.floor(BasePrice * 1.1);
					            } else if ("대형".equals(vehicleType)) {
					            	BasePrice = (int)Math.floor(BasePrice * 1.2);
					            }
				            }
				            int Price = 0;
				            if ("true".equals(isPayPerDay)) {
					            Price = BasePrice + lBean.getPerd() * (int)(((calcurTime.getTime() - enterTime.getTime()) / 1000) / 3600 / 24) + 1;
				            } else {
					            Price = BasePrice + lBean.getPerh() * (int)(((calcurTime.getTime() - enterTime.getTime()) / 1000) / 3600) - lBean.getFree();
				            }
				            if (Price < 0) Price = 0;
				            long caculrTimeMillis = calcurTime.getTime() - enterTime.getTime();
				            int hours = (int)((caculrTimeMillis / 1000) / 3600);
				            int minutes = (int)((caculrTimeMillis / 1000) % 3600) / 60;
				            int seconds = (int)((caculrTimeMillis / 1000) % 60);
				            String durationTime = hours + "시간 " + minutes + "분 " + seconds + "초";
		            %>
		            <p style="width: 6vw"><%=isParking%></p>
		            <p style="width: 18vw"><%=simpleDateFormat.format(enterTime.getTime())%></p>
		            <p style="width: 18vw"><%=bean.getLeav() != null ? simpleDateFormat.format(bean.getLeav().getTime()) : ""%></p>
		            <p style="width: 12vw"><%=durationTime%></p>
		            <p style="width: 8vw"><%=Price%></p>
	            	<input style="width: 6vw; margin: 3px;" type="button" value="영수증" onClick="handleClick('<%=bean.getNumb()%>', '<%=durationTime%>', '<%=Price%>')" />
		        </div>
		        <%
				            }
			         	}
					}
				%>
	    	</div>
		</div>
		<script>
			function handleClick(numb, durationTime, price) {
				window.open('recipie.jsp?numb=' + numb + '&durationTime=' + durationTime + '&price=' + price, 'recipie', "width=450,height=700");
			}
			document.searchDetail.numb.value = '<%=numb%>';
			if ('<%=search%>' === 1) {
				const searchDate1 = new Date('<%=search1Str%>');
				const searchDate2 = new Date('<%=search2Str%>');
				document.searchDetail.search.value = searchDate1;
				document.searchDetail.search2.value = searchDate2;
			}
		</script>
	</body>
</html>