<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>得点管理システム - ログイン</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f1f5f9;
            margin: 0;
            padding: 0;
            text-align: center;
        }
        .container {
            margin-top: 80px;
        }
        .login-box {
            background: #fff;
            padding: 40px;
            border-radius: 12px;
            display: inline-block;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            text-align: left;
            width: 300px;
        }
        .login-box h2 {
            margin-bottom: 20px;
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
        }
        .form-check {
            margin: 10px 0;
        }
        .form-check input {
            margin-right: 5px;
        }
        .btn-login {
            width: 100%;
            background-color: #007bff;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn-login:hover {
            background-color: #0056b3;
        }
        footer {
            margin-top: 50px;
            color: #666;
            font-size: 12px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>得点管理システム</h1>
        <div class="login-box">
            <h2>ログイン</h2>
            <form action="scoremanager/gakusei/Login.action" method="post">
                <div class="form-group">
                    <label>ID</label>
                    <input type="text" name="id" value="">
                </div>
                <div class="form-group">
                    <label>パスワード</label>
                    <input type="password" name="pass" id="password">
                </div>
                <div class="form-check">
                    <input type="checkbox" id="showPassword" onclick="togglePassword()">
                    <label for="showPassword">パスワードを表示</label>
                </div>
                <button class="btn-login" type="submit">ログイン</button>
            </form>
        </div>
        <footer>
            &copy; 2025 TIC<br>大原学園
        </footer>
    </div>

    <script>
        function togglePassword() {
            const pw = document.getElementById("password");
            pw.type = pw.type === "password" ? "text" : "password";
        }
    </script>
</body>
</html>