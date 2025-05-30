package scoremanager.main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/student/StudentCreate.action")
public class StudentCreateAction extends HttpServlet {

    private static final String DB_URL = "jdbc:h2:tcp://localhost/~/gakusei";
    private static final String DB_USER = "sa";
    private static final String DB_PASS = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // パラメータ取得
        String studentIdStr = request.getParameter("student_id");
        String name = request.getParameter("student_name");
        String className = request.getParameter("class_name");
        String nyugakuNendoStr = request.getParameter("nyugakunendo");

        try {
            int studentId = Integer.parseInt(studentIdStr);
            int nyugakuNendo = Integer.parseInt(nyugakuNendoStr);

            // DB接続とINSERT処理
            Class.forName("org.h2.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                 PreparedStatement pstmt = conn.prepareStatement(
                     "INSERT INTO 学生 (学生ID, 氏名, クラス, 入学年度) VALUES (?, ?, ?, ?)")
            ) {
                pstmt.setInt(1, studentId);
                pstmt.setString(2, name);
                pstmt.setString(3, className);
                pstmt.setInt(4, nyugakuNendo);

                int result = pstmt.executeUpdate();

                if (result > 0) {
                    // 正常に登録された場合、一覧画面へリダイレクト
                    response.sendRedirect(request.getContextPath() + "/student/StudentList.action");
                } else {
                    request.setAttribute("errorMessage", "学生情報の登録に失敗しました。");
                    request.getRequestDispatcher("/student_create.jsp").forward(request, response);
                }
            }

        } catch (Exception e) {
            request.setAttribute("errorMessage", "エラーが発生しました: " + e.getMessage());
            request.getRequestDispatcher("/student_create.jsp").forward(request, response);
        }
    }
}
