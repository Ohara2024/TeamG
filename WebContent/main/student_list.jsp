<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:include page="menu.jsp" />
<%@ page import="java.util.List" %>
<%@ page import="bean.Student" %>

<%
    List<Student> studentList = (List<Student>) request.getAttribute("studentList");
    String result = (String) request.getAttribute("result");
    String errorMessage = (String) request.getAttribute("errorMessage");
%>
<html>
<head>
    <title>学生一覧</title>
    <style>
        body {
            font-family: sans-serif;
            background-color: #f4f4f4;
            margin: 40px;
        }

        h2 {
            color: #333;
        }

        a.button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        a.button:hover {
            background-color: #45a049;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }

        th {
            background-color: #2196F3;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .action-links a {
            margin: 0 5px;
            text-decoration: none;
            color: #2196F3;
        }

        .action-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h2>学生一覧</h2>

    <a href="student?action=create" class="button">＋学生新規登録</a>

    <table>
        <tr>
            <th>学生番号</th>
            <th>入学年度</th>
            <th>氏名</th>
            <th>クラス</th>
            <th>操作</th>
        </tr>
        <%
            if (studentList != null && !studentList.isEmpty()) {
                for (Student s : studentList) {
        %>
        <tr>
            <td><%= s.getNo() %></td>
            <td><%= s.getEntYear() %></td>
            <td><%= s.getName() %></td>
            <td><%= s.getClassNum() %></td>
            <td class="action-links">
                <a href="student?action=edit&no=<%= s.getNo() %>">編集</a>
                |
                <a href="student?action=delete&no=<%= s.getNo() %>" onclick="return confirm('本当に削除しますか？')">削除</a>
            </td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="5">登録された学生がいません。</td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>
