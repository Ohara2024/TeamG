package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/TestListAction")
public class TestListAction extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String studentNo = request.getParameter("studentNo");

        if (studentNo == null || studentNo.trim().isEmpty()) {
            // 学生番号が未入力：エラーとして入力画面に戻す
            request.setAttribute("error", "学生番号を入力してください。");
            request.getRequestDispatcher("/test_list.jsp").forward(request, response);
        } else {
            // 正常入力：次の処理へ
            request.setAttribute("studentNo", studentNo);
            request.getRequestDispatcher("/TestListStudentExecuteAction").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}