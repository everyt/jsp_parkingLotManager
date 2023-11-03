<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="bean.VehicleBean" %>
<%@ page import="bean.ParkingDetailBean" %>
<jsp:useBean id="vConnector" class="database.VehicleConnector"/>
<jsp:useBean id="pConnector" class="database.ParkingDetailConnector"/>
<jsp:useBean id="rBean" class="bean.RequestPDBean"/>
<jsp:setProperty name="rBean" property="*" />
<%	
	request.setCharacterEncoding("UTF-8");
	String msg = ""; // 사용할 변수들 선언
	String location = "";
	Date date = new Date();
	Timestamp timestamp = new Timestamp(date.getTime());
	int result = 0;
	
	VehicleBean vBean = new VehicleBean();

	String rType = "";
	if ("1".equals(rBean.getType())) {
		rType = "소형";
	} else if ("2".equals(rBean.getType())) {
		rType = "중형";
	} else if ("3".equals(rBean.getType())) {
		rType = "대형";
	}
	
	int veid = vConnector.readVehicleNumbByCnum(rBean.getCnum()); // 차량 번호로 해당 번호의 차량이 등록되었는지 확인
	if (veid == 0) { // 미등록이면
		vBean.setCnum(rBean.getCnum());
		vBean.setRegi(rBean.getRegi());
		vBean.setDayp(rBean.getDayp());
		vBean.setStat(true);
		vBean.setType(rType); // vBean 설정
		vBean.setPlot(rBean.getPlot());
		vConnector.insertVehicle(vBean); // 차량 등록후 차량 id 획득
		veid = vConnector.readVehicleNumbByCnum(rBean.getCnum());
	} else if (rBean.getEnte()) { // 등록이고 입장이면
		vBean = vConnector.readVehicleByCnum(rBean.getCnum()); // 차량 빈 호출후에 변경된 값이 있으면 업데이트
		if (!(rBean.getRegi() == vBean.getRegi())) vConnector.updateVehicleRegi(rBean.getRegi(), veid);
		if (!(rBean.getDayp() == vBean.getDayp())) vConnector.updateVehicleDayp(rBean.getDayp(), veid);
		if (!(rType == vBean.getType())) vConnector.updateVehicleType(rType, veid);
		if (!(rBean.getPlot() == vBean.getPlot())) vConnector.updateVehiclePlot(rBean.getPlot(), veid);
	}
	
	ParkingDetailBean pBean = new ParkingDetailBean(); // 출납기록 빈 생성
	pBean.setVeid(veid);            // 가지고 있는 데이터 삽입
	pBean.setPlot(rBean.getPlot()); //
	
	if (rBean.getEnte()) { // 입장 기록이면
		pBean.setEnte(timestamp); // 입장 시간 기록
		result = pConnector.insertParkingDetail(pBean); // 출납기록 업로드
		if (result > 0) { // 업로드가 성공하면
			int veNumb = pConnector.readParkingDetailNumb(pBean);
			vConnector.updateVehicleDeta(veNumb, veid); // 차량에 연결된 출납기록 등록
			vConnector.updateVehicleStat(true, veid); // 주차중 기록
			msg = "새로운 입장을 기록했습니다.";
			location = "readParkedVehicles.jsp?numb=" + rBean.getPlot();
		} else {
			msg = "입장 기록이 실패했습니다.";
			location = "insertParkingDetail.jsp";
		}
	} else { // 퇴장 기록이면
		pBean.setLeav(timestamp); // 퇴장 시간 기록
		result = pConnector.updateParkingDetailLeav(pBean); // pBean의 데이터(차량id, 주차장id)로 가장 최근 출납기록을 검색한 뒤 퇴장시간 업데이트
		if (result > 0) {
			vConnector.updateVehicleDeta(0, veid); // 차량에 연결된 출납기록 삭제
			vConnector.updateVehicleStat(false, veid);
			msg = "새로운 퇴장을 기록했습니다.";
			location = "readLots.jsp";
		} else {
			msg = "퇴장 기록이 실패했습니다.";
			location = "insertParkingDetail.jsp";
		}
	}
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=location%>";
</script>