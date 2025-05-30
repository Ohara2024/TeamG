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
        .container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        h2 {
            margin-bottom: 20px;
        }
        .filter-form {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }
        select, input[type="checkbox"], button {
            padding: 5px;
        }
        .register-link {
            float: right;
            margin-bottom: 10px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            border-bottom: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #2196F3;
            color: white;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .change-link a {
            color: #2196F3;
            text-decoration: none;
        }
        .change-link a:hover {
            text-decoration: underline;
        }
        .search-summary {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <h2>学生管理</h2>

    <a href="student?action=create" class="button">新規登録</a>

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
