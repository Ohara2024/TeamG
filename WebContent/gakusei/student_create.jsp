<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>学生追加処理 - 学生管理システム</title>
    <style>
    body {
        font-family: "メイリオ", Meiryo, sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 0;
    }

    .content {
        width: 80%;
        margin: 40px auto;
        background-color: #ffffff;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    h2 {
        text-align: center;
        color: #333;
    }

    p {
        text-align: center;
        font-size: 16px;
        margin-top: 30px;
    }

    .link {
        text-align: center;
        margin-top: 20px;
    }

    .link a {
        text-decoration: none;
        color: #007bff;
        font-weight: bold;
    }

    .link a:hover {
        text-decoration: underline;
    }
    </style>
</head>
<body>
<div class="content">
<%
    request.setCharacterEncoding("UTF-8");

    String nyugakuNendo = request.getParameter("nyugakunendo");
    String gakuseiBangou = request.getParameter("gakuseiBangou");
    String studentName = request.getParameter("student_name");
    String className = request.getParameter("class_name");  // ← 修正：学校IDではなくクラス名

    String url = "jdbc:h2:tcp://localhost/~/gakusei";
    String user = "sa";
    String password = "";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("org.h2.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // クラス名を直接保存する形式に変更
        String query = "INSERT INTO 学生 (入学年度, 学生番号, 氏名, クラス) VALUES (?, ?, ?, ?)";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, nyugakuNendo);
        pstmt.setString(2, gakuseiBangou);
        pstmt.setString(3, studentName);
        pstmt.setString(4, className);  // ← 修正：クラス名を挿入

        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
%>
    <p>学生情報が正常に追加されました。</p>
    <div class="link">
        <a href="Studentlist.jsp">学生一覧に戻る</a>
    </div>
<%
        } else {
%>
    <p style="color:red;">学生情報の追加に失敗しました。</p>
<%
        }
    } catch (SQLException | ClassNotFoundException e) {
%>
    <p style="color:red;">エラー: <%= e.getMessage() %></p>
<%
        e.printStackTrace();
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
</div>
</body>
</html>
