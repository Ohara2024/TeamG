<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="dao.*" %>
<%@ page import="bean.*" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>成績一覧</title>
    <style>
        /* CSSスタイルは省略（前回のコードと同じ内容） */
    </style>
</head>
<body>
    <div class="container">
        <%
            // セッションから教師情報を取得 (LoginActionでセットされている前提)
            Teacher teacher = (Teacher) session.getAttribute("teacher");
            // セッションから学校情報を取得 (TeacherDaoで取得されている前提)
            School school = (School) session.getAttribute("school");

            // エラーメッセージの初期化
            String subjectSearchError = (String) request.getAttribute("subjectSearchError");
            String studentSearchError = (String) request.getAttribute("studentSearchError");
            String generalError = (String) request.getAttribute("error"); // 汎用エラー

            // 検索結果リストの初期化
            List<TestListSubject> subjectGradesList = new ArrayList<>();
            List<Test> studentGradesList = new ArrayList<>(); // Testクラスのリスト

            // 選択済みの値の初期化
            String selectedEntYear = request.getParameter("enrollmentYear");
            String selectedClassNum = request.getParameter("classId");
            String selectedSubject = request.getParameter("subject");
            String selectedStudentId = request.getParameter("studentId");

            // ドロップダウンリスト用のデータ取得
            List<Integer> entYears = new ArrayList<>();
            List<String> classNums = new ArrayList<>();
            List<Subject> subjects = new ArrayList<>();

            try {
                // 入学年度リストの生成（現在の年から過去10年）
                int currentYear = LocalDate.now().getYear();
                for (int i = 0; i < 10; i++) {
                    entYears.add(currentYear - i);
                }

                // クラス番号リストの取得
                if (school != null) {
                    ClassNumDao cndao = new ClassNumDao();
                    classNums = cndao.filter(school);
                }

                // 科目リストの取得
                if (school != null) {
                    SubjectDao sdao = new SubjectDao();
                    subjects = sdao.filter(school);
                }
            } catch (Exception e) {
                e.printStackTrace();
                generalError = "データの初期ロード中にエラーが発生しました: " + e.getMessage();
            }

            // --- 科目別検索処理 ---
            // subjectSearchTriggerが設定されていれば科目別検索を実行
            if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("subjectSearchTrigger") != null) {
                try {
                    int entYear = 0;
                    if (selectedEntYear != null && !selectedEntYear.isEmpty()) {
                        entYear = Integer.parseInt(selectedEntYear);
                    }
                    String classNum = selectedClassNum;
                    String subjectName = selectedSubject; // 科目名

                    Subject subject = null;
                    if (school != null && subjectName != null && !subjectName.isEmpty()) {
                        for (Subject s : subjects) {
                            if (s.getName().equals(subjectName)) {
                                subject = s;
                                break;
                            }
                        }
                    }

                    if (entYear == 0 || classNum == null || classNum.isEmpty() || subject == null) {
                        subjectSearchError = "missing_criteria";
                    } else {
                        TestListSubjectDao tlsDao = new TestListSubjectDao();
                        subjectGradesList = tlsDao.filter(entYear, classNum, subject, school);
                        if (subjectGradesList.isEmpty()) {
                            subjectSearchError = "no_subject_data_found";
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    generalError = "科目別検索中にエラーが発生しました: " + e.getMessage();
                }
            }

            // --- 学生別検索処理 ---
            // studentSearchTriggerが設定されていれば学生別検索を実行
            if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("studentSearchTrigger") != null) {
                try {
                    String studentId = selectedStudentId;

                    if (studentId == null || studentId.isEmpty()) {
                        studentSearchError = "missing_student_id";
                    } else {
                        StudentDao studentDao = new StudentDao();
                        Student student = studentDao.get(studentId);

                        if (student == null || school == null || !student.getSchool().getCd().equals(school.getCd())) {
                            studentSearchError = "no_student_data";
                        } else {
                            TestDao testDao = new TestDao();
                            // ★★★ ここでfilterメソッドの引数がStudentとSchoolであることを想定 ★★★
                            studentGradesList = testDao.filter(student, school);

                            if (studentGradesList.isEmpty()) {
                                studentSearchError = "no_test_data";
                            } else {
                                // 学生の氏名と入学年度も取得して表示
                                request.setAttribute("studentInfo", student);
                            }
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    generalError = "学生別検索中にエラーが発生しました: " + e.getMessage();
                }
            }
        %>

        <div class="header">
            <h1>成績管理システム</h1>
            <div class="logout">
                <p>ようこそ、<%= (teacher != null ? teacher.getName() : "ゲスト") %>先生</p>
                <a href="menu.jsp">メニューに戻る</a> <%-- ここをmenu.jspに直接リンク --%>
            </div>
        </div>

        <h2>成績一覧</h2>

        <% if (generalError != null && !generalError.isEmpty()) { %>
            <p class="error-message"><span class="error-icon">！</span><%= generalError %></p>
        <% } %>

        <form action="test_list.jsp" method="post" id="subjectSearchForm">
            <input type="hidden" name="subjectSearchTrigger" value="true">
            <div class="search-section">
                <label>科目情報</label>
                <div class="search-group">
                    <select name="enrollmentYear" id="enrollmentYear">
                        <option value="">--------</option>
                        <% for (Integer year : entYears) { %>
                            <option value="<%= year %>" <%= (selectedEntYear != null && selectedEntYear.equals(String.valueOf(year)) ? "selected" : "") %>>
                                <%= year %>
                            </option>
                        <% } %>
                    </select>
                </div>
                <div class="search-group">
                    <select name="classId" id="classId">
                        <option value="">--------</option>
                        <% for (String cls : classNums) { %>
                            <option value="<%= cls %>" <%= (selectedClassNum != null && selectedClassNum.equals(cls) ? "selected" : "") %>>
                                <%= cls %>
                            </option>
                        <% } %>
                    </select>
                </div>
                <div class="search-group">
                    <select name="subject" id="subject">
                        <option value="">--------</option>
                        <% for (Subject s : subjects) { %>
                            <option value="<%= s.getName() %>" <%= (selectedSubject != null && selectedSubject.equals(s.getName()) ? "selected" : "") %>>
                                <%= s.getName() %>
                            </option>
                        <% } %>
                    </select>
                </div>
                <button type="submit">検索</button>
            </div>
            <% if ("missing_criteria".equals(subjectSearchError)) { %>
                <p class="error-message"><span class="error-icon">！</span>入学年度、クラス、科目のいずれかが選択されていません。</p>
            <% } else if ("no_subject_data_found".equals(subjectSearchError) && request.getParameter("subjectSearchTrigger") != null) { %>
                <p class="error-message"><span class="error-icon">！</span>指定された科目の成績データが見つかりませんでした。</p>
            <% } %>
        </form>

        <% if (!subjectGradesList.isEmpty()) { %>
            <div class="subject-info-line"> 科目：<%= selectedSubject %></div>
            <table class="result-table">
                <thead>
                    <tr>
                        <th></th>
                        <th>入学年度</th>
                        <th>クラス</th>
                        <th>学生番号</th>
                        <th>氏名</th>
                        <th>1回</th>
                        <th>2回</th>
                        <th>平均点</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (TestListSubject test : subjectGradesList) { %>
                        <tr>
                            <td></td>
                            <td><%= test.getEntYear() %></td>
                            <td><%= test.getClassNum() %></td>
                            <td><%= test.getStudentNo() %></td>
                            <td><%= test.getStudentName() %></td>
                            <td><%= test.getPoint(1) != null ? test.getPoint(1) : "-" %></td>
                            <td><%= test.getPoint(2) != null ? test.getPoint(2) : "-" %></td>
                            <td>
                                <%
                                    Integer point1 = test.getPoint(1);
                                    Integer point2 = test.getPoint(2);
                                    if (point1 != null && point2 != null) {
                                        out.print(String.format("%.1f", (point1 + point2) / 2.0)); // 小数点以下1桁まで
                                    } else {
                                        out.print("-");
                                    }
                                %>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else if ("no_subject_data_found".equals(subjectSearchError) && request.getParameter("subjectSearchTrigger") != null) { %>
             <p class="instruction-message">該当する科目別成績データはありませんでした。</p>
        <% } else if (request.getParameter("subjectSearchTrigger") != null && subjectGradesList.isEmpty()) { %>
             <p class="instruction-message">検索条件に一致する科目別成績データは見つかりませんでした。</p>
        <% } %>


        <form action="test_list.jsp" method="post" id="studentSearchForm">
            <input type="hidden" name="studentSearchTrigger" value="true">
            <div class="search-section">
                <label>学生情報</label>
                <div class="search-group">
                    <input type="text" name="studentId" id="studentId" placeholder="学生番号を入力してください" value="<%= selectedStudentId != null ? selectedStudentId : "" %>">
                </div>
                <button type="submit">検索</button>
            </div>
            <% if ("missing_student_id".equals(studentSearchError)) { %>
                <p class="error-message"><span class="error-icon">！</span>学生番号を入力してください。</p>
            <% } else if ("no_student_data".equals(studentSearchError)) { %>
                <p class="error-message"><span class="error-icon">！</span>学生情報が存在しませんでした。</p>
            <% } else if ("no_test_data".equals(studentSearchError) && request.getParameter("studentSearchTrigger") != null) { %>
                 <p class="error-message"><span class="error-icon">！</span>指定された学生の成績データが見つかりませんでした。</p>
            <% } %>
        </form>

        <% if (!studentGradesList.isEmpty()) {
            Student studentInfo = (Student) request.getAttribute("studentInfo");
            if (studentInfo != null) {
        %>
            <div class="subject-info-line">
                学生番号: <%= studentInfo.getNo() %><br>
                氏名: <%= studentInfo.getName() %>
            </div>
            <table class="result-table">
                <thead>
                    <tr>
                        <th>科目コード</th>
                        <th>科目名</th>
                        <th>1回</th>
                        <th>2回</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    // 学生のテスト結果を科目ごとに整理するためのマップ（今回使わないため削除してもOK）
                    // Map<String, Test> studentSubjectTests = new HashMap<>();
                    // for (Test test : studentGradesList) {
                    //     studentSubjectTests.put(test.getSubject().getCd(), test);
                    // }

                    // 全ての科目に対して表示
                    for (Subject s : subjects) { // 全ての科目をループ
                        Test test1 = null;
                        Test test2 = null;
                        for(Test t : studentGradesList) {
                            // nullチェックを追加: t.getSubject() や t.getSubject().getCd() が null の可能性も考慮
                            if(t.getSubject() != null && t.getSubject().getCd() != null && t.getSubject().getCd().equals(s.getCd())) {
                                if (t.getNo() == 1) {
                                    test1 = t;
                                } else if (t.getNo() == 2) {
                                    test2 = t;
                                }
                            }
                        }
                    %>
                        <tr>
                            <td><%= s.getCd() %></td>
                            <td><%= s.getName() %></td>
                            <td><%= (test1 != null && test1.getPoint() != null) ? test1.getPoint() : "-" %></td>
                            <td><%= (test2 != null && test2.getPoint() != null) ? test2.getPoint() : "-" %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% }
        } else if ("no_test_data".equals(studentSearchError) && request.getParameter("studentSearchTrigger") != null) { %>
            <p class="instruction-message">該当する学生別成績データはありませんでした。</p>
        <% } else if (request.getParameter("studentSearchTrigger") != null && studentGradesList.isEmpty()) { %>
            <p class="instruction-message">検索条件に一致する学生別成績データは見つかりませんでした。</p>
        <% } %>
    </div>
</body>
</html>