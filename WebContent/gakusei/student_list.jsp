<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>得点管理システム</title>
</head>
<body>
<div class="content">
<h2>学生一覧</h2>
<table border="1">
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
        Class.forName("org.h2.Driver"); // JDBCドライバのロード
        conn = DriverManager.getConnection(url, user, password);
        stmt = conn.createStatement();

        String query = "SELECT 学生.入学年度, 学生.学生番号, 学生.学生名, 学生.クラス FROM 学生 JOIN 学校 ON 学生.学校ID = 学校.学校ID";
        rs = stmt.executeQuery(query);

        while (rs.next()) {
            int nyugakuNendo = rs.getInt("入学年度");
            String gakuseiBangou = rs.getString("学生番号");
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
