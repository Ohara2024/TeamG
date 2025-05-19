<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>科目変更画面</title>
<!-- <link> -->

</head>
<body>

<h2>科目情報変更</h2>
<form action="SubjectUpdate" method="post">
	<label for="cdtxt">科目コード</label>
    <input type="text" id="cdtxt" name="cdtxt" value="${cd}"><br>

	<label for="name">科目名</label>
	<input type="text" id="name" name="name" value="${name}"><br>

<!-- <input> -->


	<a href="">戻る</a>

</form>
</body>
</html>

