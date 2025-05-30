<%@ page contentType="text/html;charset=UTF-8" language="java" import="bean.Student" %>
<jsp:include page="menu.jsp" />

<%
    Student student = (Student) request.getAttribute("student");
%>
<!DOCTYPE html>
<html>
<head>
    <title>学生情報編集</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 40px;
            background-color: #f4f4f4;
        }

        h2 {
            color: #333;
        }

        form {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            max-width: 500px;
            margin: auto;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }

        input[type="text"], input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #2196F3;
            color: white;
            font-weight: bold;
            margin-top: 20px;
            cursor: pointer;
            border: none;
        }

        input[type="submit"]:hover {
            background-color: #1976D2;
        }

        a {
            display: block;
            margin: 20px auto;
            text-align: center;
            color: #2196F3;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h2 style="text-align:center;">学生情報の編集</h2>
    <form action="student" method="post">
        <input type="hidden" name="action" value="update"/>
        <input type="hidden" name="no" value="<%= student.getNo() %>"/>

        <label for="entYear">入学年度:</label>
        <input type="text" id="entYear" name="entYear" value="<%= student.getEntYear() %>" required>

        <label for="no">学生番号:</label>
        <input type="text" id="no" name="no" value="<%= student.getNo() %>" required>

        <label for="name">氏名:</label>
        <input type="text" id="name" name="name" value="<%= student.getName() %>" required>

        <label for="classNum">クラス:</label>
        <input type="text" id="classNum" name="classNum" value="<%= student.getClassNum() %>" required>

        <input type="submit" value="更新">
    </form>

    <a href="student">←学生一覧に戻る</a>
</body>
</html>
