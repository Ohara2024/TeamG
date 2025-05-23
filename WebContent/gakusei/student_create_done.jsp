<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file ="menu.jsp" %>

<%
    String result = (String) request.getAttribute("result");
    String errorMessage = (String) request.getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登録結果 - 学生管理システム</title>
</head>
<body>

<div class="content">
    <h2>学生情報登録結果</h2>

    <%
        if ("success".equals(result)) {
    %>
        <h3>学生情報が正常に登録されました。</h3>
        <a href="Student_create.jsp">別の学生を追加</a>
        <a href="Student_list.jsp">学生一覧へ戻る</a>
    <%
        } else {
    %>
        <h3>学生情報の登録に失敗しました。</h3>
        <p>エラー内容: <%= errorMessage %></p>
        <a href="Student_create.jsp">再試行</a>
    <%
        }
    %>
</div>

</body>
</html>
