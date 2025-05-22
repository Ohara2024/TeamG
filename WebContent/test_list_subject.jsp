<%@ page language="java" contentType="text/html; charset=UTF8"
    pageEncoding="UTF8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>成績一覧（科目）</title>
<style>
    body {
        font-family: sans-serif;
        margin: 20px;
    }
    .container {
        max-width: 900px;
        margin: auto;
    }
    h1 {
        text-align: center;
        margin-bottom: 30px;
    }
    .search-form {
        border: 1px solid #ccc;
        padding: 20px;
        margin-bottom: 30px;
        border-radius: 5px;
    }
    .form-group {
        display: flex;
        align-items: center;
        margin-bottom: 15px;
    }
    .form-group label {
        width: 80px;
        margin-right: 10px;
        font-weight: bold;
    }
    .form-group select,
    .form-group input[type="text"] {
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        flex-grow: 1;
    }
    .form-group button {
        padding: 8px 20px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        margin-left: 10px;
    }
    .form-group button:hover {
        background-color: #0056b3;
    }
    .message {
        color: red;
        margin-bottom: 15px;
        text-align: center;
    }
    .results-section {
        border: 1px solid #ccc;
        padding: 20px;
        border-radius: 5px;
    }
    .results-header {
        font-weight: bold;
        margin-bottom: 15px;
        padding-bottom: 5px;
        border-bottom: 1px solid #eee;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 15px;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
    }
    th {
        background-color: #f2f2f2;
    }
</style>
</head>
<body>
    <div class="container">
        <h1>成績一覧（科目）</h1>

        <form action="TestListSubjectExecuteAction" method="post" class="search-form">
            <div class="form-group">
                <label for="entYear">入学年度</label>
                <select id="entYear" name="entYear">
                    <option value="">選択してください</option>
                    <c:forEach var="year" items="${entYearSet}">
                        <option value="${year}" <c:if test="${param.entYear == year}">selected</c:if>>${year}</option>
                    </c:forEach>
                </select>

               <label for="classNum">クラス</label>
                <select id="classNum" name="classNum">
                    <option value="">選択してください</option>
                    <c:forEach var="classItem" items="${classList}">  <%-- ここを 'classItem' に変更 --%>
                        <option value="${classItem.classNum}" <c:if test="${param.classNum == classItem.classNum}">selected</c:if>>${classItem.classNum}</option> <%-- ここも 'classItem' に変更 --%>
                    </c:forEach>
                </select>

                <label for="subjectCd">科目</label>
                <select id="subjectCd" name="subjectCd">
                    <option value="">選択してください</option>
                    <c:forEach var="subject" items="${subjectList}">
                        <option value="${subject.cd}" <c:if test="${param.subjectCd == subject.cd}">selected</c:if>>${subject.name}</option>
                    </c:forEach>
                </select>

                <button type="submit">検索</button>
            </div>

            <div class="form-group">
                <label for="studentNo">学生番号</label>
                <input type="text" id="studentNo" name="studentNo" value="${param.studentNo}">
                <button type="submit">検索</button>
            </div>
        </form>

        <c:if test="${not empty message}">
            <p class="message">${message}</p>
        </c:if>

        <c:if test="${not empty tests}">
            <div class="results-section">
                <p class="results-header">科目：${selectedSubjectName}</p>

                <table>
                    <thead>
                        <tr>
                            <th>入学年度</th>
                            <th>クラス</th>
                            <th>学生番号</th>
                            <th>氏名</th>
                            <th>1回</th>
                            <th>2回</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="test" items="${tests}">
                            <tr>
                                <td>${test.student.entYear}</td>
                                <td>${test.student.classNum}</td>
                                <td>${test.student.no}</td>
                                <td>${test.student.name}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${test.point == -1}">-</c:when>
                                        <c:otherwise>${test.point}</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${test.point2 == -1}">-</c:when>
                                        <c:otherwise>${test.point2}</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
    </div>
</body>
</html>