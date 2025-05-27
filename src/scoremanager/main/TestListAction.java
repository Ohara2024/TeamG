package scoremanager.main;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.ClassNum;
import bean.SchoolCdHolder; // ★追加: SchoolCdHolderをインポート
import bean.Subject;
import bean.User;
import dao.ClassNumDao;
import dao.StudentDao;
import dao.SubjectDao;

public class TestListAction {

    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user"); // Userオブジェクトで認証済みかチェック

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
            // schoolCdが取得できない場合はエラーとしてログインページに戻すなど
            session.invalidate(); // セッションを無効にする
            res.sendRedirect("login.jsp?error=schoolCd_missing");
            return;
        }

        // 1. ユーザーが所属している学校のクラスデータを取得
        ClassNumDao classNumDao = new ClassNumDao();
        List<ClassNum> classList = classNumDao.filterBySchool(schoolCd);
        req.setAttribute("classList", classList);

        // 2. ユーザーが所属している学校の科目データを取得
        SubjectDao subjectDao = new SubjectDao();
        List<Subject> subjectList = subjectDao.filterBySchool(schoolCd);
        req.setAttribute("subjectList", subjectList);

        // 3. 入学年度のリストを取得（学校全体でユニークな入学年度）
        StudentDao studentDao = new StudentDao();
        List<Integer> allEntYears = studentDao.getEntYearBySchool(schoolCd);
        Set<Integer> entYearSet = new HashSet<>(allEntYears);
        req.setAttribute("entYearSet", entYearSet);

        // 検索条件の初期値を設定 (初回表示時は空)
        req.setAttribute("paramEntYear", "");
        req.setAttribute("paramClassNum", "");
        req.setAttribute("paramSubjectCd", "");
        req.setAttribute("paramStudentNo", "");
        req.setAttribute("message", "");
        req.setAttribute("selectedSubjectName", "");

        // JSPにフォワード
        // 例: req.getRequestDispatcher("test_list_subject.jsp").forward(req, res);
    }
}