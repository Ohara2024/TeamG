<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>成績参照</title>
    <style>
        body { font-family: sans-serif; }
        .form-box { border: 1px solid #ccc; padding: 20px; width: 600px; margin: auto; }
        .form-row { margin-bottom: 10px; }
        label { display: inline-block; width: 100px; }
        select, input[type="text"] { width: 200px; }
        .error { color: red; }
    </style>
</head>
<body>
    <h2 style="text-align: center;">成績参照</h2>

    <div class="form-box">
        <form action="TestListAction" method="post">
            <div class="form-row">
                <label>入学年度</label>
                <input type="text" name="entYear" placeholder="例: 2025">
            </div>
            <div class="form-row">
                <label>クラス</label>
                <input type="text" name="className" placeholder="例: A">
            </div>
            <div class="form-row">
                <label>科目</label>
                <select name="subjectCd">
                    <option value="">--------</option>
                    <option value="101">国語</option>
                    <option value="102">数学</option>
                    <option value="103">英語</option>
                    <!-- 必要に応じて追加 -->
                </select>
            </div>
            <div class="form-row">
                <input type="submit" value="検索">
            </div>
        </form>

        <hr>

        <form action="TestListAction" method="post">
            <div class="form-row">
                <label>学生番号</label>
                <input type="text" name="studentNo" placeholder="学生番号を入力してください">
                <input type="submit" value="検索">
            </div>
        </form>

        <% if (request.getAttribute("error") != null) { %>
            <p class="error"><%= request.getAttribute("error") %></p>
        <% } %>

        <p style="font-size: small; color: #888;">科目情報を選択または学生情報を入力して検索ボタンをクリックしてください</p>
    </div>
</body>
</html>