<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>신규 주차장 등록</title>
	<script type="text/javascript" src="JScript.js"></script>
</head>
<body>
	<div style="display: flex; justify-content: center; align-items: center;">
		<div style="display: flex; flex-direction: column; justify-content: center; align-items: center; height: screen; width: 30%;">
			<p>신규 주차장 등록</p>
			<form name="addLot" method="post" action="processInsertLot.jsp">
				<input name="name" size="15" placeholder="이름" style="margin-top: 1rem"/>
				<input name="pswd" size="15" placeholder="비밀번호" style="margin-top: 1rem" type="password" />
				<input name="pric" size="15" placeholder="기본 요금" style="margin-top: 1rem" />
				<input name="perh" size="15" placeholder="시간당 요금" style="margin-top: 1rem" />
				<input name="perd" size="15" placeholder="일정액" style="margin-top: 1rem" />
				<input name="free" size="15" placeholder="무료 이용 가능 시간" style="margin-top: 1rem" />
				
			<input type="button" value="등록" onClick="inputCheck()" style="margin-top: 1rem" />
			</form>
		</div>
	</div>
</body>
</html>