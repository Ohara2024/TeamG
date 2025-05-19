<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="bean.TestListStudent" %>
<html>
<head>
    <title>成績一覧</title>
</head>
<body>
    <h2>成績一覧（学生毎）</h2>

    <p>学生番号: <%= request.getAttribute("studentNo") %></p>

    <%
        List<TestListStudent> resultList = (List<TestListStudent>) request.getAttribute("resultList");
        if (resultList == null || resultList.isEmpty()) {
    %>
        <p>成績情報が見つかりませんでした。</p>
    <%
        } else {
    %>
        <table border="1">
            <tr>
                <th>科目名</th>
                <th>科目コード</th>
                <th>回数</th>
                <th>得点</th>
            </tr>
            <%
                for (TestListStudent test : resultList) {
            %>
                <tr>
                    <td><%= test.getSubjectName() %></td>
                    <td><%= test.getSubjectCd() %></td>
                    <td><%= test.getNum() %></td>
                    <td><%= test.getPoint() %></td>
                </tr>
            <%
                }
            %>
        </table>
    <%
        }
    %>
</body>
</html>

