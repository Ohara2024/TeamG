<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>得点管理システム - メニュー</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }

        header {
            background: #e2ecf9;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        header h1 {
            margin: 0;
            font-size: 24px;
        }

        .logout {
            font-size: 14px;
        }

        .container {
            display: flex;
            margin: 20px;
        }

        .sidebar {
            width: 200px;
        }

        .sidebar a {
            display: block;
            margin: 10px 0;
            color: #007bff;
            text-decoration: none;
        }

        .main-content {
            flex: 1;
            padding-left: 20px;
        }

        .section-title {
            font-weight: bold;
            font-size: 18px;
            margin-bottom: 10px;
        }

        .card-container {
            display: flex;
            gap: 20px;
            margin-top: 20px;
        }

        .card {
            flex: 1;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .student-card {
            background-color: #f2caca;
        }

        .score-card {
            background-color: #c7f2c7;
        }

        .subject-card {
            background-color: #c7c7f2;
        }

        .card a {
            display: block;
            font-size: 16px;
            color: #007bff;
            margin: 5px 0;
            text-decoration: none;
        }

        footer {
            text-align: center;
            font-size: 12px;
            color: #888;
            padding: 30px;
            border-top: 1px solid #ddd;
            margin-top: 50px;
        }
    </style>
</head>
<body>
    <header>
        <h1>得点管理システム</h1>
        <div class="logout">
            ${sessionScope.teacher.name} 様　
            <a href="Logout.action">ログアウト</a>
        </div>
    </header>

    <div class="container">
        <div class="sidebar">
            <div class="section-title">メニュー</div>
            <a href="student/StudentList.action">学生管理</a>
            <div class="section-title">成績管理</div>
            <a href="score/ScoreInsertForm.action">成績登録</a>
            <a href="score/ScoreList.action">成績参照</a>
            <a href="subject/SubjectList.action">科目管理</a>
        </div>

        <div class="main-content">
    <div class="section-title">メニュー</div>
    <div class="card-container">
        <div class="card student-card">
            <a href="student/StudentList.action">学生管理</a>
        </div>
        <div class="card score-card">
            <div class="section-title">成績管理</div>
            <a href="score/ScoreInsertForm.action">成績登録</a>
            <a href="score/ScoreList.action">成績参照</a>
        </div>
        <div class="card subject-card">
            <a href="subject/SubjectList.action">科目管理</a>
        </div>
    </div>
</div>

    </div>

    <footer>
        &copy; 2025 TIC<br>大阪学園
    </footer>
</body>
</html>
