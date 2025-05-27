package bean;

import java.io.Serializable;

public class Test implements Serializable {
	/**
	 * 学生:Student
	 */
	private Student student;

	/**
	 * クラス番号:String
	 */
	private String classNum;

	/**
	 * 科目:Subject
	 */
	private Subject subject;

	/**
	 * 学校:School
	 */
	private School school;

	/**
	 * 回数:int
	 */
	private int no;

	/**
	 * 得点:int
	 */
	private int point;

	/**
	 * ゲッター、セッター
	 */
	public Student getStudent() {
		return student;
	}

	public void setStudent(Student student) {
		this.student = student;
	}

	public String getClassNum() {
		return classNum;
	}

	public void setClassNum(String classNum) {
		this.classNum = classNum;
	}

	public Subject getSubject() {
		return subject;
	}

	public void setSubject(Subject subject) {
		this.subject = subject;
	}

	public School getSchool() {
		return school;
	}

	public void setSchool(School school) {
		this.school = school;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	//追加部分

    // ★追加: 学生番号を保持するフィールド
    private String studentNo;

    // ★追加: 科目コードを保持するフィールド
    private String subjectCd;

    // ★追加: 学生番号のゲッター
    public String getStudentNo() {
        return studentNo;
    }

    // ★追加: 学生番号のセッター
    public void setStudentNo(String studentNo) {
        this.studentNo = studentNo;
    }

    // ★追加: 科目コードのゲッター
    public String getSubjectCd() {
        return subjectCd;
    }

    // ★追加: 科目コードのセッター
    public void setSubjectCd(String subjectCd) {
        this.subjectCd = subjectCd;
    }


}
