<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>成績参照（学生毎）</title>
</head>
<body>
    <h2>成績参照（学生毎）</h2>

    <form action="TestListAction" method="post">
        学生番号：<input type="text" name="studentNo">
        <input type="submit" value="検索">
    </form>

    <!-- エラーメッセージがある場合に表示 -->
    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
        <p style="color:red;"><%= error %></p>
    <%
        }
    %>
</body>
</html>
