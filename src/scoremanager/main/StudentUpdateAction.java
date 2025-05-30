package scoremanager.main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/student/StudentUpdate.action")
public class StudentUpdateAction extends HttpServlet {

    private static final String DB_URL = "jdbc:h2:tcp://localhost/~/gakusei";
    private static final String DB_USER = "sa";
    private static final String DB_PASS = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String studentIdStr = request.getParameter("id");

        if (studentIdStr == null || studentIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/student/StudentList.action");
            return;
        }

        try {
            int studentId = Integer.parseInt(studentIdStr);

            Class.forName("org.h2.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

                String sql = "SELECT 学生ID, 氏名, クラス, 入学年度 FROM 学生 WHERE 学生ID = ?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, studentId);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    request.setAttribute("student_id", rs.getInt("学生ID"));
                    request.setAttribute("student_name", rs.getString("氏名"));
                    request.setAttribute("class_name", rs.getString("クラス"));
                    request.setAttribute("nyugakunendo", rs.getInt("入学年度"));
                }

                rs.close();
                pstmt.close();
            }

            RequestDispatcher dispatcher = request.getRequestDispatcher("/student/StudentUpdateForm.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            throw new ServletException("学生情報の取得に失敗しました: " + e.getMessage(), e);
        }
    }
}
