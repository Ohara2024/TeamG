<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:include page="menu.jsp" />


<html>
<head>
    <title>更新完了</title>
    <style>
        body {
            font-family: sans-serif;
            text-align: center;
            margin-top: 100px;
            background-color: #f0f0f0;
        }
        .box {
            display: inline-block;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.2);
        }
        a {
            margin-top: 15px;
            display: inline-block;
            text-decoration: none;
            color: #337ab7;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="box">
        <h2>学生情報を更新しました。</h2>
        <a href="student">← 学生一覧へ戻る</a>
    </div>
</body>
</html>
