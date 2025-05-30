<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.TreeSet"%>
<%@ page import="dao.*"%>
<%@ page import="bean.*"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ page import="javax.servlet.http.HttpSession"%>

<%
    List<Test> tests = new ArrayList<>();
    String message = "";
    String selectedSubjectName = "";

    Set<Integer> entYearSet = new TreeSet<>();
    List<ClassNum> classList = new ArrayList<>();
    List<Subject> subjectList = new ArrayList<>();

    String paramEntYear = request.getParameter("entYear");
    String paramClassNum = request.getParameter("classNum");
    String paramSubjectCd = request.getParameter("subjectCd");
    String paramStudentNo = request.getParameter("studentNo");

    Integer entYear = null;

    SchoolCdHolder schoolCdHolder = (SchoolCdHolder) session.getAttribute("schoolCdHolder");
    String schoolCd = null;
    if (schoolCdHolder != null) {
        schoolCd = schoolCdHolder.getSchoolCd();
    }

    if (schoolCd == null || schoolCd.isEmpty()) {
        message = "学校コードが取得できません。ログインし直してください。";
    } else {
        TestDao testDao = new TestDao();
        ClassNumDao classNumDao = new ClassNumDao();
        SubjectDao subjectDao = new SubjectDao();
        StudentDao studentDao = new StudentDao();

        try {
            entYearSet.addAll(studentDao.getEntYearBySchool(schoolCd));
        } catch (Exception e) {
            e.printStackTrace();
            message = "入学年度リストの取得に失敗しました。";
        }

        try {
            classList = classNumDao.filterBySchool(schoolCd);
        } catch (Exception e) {
            e.printStackTrace();
            if (message.isEmpty()) message = "クラスリストの取得に失敗しました。";
        }

        try {
            subjectList = subjectDao.filterBySchool(schoolCd);
        } catch (Exception e) {
            e.printStackTrace();
            if (message.isEmpty()) message = "科目リストの取得に失敗しました。";
        }

        if (paramEntYear != null && !paramEntYear.isEmpty()) {
            try {
                entYear = Integer.parseInt(paramEntYear);
            } catch (NumberFormatException e) {
                message = "入学年度が不正な値です。";
            }
        }

        if (message.isEmpty()) { // メッセージがまだ設定されていない場合のみ検索を実行
            try {
                if (paramStudentNo != null && !paramStudentNo.isEmpty()) {
                    tests = testDao.filterByStudent(paramStudentNo, schoolCd);
                    if (tests.isEmpty()) {
                        message = "指定された学生のテスト結果は見つかりませんでした。";
                    }
                } else {
                    if ((paramEntYear != null && !paramEntYear.isEmpty()) ||
                        (paramClassNum != null && !paramClassNum.isEmpty()) ||
                        (paramSubjectCd != null && !paramSubjectCd.isEmpty())) {

                        tests = testDao.filter(entYear, paramClassNum, paramSubjectCd, schoolCd);

                        if (tests.isEmpty()) {
                            message = "指定された条件のテスト結果は見つかりませんでした。";
                        } else {
                            if (paramSubjectCd != null && !paramSubjectCd.isEmpty()) {
                                for (Subject sub : subjectList) {
                                    if (sub.getCd().equals(paramSubjectCd)) {
                                        selectedSubjectName = sub.getName();
                                        break;
                                    }
                                }
                            }
                        }
                    } else {
                        message = "検索条件を入力してください。";
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                message = "データの取得中にエラーが発生しました：" + e.getMessage();
            }
        }
    }

    request.setAttribute("entYearSet", entYearSet);
    request.setAttribute("classList", classList);
    request.setAttribute("subjectList", subjectList);
    request.setAttribute("tests", tests);
    request.setAttribute("message", message);
    request.setAttribute("selectedSubjectName", selectedSubjectName);

    request.setAttribute("paramEntYear", paramEntYear);
    request.setAttribute("paramClassNum", paramClassNum);
    request.setAttribute("paramSubjectCd", paramSubjectCd);
    request.setAttribute("paramStudentNo", paramStudentNo);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>成績一覧（科目）</title>
<style>
    /* スタイルシートは変更なし */
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

        <form action="" method="post" class="search-form"> <%-- actionを空にして自分自身に送信 --%>
            <div class="form-group">
                <label for="entYear">入学年度</label>
                <select id="entYear" name="entYear">
                    <option value="">選択してください</option>
                    <c:forEach var="year" items="${entYearSet}">
                        <option value="${year}" <c:if test="${paramEntYear == year}">selected</c:if>>${year}</option>
                    </c:forEach>
                </select>

               <label for="classNum">クラス</label>
                <select id="classNum" name="classNum">
                    <option value="">選択してください</option>
                    <c:forEach var="classItem" items="${classList}">
                        <option value="${classItem.num}" <c:if test="${paramClassNum == classItem.num}">selected</c:if>>${classItem.num}</option>
                    </c:forEach>
                </select>

                <label for="subjectCd">科目</label>
                <select id="subjectCd" name="subjectCd">
                    <option value="">選択してください</option>
                    <c:forEach var="subject" items="${subjectList}">
                        <option value="${subject.cd}" <c:if test="${paramSubjectCd == subject.cd}">selected</c:if>>${subject.name}</option>
                    </c:forEach>
                </select>

                <button type="submit">検索</button>
            </div>

            <div class="form-group">
                <label for="studentNo">学生番号</label>
                <input type="text" id="studentNo" name="studentNo" value="${paramStudentNo != null ? paramStudentNo : ''}">
                <button type="submit">学生番号で検索</button>
            </div>
        </form>

        <c:if test="${not empty message}">
            <p class="message">${message}</p>
        </c:if>

        <c:if test="${not empty tests}">
            <div class="results-section">
                <c:if test="${not empty selectedSubjectName}">
                    <p class="results-header">科目：${selectedSubjectName}</p>
                </c:if>
                <c:if test="${empty selectedSubjectName && not empty paramStudentNo && not empty tests}">
                    <p class="results-header">学生番号：${tests[0].student.no}（${tests[0].student.name}）の成績</p>
                </c:if>

                <table>
                    <thead>
                        <tr>
                            <th>入学年度</th>
                            <th>クラス</th>
                            <th>学生番号</th>
                            <th>氏名</th>
                            <th>科目名</th>
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
                                <td>${test.subject.name}</td>

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