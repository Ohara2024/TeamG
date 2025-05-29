package bean;

import java.io.Serializable;

public class ClassNum implements Serializable {
	/**
	 * 学校:School
	 */
	private School school;

	/**
	 * クラス番号:String
	 */
	private String num;

	/**
	 * ゲッター、セッター
	 */
	public School getSchool() {
		return school;
	}

	public void setSchool(School school) {
		this.school = school;
	}

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	// ★追加: クラス番号を保持するフィールド
    private String classNum;

    // ★追加: classNum のゲッター
    public String getClassNum() {
        return classNum;
    }

    // ★追加: classNum のセッター
    public void setClassNum(String classNum) {
        this.classNum = classNum;
    }
}
