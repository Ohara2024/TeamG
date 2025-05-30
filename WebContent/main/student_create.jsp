<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:include page="menu.jsp" />


<html>
<head>
    <title>学生新規登録</title>
    <style>
        body {
            font-family: sans-serif;
            margin: 40px;
            background-color: #f9f9f9;
        }
        h2 {
            color: #333;
        }
        form {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            width: 400px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        input[type="text"], input[type="submit"] {
            width: 100%;
            padding: 8px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }
        a {
            display: inline-block;
            margin-top: 15px;
            color: #333;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h2>学生新規登録</h2>
    <form action="student" method="post">
        <input type="hidden" name="action" value="insert"/>
        入学年度:<br/>
        <input type="text" name="enrollmentYear" required><br/>
        学生番号:<br/>
        <input type="text" name="studentNumber" required><br/>
        氏名:<br/>
        <input type="text" name="name" required><br/>
        クラス:<br/>
        <input type="text" name="studentClass" required><br/>
        <input type="submit" value="登録">
    </form>
    <a href="student">← 学生一覧に戻る</a>
</body>
</html>
