<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>得点管理システム - ログアウト</title>
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
        }

        header h1 {
            margin: 0;
            font-size: 24px;
        }

        .container {
            padding: 40px;
            text-align: center;
        }

        .title {
            font-size: 20px;
            background-color: #eeeeee;
            padding: 10px;
            margin-bottom: 20px;
        }

        .message {
            background-color: #a6d8a8;
            padding: 10px;
            font-size: 16px;
            margin-bottom: 20px;
        }

        .login-link {
            font-size: 16px;
        }

        .login-link a {
            color: #007bff;
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
    </header>
        
    <div class="container">
        <div class="title">ログアウト</div>
        <div class="message">ログアウトしました</div>
        <div class="login-link"><a href="${pageContext.request.contextPath}/main/Login.action">ログイン</a></div>
    </div>

    <footer>
        &copy; 2025 TIC<br>大原学園
    </footer>
</body>
</html>
