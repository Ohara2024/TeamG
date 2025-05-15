<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>メニュー</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@400;700&display=swap');
        body {
            margin: 0;
            font-family: 'Noto Sans JP', sans-serif;
            background-color: #f4f6f8;
            height: 100vh;
            display: flex;
        }

        .menu {
            width: 260px;
            background: #003366;
            color: white;
            display: flex;
            flex-direction: column;
            box-shadow: 5px 0 15px rgba(0, 0, 0, 0.3);
        }

        .menu h1 {
            text-align: center;
            font-size: 22px;
            margin: 20px 0 10px;
        }

        .menu-items {
            padding: 0 20px;
            flex-grow: 1;
            overflow-y: auto;
        }

        .section-title {
            margin: 20px 0 10px;
            border-bottom: 1px solid rgba(255,255,255,0.3);
            padding-bottom: 4px;
            font-size: 14px;
            font-weight: bold;
            opacity: 0.9;
        }

        ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        li a {
            display: flex;
            align-items: center;
            padding: 10px;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: 0.2s ease;
            font-size: 14px;
        }

        li a i {
            margin-right: 10px;
            width: 20px;
        }

        li a:hover,
        li a.selected {
            background-color: rgba(255,255,255,0.2);
        }

        .welcome {
            text-align: center;
            font-size: 12px;
            margin: 15px 0;
            opacity: 0.8;
        }

        .logout {
            text-align: center;
            color: #ffcccc;
            text-decoration: none;
            font-size: 13px;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .logout:hover {
            color: #ff9999;
        }
    </style>
</head>
<body>
<div class="menu">
    <h1>メニュー</h1>
    <div class="menu-items">
        <div class="section-title">ログイン管理</div>
        <ul>
            <li><a href="login.jsp"><i class="fas fa-sign-in-alt"></i>ログイン</a></li>
            <li><a href="logout.jsp"><i class="fas fa-sign-out-alt"></i>ログアウト</a></li>
        </ul>

        <div class="section-title">学生管理</div>
        <ul>
            <li><a href="StudentAdd.jsp"><i class="fas fa-user-plus"></i>学生登録</a></li>
            <li><a href="StudentEdit.jsp"><i class="fas fa-user-edit"></i>学生変更</a></li>
        </ul>

        <div class="section-title">科目管理</div>
        <ul>
            <li><a href="KamokuAdd.jsp"><i class="fas fa-book-medical"></i>科目登録</a></li>
            <li><a href="Kamoku.jsp"><i class="fas fa-edit"></i>科目変更</a></li>
            <li><a href="KamokuDelete.jsp"><i class="fas fa-trash-alt"></i>科目削除</a></li>
        </ul>

        <div class="section-title">成績管理</div>
        <ul>
            <li><a href="SeisekiAdd.jsp"><i class="fas fa-plus-circle"></i>成績登録</a></li>
            <li><a href="ScoreSelectStudent.jsp"><i class="fas fa-pencil-alt"></i>成績変更</a></li>
        </ul>

        <div class="section-title">成績参照</div>
        <ul>
            <li><a href="KamokuBetuList.jsp"><i class="fas fa-list-alt"></i>科目・クラス毎</a></li>
            <li><a href="GakuseibetuList.jsp"><i class="fas fa-user-graduate"></i>学生毎</a></li>
        </ul>
    </div>
    <p class="welcome">ようこそ <%= session.getAttribute("username") %> さん</p>
    <a href="logout.jsp" class="logout">ログアウト</a>
</div>
</body>
</html>
