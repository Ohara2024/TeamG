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

@WebServlet("/student/StudentUpdateExecute.action")
public class StudentUpdateExecuteAction extends HttpServlet {

    private static final String DB_URL = "jdbc:h2:tcp://localhost/~/gakusei";
    private static final String DB_USER = "sa";
    private static final String DB_PASS = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            // フォームからの値を取得
            int studentId = Integer.parseInt(request.getParameter("student_id"));
            String name = request.getParameter("student_name");
            String className = request.getParameter("class_name");
            int nyugakuNendo = Integer.parseInt(request.getParameter("nyugakunendo"));

            // データベース接続と更新
            Class.forName("org.h2.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                 PreparedStatement pstmt = conn.prepareStatement(
                     "UPDATE 学生 SET 氏名 = ?, クラス = ?, 入学年度 = ? WHERE 学生ID = ?")) {

                pstmt.setString(1, name);
                pstmt.setString(2, className);
                pstmt.setInt(3, nyugakuNendo);
                pstmt.setInt(4, studentId);

                int result = pstmt.executeUpdate();

                if (result > 0) {
                    // 成功時は学生一覧にリダイレクト
                    response.sendRedirect(request.getContextPath() + "/student/StudentList.action");
                } else {
                    // 該当IDが存在しないなど
                    request.setAttribute("errorMessage", "学生情報の更新に失敗しました。");
                    request.getRequestDispatcher("/student/StudentUpdateForm.jsp").forward(request, response);
                }
            }

        } catch (Exception e) {
            // エラー処理
            request.setAttribute("errorMessage", "更新中にエラーが発生しました: " + e.getMessage());
            request.getRequestDispatcher("/student/StudentUpdateForm.jsp").forward(request, response);
        }
    }
}

