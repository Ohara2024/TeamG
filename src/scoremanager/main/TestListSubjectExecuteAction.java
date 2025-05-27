package scoremanager.main;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.ClassNum;
import bean.SchoolCdHolder; // ★追加: SchoolCdHolderをインポート
import bean.Subject;
import bean.Test;
import bean.User;
import dao.ClassNumDao;
import dao.StudentDao;
import dao.SubjectDao;
import dao.TestDao;

public class TestListSubjectExecuteAction {

    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !user.isAuthenticated()) { // 認証済みかどうかもチェック
            res.sendRedirect("login.jsp");
            return;
        }

        // ★修正: SchoolCdHolderから学校コードを取得する
        SchoolCdHolder schoolCdHolder = (SchoolCdHolder) session.getAttribute("schoolCdHolder");
        String schoolCd = null;
        if (schoolCdHolder != null) {
            schoolCd = schoolCdHolder.getSchoolCd();
        }

        if (schoolCd == null || schoolCd.isEmpty()) {
            req.setAttribute("message", "学校コードが取得できませんでした。再度ログインしてください。");
            // JSPにフォワードするか、ログインページに戻す
            // req.getRequestDispatcher("test_list_subject.jsp").forward(req, res);
            return;
        }

        // フォームから入力された値を取得
        String entYearStr = req.getParameter("entYear");
        String classNum = req.getParameter("classNum");
        String subjectCd = req.getParameter("subjectCd");
        String studentNo = req.getParameter("studentNo");

        // 入力内容をJSPのフォームに初期値としてセットするためにリクエストスコープに保存
        req.setAttribute("paramEntYear", entYearStr != null ? entYearStr : "");
        req.setAttribute("paramClassNum", classNum != null ? classNum : "");
        req.setAttribute("paramSubjectCd", subjectCd != null ? subjectCd : "");
        req.setAttribute("paramStudentNo", studentNo != null ? studentNo : "");

        // ドロップダウンリストの再設定（検索後もリストは必要）
        ClassNumDao classNumDao = new ClassNumDao();
        List<ClassNum> classList = classNumDao.filterBySchool(schoolCd);
        req.setAttribute("classList", classList);

        SubjectDao subjectDao = new SubjectDao();
        List<Subject> subjectList = subjectDao.filterBySchool(schoolCd);
        req.setAttribute("subjectList", subjectList);

        StudentDao studentDao = new StudentDao();
        List<Integer> allEntYears = studentDao.getEntYearBySchool(schoolCd);
        Set<Integer> entYearSet = new HashSet<>(allEntYears);
        req.setAttribute("entYearSet", entYearSet);

        String message = "";
        List<Test> tests = new ArrayList<>();
        String selectedSubjectName = "";

        if (studentNo != null && !studentNo.isEmpty()) {
            TestDao testDao = new TestDao();
            tests = testDao.filterByStudent(studentNo, schoolCd);
            if (tests.isEmpty()) {
                message = "該当する学生のテスト結果が見つかりませんでした。";
            }
        } else {
            Integer entYear = null;
            if (entYearStr != null && !entYearStr.isEmpty()) {
                try {
                    entYear = Integer.parseInt(entYearStr);
                } catch (NumberFormatException e) {
                    message = "入学年度が不正な値です。";
                }
            }

            if (message.isEmpty()) {
                if (entYear == null && (classNum == null || classNum.isEmpty()) && (subjectCd == null || subjectCd.isEmpty())) {
                    message = "検索条件を入力してください。";
                } else if ((entYear == null) && (classNum != null && !classNum.isEmpty())) {
                    message = "クラスが選択されている場合、入学年度も選択してください。";
                } else {
                    TestDao testDao = new TestDao();
                    tests = testDao.filter(entYear, classNum, subjectCd, schoolCd);

                    if (tests.isEmpty()) {
                        message = "該当するテスト結果が見つかりませんでした。";
                    } else {
                        if (subjectCd != null && !subjectCd.isEmpty()) {
                            for (Subject sub : subjectList) {
                                if (sub.getCd().equals(subjectCd)) {
                                    selectedSubjectName = sub.getName();
                                    break;
                                }
                            }
                        }
                    }
                }
            }
        }

        req.setAttribute("tests", tests);
        req.setAttribute("message", message);
        req.setAttribute("selectedSubjectName", selectedSubjectName);

        // JSPにフォワード
        // req.getRequestDispatcher("test_list_subject.jsp").forward(req, res);
    }
}