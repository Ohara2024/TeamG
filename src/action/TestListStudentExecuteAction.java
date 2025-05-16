package action;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Student;
import bean.TestListStudent;
import dao.TestListStudentDao;

@WebServlet("/TestListStudentExecuteAction")
public class TestListStudentExecuteAction extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String studentNo = (String) request.getAttribute("studentNo");

        try {
            // 成績情報を取得
            Student student = new Student();
            student.setNo(studentNo);

            TestListStudentDao dao = new TestListStudentDao();
            List<TestListStudent> resultList = dao.filter(student);

            request.setAttribute("resultList", resultList);
            request.setAttribute("studentNo", studentNo);

            // JSPへ転送
            RequestDispatcher dispatcher = request.getRequestDispatcher("/test_list_student.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "成績情報の取得中にエラーが発生しました。");
            request.getRequestDispatcher("/test_list.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
