<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>ログイン - 得点管理システム</title>
  <style>
   * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }

   body {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background-color: #f0f8ff; /* 明るい背景 */
    font-family: Arial, sans-serif;
    text-align: center;
}

.title {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 20px;
    color: #007acc; /* 青 */
}

.login-container {
    background: #ffffff; /* 白背景 */
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.2);
    width: 100%;
    max-width: 350px;
    color: #333;
}

h2 {
    margin-bottom: 20px;
    color: #007acc;
}

label {
    display: block;
    text-align: left;
    font-weight: bold;
    margin: 10px 0 5px;
    color: #333;
}

input {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 5px;
    background-color: #f9f9f9;
    color: #333;
}

input[type="submit"] {
    background: #007acc;
    color: white;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: 0.3s;
    border: none;
}

input[type="submit"]:hover {
    background: #005fa3;
}

p {
    color: #d32f2f; /* 赤エラー */
    font-size: 14px;
    margin-top: 10px;
}
  </style>
</head>
<body>
  <div class="title">得点管理システム</div>
  <div class="login-container">
    <h2>ログイン</h2>
    <form action="LoginServlet" method="post">
      <label for="username">ユーザー名:</label>
      <input type="text" id="username" name="username" required>
      <label for="password">パスワード:</label>
      <input type="password" id="password" name="password" required>
      <input type="submit" value="ログイン">
    </form>
    <br></br>
    <p style="color:red;">
      <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
    </p>
  </div>
</body>
</html>
