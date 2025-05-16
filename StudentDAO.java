package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import tool.Student;

public class StudentDAO {
    private static DataSource ds;

    // DB接続を取得する共通メソッド
    private Connection getConnection() throws Exception {
        if (ds == null) {
            InitialContext ic = new InitialContext();
            ds = (DataSource) ic.lookup("java:/comp/env/jdbc/kouka2");
        }
        return ds.getConnection();
    }

    // 学生一覧取得
    public List<Student> getAllStudents() {
        List<Student> studentList = new ArrayList<>();
        String sql = "SELECT * FROM student";

        try (Connection con = getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Student student = new Student();
                student.setId(rs.getInt("student_id"));
                student.setName(rs.getString("student_name"));
                student.setCourse(rs.getString("course_name"));
                studentList.add(student);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return studentList;
    }

    // 学生追加
    public boolean addStudent(Student student) {
        String sql = "INSERT INTO student (student_id, student_name, course_name) VALUES (?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, student.getId());
            pstmt.setString(2, student.getName());
            pstmt.setString(3, student.getCourse());
            int rowsAffected = pstmt.executeUpdate();

            return rowsAffected > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // 学生削除
    public boolean deleteStudent(int studentId) {
        String sql = "DELETE FROM student WHERE student_id = ?"; // ← 修正ポイント！

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, studentId);
            int rowsAffected = stmt.executeUpdate();

            System.out.println("削除件数: " + rowsAffected); // デバッグ用ログ

            return rowsAffected > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }



    // IDから1人の学生を取得（更新時に使用）
    public Student findById(int id) {
        Student student = null;
        String sql = "SELECT * FROM student WHERE student_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                student = new Student();
                student.setId(rs.getInt("student_id"));
                student.setName(rs.getString("student_name"));
                student.setCourse(rs.getString("course_name"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return student;
    }

    // 学生情報の更新
    public boolean updateStudent(Student student) {
        String sql = "UPDATE student SET student_name = ?, course_name = ? WHERE student_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, student.getName());
            pstmt.setString(2, student.getCourse());
            pstmt.setInt(3, student.getId());

            int rows = pstmt.executeUpdate();
            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
