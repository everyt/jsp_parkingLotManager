<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
	<script>
		function checkInput() {
			if (document.loginForm.name.value == "") {
				document.loginForm.name.focus();
				return;
			} else if (document.loginForm.pswd.value == "") {
				document.loginForm.pswd.focus();
				return;
			}
			document.loginForm.submit();
		}
	</script>
	<form name="loginForm" method="post" action="processLogin.jsp">
		<div style="display: flex; align-items: center; height: 20px; margin-top: 15px;">
			<input name="name" type="text" placeholder="주차장 이름" style="margin: 5px" />
			<input name="pswd" type="password" placeholder="비밀번호" style="margin: 5px" />
			<input type="button" value="로그인" style="margin: 5px" onClick="checkInput()" />
		</div>
	</form>
</body>
</html>