<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<%@ include file ="menu.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
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
    <h2>学生一覧</h2>
    <table>
        <tr>
            <th>入学年度</th>
            <th>学生番号</th>
            <th>氏名</th>
            <th>クラス</th>
        </tr>
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

        String query = "SELECT 入学年度, 学生ID AS 学生番号, 学生名, クラス FROM 学生";
        rs = stmt.executeQuery(query);

        while (rs.next()) {
            int nyugakuNendo = rs.getInt("入学年度");
            int gakuseiBangou = rs.getInt("学生番号");
            String name = rs.getString("学生名");
            String kurasu = rs.getString("クラス");
%>
        <tr>
            <td><%= nyugakuNendo %></td>
            <td><%= gakuseiBangou %></td>
            <td><%= name %></td>
            <td><%= kurasu %></td>
        </tr>
<%
        }
    } catch (ClassNotFoundException e) {
        out.println("<p style='color:red;'>JDBCドライバが見つかりません: " + e.getMessage() + "</p>");
    } catch (SQLException e) {
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
    </table>
    <div class="link">
        <a href="index.jsp">Topページへ</a>
    </div>
</div>
</body>
</html>
