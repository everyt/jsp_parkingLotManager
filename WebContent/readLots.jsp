<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="bean.LotBean" %>
<%@ page import="java.util.Vector" %>
<jsp:useBean id="lConnector" class="database.LotConnector" />
<%
	request.setCharacterEncoding("UTF-8");
    Vector<LotBean> vector = lConnector.readLots();
%>

<html>
<head>
    <title>전제 주차장 조회</title>
	<script type="text/javascript" src="JScript.js"></script>
</head>
<body>
		
		<form name="LotList" method="post" action="assortRequest.jsp">
	    <input type="hidden" name="numb" />
	    <input type="hidden" name="type" />
	    
		<div style="display: flex; justify-content: center; align-items: center; font-size: 12px">
			<div style="display: flex; flex-direction: column; justify-content: center; align-items: center; height: screen; width: screen;">
  		    <h3>전제 주차장 조회</h3>
	       	<p>등록되어 있는 주차장 수: <%=vector.size()%></p>
	        <div style="display: flex; align-self: start;">
	            <p style="width: 4vw">index</p>
	            <p style="width: 16vw">주차장</p>
	            <p style="width: 8vw">기초 요금</p>
	            <p style="width: 8vw">시간당 요금</p>
	            <p style="width: 8vw">일정액 요금</p>
	            <p style="width: 8vw">무료 시간</p>
	            <p style="width: 12vw; padding: 0px 3px;">현재 주차 상황</p>
	            <p style="width: 12vw; padding: 0px 3px;">차량 입출납 내역</p>
	            <p style="width: 8vw; padding: 0px 3px;">입출납 등록</p>
	            <p style="width: 5vw; padding: 0px 3px;">수정</p>
	            <p style="width: 5vw; padding: 0px 3px; color: red;">삭제</p>
	        </div>
	        <%
	        	if(vector.isEmpty()) {
	        	         		out.println("<div style='display: flex; align-items: center; border-top: 2px solid black;'><p>등록된 주차장이 없습니다.</p></div>");
	        	         	} else {
	        	         		for (int i = 0; i < vector.size(); i++) {
	        	        		  LotBean bean = vector.get(i);
	        %>
	        <div style="display: flex; align-items: center; border-top: 2px solid black;">
	            <p style="width: 4vw"><%= bean.getNumb() %></p>
	            <p style="width: 16vw"><%= bean.getName() %></p>
	            <p style="width: 8vw"><%= bean.getPric() %></p>
	            <p style="width: 8vw"><%= bean.getPerh() %></p>
	            <p style="width: 8vw"><%= bean.getPerd() %></p>
	            <p style="width: 8vw"><%= bean.getFree() %></p>
	            <input style="width: 12vw; margin: 3px;" type="button" value="주차된 차량 조회" onClick="handleClick('<%=bean.getNumb()%>', 'readParkedVehicles')" />
	            <input style="width: 12vw; margin: 3px;" type="button" value="입출납 내역 조회" onClick="handleClick('<%=bean.getNumb()%>', 'readParkingDetails')" />
	            <input style="width: 8vw; margin: 3px;" type="button" value="입출납 등록" onClick="handleClick('<%=bean.getNumb()%>', 'insertParkingDetail')" />
	            <input style="width: 5vw; margin: 3px;" type="button" value="수정" onClick="handleClick('<%=bean.getNumb()%>', 'updateLot')" />
	            <input style="width: 5vw; margin: 3px; color: red;" type="button" value="삭제" onClick="handleClick('<%=bean.getNumb()%>', 'deleteLot')" />
	        </div>
	        <%
	         		}
	         	}
	        %>
	    	</div>
	    </div>
		</form>
</body>
</html>
    