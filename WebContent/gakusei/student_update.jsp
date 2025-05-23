<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>学生更新 - 学生管理システム</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background-color: #f0f4f8;
            margin: 0;
            padding: 0;
        }
        .content {
            max-width: 600px;
            margin: 40px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #2c3e50;
            font-size: 18px;
            font-weight: 500;
            text-align: center;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            font-weight: 500;
            color: #34495e;
            margin-bottom: 5px;
        }
        input[type="text"], select {
            width: 100%;
            padding: 10px;
            border: 1px solid #dcdcdc;
            border-radius: 5px;
            font-size: 14px;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
        }
        input[type="text"]:focus, select:focus {
            border-color: #3498db;
            outline: none;
        }
        input[type="submit"] {
            display: block;
            width: auto;
            padding: 10px 25px;
            background-color: #3498db;
            color: #fff;
            border: none;
            border-radius: 25px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            margin: 10px auto 0;
        }
        input[type="submit"]:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
        }
        p[style*="color:red"] {
            background-color: #ffe6e6;
            padding: 10px;
            border-radius: 5px;
            border-left: 4px solid #e74c3c;
            text-align: left;
        }
    </style>
</head>
<body>

<div class="content">
    <h2>学生情報を更新してください</h2>

<%
    String studentIdParam = request.getParameter("studentId");
    if (studentIdParam == null || studentIdParam.isEmpty()) {
%>
        <p style='color:red;'>学生IDが指定されていません。</p>
<%
    } else {
        int studentId = Integer.parseInt(studentIdParam);
        String url = "jdbc:h2:tcp://localhost/~/gakusei";
        String user = "sa";
        String password = "";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName("org.h2.Driver");
            conn = DriverManager.getConnection(url, user, password);
            String query = "SELECT 学生ID, 学生名, クラス FROM 学生 WHERE 学生ID = ?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, studentId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                String studentName = rs.getString("学生名");
                String className = rs.getString("クラス"); // 文字列として取得
%>

    <form action="StudentUpdateProcess.jsp" method="POST">
        <input type="hidden" name="student_id" value="<%= studentId %>">

        <div class="form-group">
            <label for="student_name">氏名:</label>
            <input type="text" name="student_name" value="<%= studentName %>" required />
        </div>

        <div class="form-group">
            <label for="class_name">クラス:</label>
            <input type="text" name="class_name" value="<%= className %>" required />
        </div>

        <input type="submit" value="更新">
    </form>

<%
            } else {
%>
    <p style='color:red;'>指定された学生が見つかりません。</p>
<%
            }
        } catch (SQLException | ClassNotFoundException e) {
%>
    <p style='color:red;'>エラー: <%= e.getMessage() %></p>
<%
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

</div>
</body>
</html>
