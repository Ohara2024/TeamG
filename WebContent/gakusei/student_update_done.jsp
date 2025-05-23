<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>学生情報更新結果</title>
    <style>
        body { font-family: "メイリオ", Meiryo, sans-serif; background-color: #f5f5f5; }
        .content { padding: 30px; background: #fff; margin: 50px auto; width: 80%; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        p { font-size: 16px; }
        a { color: #007bff; text-decoration: none; font-weight: bold; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
<% request.setCharacterEncoding("UTF-8"); %>
<div class="content">
<%
    String studentId = request.getParameter("student_id");
    String studentName = request.getParameter("student_name");
    String className = request.getParameter("class_name");  // ← 修正

    String url = "jdbc:h2:tcp://localhost/~/gakusei";
    String user = "sa";
    String password = "";

    Connection conn = null;
    PreparedStatement pstmt = null;
    int updateCount = 0;

    try {
        Class.forName("org.h2.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // プレースホルダを使ってセキュリティを強化
        String query = "UPDATE 学生 SET 学生名 = ?, クラス = ? WHERE 学生番号 = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, studentName);
        pstmt.setString(2, className); // ← 修正: クラス名を直接挿入
        pstmt.setString(3, studentId);

        updateCount = pstmt.executeUpdate();

    } catch (SQLException | ClassNotFoundException e) {
%>
    <p style="color:red;">更新エラー: <%= e.getMessage() %></p>
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

    if (updateCount > 0) {
%>
    <p>学生情報の更新が正常に完了しました。</p>
    <a href="StudentList.jsp">学生一覧に戻る</a>
<%
    } else {
%>
    <p>学生情報の更新に失敗しました。</p>
    <a href="StudentUpdate.jsp?studentId=<%= studentId %>">戻る</a>
<%
    }
%>
</div>
</body>
</html>
