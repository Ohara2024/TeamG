<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>得点管理システム</title>

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

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    th, td {
        border: 1px solid #ccc;
        padding: 12px;
        text-align: center;
    }

    th {
        background-color: #f0f0f0;
        color: #333;
    }

    tr:nth-child(even) {
        background-color: #fafafa;
    }

    tr:hover {
        background-color: #e6f7ff;
    }

    .link {
        text-align: center;
        margin-top: 30px;
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
    <p>学生情報を入力してください</p>
    <form action="studentlst.jsp" method="POST">

		<!--入学年度入力フィールド  -->
		<div class="form-group">
            <label for="start_year">入学年度:</label>
            <input type="text" name="start_year" required />
        </div>

        <!-- 学生番号入力フィールド -->
        <div class="form-group">
            <label for="student_id">学生番号:</label>
            <input type="text" name="student_id" required />
        </div>

        <!-- 学生名入力フィールド -->
        <div class="form-group">
            <label for="student_name">学生名:</label>
            <input type="text" name="student_name" required />
        </div>

        <!-- 学校ID選択フィールド -->
        <div class="form-group">
            <label for="school_id">学校名:</label>
            <select name="school_id" required>
                <option value="">学校を選択</option>
                <%
                    String url = "jdbc:h2:tcp://localhost/~/gakusei";
                    String user = "sa";
                    String password = "";
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("org.h2.Driver");
                        conn = DriverManager.getConnection(url, user, password);
                        stmt = conn.createStatement();
                        String query = "SELECT 学校ID, 学校名 FROM 学校";
                        rs = stmt.executeQuery(query);
                        while (rs.next()) {
                            int schoolId = rs.getInt("学校ID");
                            String schoolName = rs.getString("学校名");
                %>
                            <option value="<%= schoolId %>"><%= schoolName %> (ID: <%= schoolId %>)</option>
                <%
                        }
                    } catch (SQLException | ClassNotFoundException e) {
                        out.println("<p style='color:red;'>データベース接続エラー: " + e.getMessage() + "</p>");
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </select>
        </div>

        <!-- 追加ボタン -->
        <input type="submit" value="追加">
    </form>
</div>
</body>
</html>