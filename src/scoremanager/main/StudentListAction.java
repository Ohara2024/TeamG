package scoremanager.main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
// 学生情報のBeanクラス
class Student {
    private int studentId;
    private String name;
    private String className;
    private int nyugakuNendo;

    public Student(int studentId, String name, String className, int nyugakuNendo) {
        this.studentId = studentId;
        this.name = name;
        this.className = className;
        this.nyugakuNendo = nyugakuNendo;
    }

    public int getStudentId() { return studentId; }
    public String getName() { return name; }
    public String getClassName() { return className; }
    public int getNyugakuNendo() { return nyugakuNendo; }
}

@WebServlet("/student/StudentList.action")
public class StudentListAction extends HttpServlet {
    private static final String DB_URL = "jdbc:h2:tcp://localhost/~/gakusei";
    private static final String DB_USER = "sa";
    private static final String DB_PASS = "";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<Student> students = new ArrayList<>();

        try {
            Class.forName("org.h2.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            String sql = "SELECT 学生ID, 氏名, クラス, 入学年度 FROM 学生";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("学生ID");
                String name = rs.getString("氏名");
                String className = rs.getString("クラス");
                int nendo = rs.getInt("入学年度");

                students.add(new Student(id, name, className, nendo));
            }

            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            throw new ServletException("DB接続エラー: " + e.getMessage(), e);
        }

        request.setAttribute("studentList", students);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/student_list.jsp");
        dispatcher.forward(request, response);
    }
}
