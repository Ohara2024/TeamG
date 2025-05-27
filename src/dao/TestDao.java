package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.School;
import bean.Student;
import bean.Subject;
import bean.Test;


public class TestDao extends Dao {
	/**
	 * getメソッド 学生、科目、学校、回数を指定して成績インスタンスを1権取得する
	 *
	 * @param student:Student
	 *            学生
	 * @param subject:Subject
	 *            科目
	 * @param school:School
	 *            学校
	 * @param no:int
	 *            回数
	 * @return
	 * @throws Exception
	 */
	public Test get(Student student, Subject subject, School school, int no) throws Exception {
		// 成績インスタンスを初期化
		Test test = new Test();

		Connection connection = getConnection();
		PreparedStatement statement = null;

		try {
			statement = connection.prepareStatement(
					"select * from test where student_no=? and subject_cd=? and school_cd=? and no=?");
			statement.setString(1, student.getNo());
			statement.setString(2, subject.getCd());
			statement.setString(3, school.getCd());
			statement.setInt(4, no);
			ResultSet rSet = statement.executeQuery();

			if (rSet.next()) {
				test.setStudent(student);
				test.setSubject(subject);
				test.setSchool(school);
				test.setNo(no);
				test.setPoint(rSet.getInt("point"));
			} else {
				test = null;
			}
		} catch (Exception e) {
			throw e;
		} finally {
			if (statement != null) {
				try {
					statement.close();
				} catch (SQLException sqle) {
					throw sqle;
				}
			}
			if (connection != null) {
				try {
					connection.close();
				} catch (SQLException sqle) {
					throw sqle;
				}
			}
		}

		return test;
	}

	/**
	 * baseSql:String 共通SQL文 プライベート
	 */
	private String baseSql = "SELECT SJ.cd as sj_cd, SJ.name as sj_name, ST.no as st_no, ST.name as st_name, "
			+ "ST.ent_year as st_ent_year, ST.class_num as st_class_num, ST.is_attend as st_is_attend, "
			+ "T.no as t_no, coalesce(T.point, -1) as t_point "
			+ "FROM student ST left outer join (test T inner join subject SJ on T.subject_cd=SJ.cd) "
			+ "on ST.no=T.student_no ";

	/**
	 * postFilterメソッド フィルター後のリストへの格納処理 プライベート
	 *
	 * @param rSet:リザルトセット
	 * @param school:School
	 *            学校
	 * @return 成績のリスト:List<Student> 存在しない場合は0件のリスト
	 * @throws Exception
	 */
	private List<Test> postFilter(ResultSet rSet, School school) throws Exception {
		// リストを初期化
		List<Test> list = new ArrayList<>();
		// リザルトセットを全件走査
		while (rSet.next()) {
			// 科目インスタンス
			Subject subject = new Subject();
			subject.setCd(rSet.getString("sj_cd"));
			subject.setName(rSet.getString("sj_name"));
			subject.setSchool(school);

			// 学生インスタンス
			Student student = new Student();
			student.setNo(rSet.getString("st_no"));
			student.setName(rSet.getString("st_name"));
			student.setEntYear(rSet.getInt("st_ent_year"));
			student.setClassNum(rSet.getString("st_class_num"));
			student.setAttend(rSet.getBoolean("st_is_attend"));
			student.setSchool(school);

			// 成績インスタンス
			Test test = new Test();
			test.setStudent(student);
			test.setClassNum(rSet.getString("st_class_num"));
			test.setSubject(subject);
			test.setSchool(school);
			test.setNo(rSet.getInt("t_no"));
			test.setPoint(rSet.getInt("t_point"));

			// リストに追加
			list.add(test);
		}

		return list;
	}

	/**
	 * filterメソッド 入学年度、クラス番号、科目、回数、学校を指定して成績の一覧を取得する
	 *
	 * @param entYear:int
	 *            入学年度
	 * @param classNum:String
	 *            クラス番号
	 * @param subject:Subject
	 *            科目
	 * @param num:int
	 *            回数
	 * @param school：School
	 *            学校
	 * @return 成績のリスト:List<Test> 存在しない場合は0件のリスト
	 * @throws Exception
	 */
	public List<Test> filter(int entYear, String classNum, Subject subject, int num, School school) throws Exception {
		// リストを初期化
		List<Test> list = new ArrayList<>();

		Connection connection = getConnection();
		PreparedStatement statement = null;
		ResultSet rSet = null;

		// SQL文の条件
		String condition = "and T.subject_cd=? and T.no=? "
				+ "where ST.ent_year=? and ST.class_num=? and ST.school_cd=? and ST.is_attend=true";
		// SQL文のソート
		String order = " order by ST.no asc";

		try {
			statement = connection.prepareStatement(baseSql + condition + order);
			statement.setString(1, subject.getCd());
			statement.setInt(2, num);
			statement.setInt(3, entYear);
			statement.setString(4, classNum);
			statement.setString(5, school.getCd());
			rSet = statement.executeQuery();

			list = postFilter(rSet, school);
		} catch (Exception e) {
			throw e;
		} finally {
			if (statement != null) {
				try {
					statement.close();
				} catch (SQLException sqle) {
					throw sqle;
				}
			}
			if (connection != null) {
				try {
					connection.close();
				} catch (SQLException sqle) {
					throw sqle;
				}
			}
		}

		return list;
	}

	/**
	 * saveメソッド 成績のリストをデータベースに保存する データが存在する場合は更新、存在しない場合は登録
	 * 全て正常終了した場合にのみコミットし、それ以外はロールバックする
	 *
	 * @param list:List<Test>
	 *            成績のリスト
	 * @return 成功:true, 失敗:false
	 * @throws Exception
	 */
	public boolean save(List<Test> list) throws Exception {
		Connection connection = getConnection();
		// コミット許可フラグ
		boolean canCommit = true;

		try {
			// 自動コミットをオフ
			connection.setAutoCommit(false);
			// リストを全件走査
			for (Test test : list) {
				// 1件ずつ保存
				canCommit = save(test, connection);
				// 失敗の場合
				if (!canCommit) {
					// ループを抜ける
					break;
				}
			}

			if (canCommit) {
				// 全て正常終了の場合
				// コミット
				connection.commit();
			} else {
				throw new Exception();
			}
		} catch (SQLException sqle) {
			// エラーが発生した場合
			try {
				// ロールバック
				connection.rollback();
			} catch (SQLException e) {
				throw e;
			}

		} finally {
			if (connection != null) {
				try {
					connection.setAutoCommit(true);
					connection.close();
				} catch (SQLException sqle) {
					throw sqle;
				}
			}
		}
		return canCommit;
	}

	/**
	 * saveメソッド プライベート 成績インスタンスをデータベースに保存する データが存在する場合は更新、存在しない場合は登録
	 *
	 * @param test:Test
	 *            成績
	 * @return 成功:true, 失敗:false
	 * @throws Exception
	 */
	private boolean save(Test test, Connection connection) throws Exception {
		// プリペアードステートメント
		PreparedStatement statement = null;
		// 実行件数
		int count = 0;

		try {
			// データベースから成績を取得
			Test old = get(test.getStudent(), test.getSubject(), test.getSchool(), test.getNo());
			if (old == null) {
				// 成績が存在しなかった場合
				// プリペアードステートメントにINSERT文をセット
				statement = connection.prepareStatement(
						"insert into test(point, no, student_no, subject_cd, school_cd, class_num) values(?, ?, ?, ?, ?, ?)");
				statement.setInt(1, test.getPoint());
				statement.setInt(2, test.getNo());
				statement.setString(3, test.getStudent().getNo());
				statement.setString(4, test.getSubject().getCd());
				statement.setString(5, test.getSchool().getCd());
				statement.setString(6, test.getStudent().getClassNum());
			} else {
				// 成績が存在する場合
				// プリペアードステートメントにUPDATE文をセット
				statement = connection.prepareStatement(
						"update test set point=? where no=? and student_no=? and subject_cd=? and school_cd=?");
				statement.setInt(1, test.getPoint());
				statement.setInt(2, test.getNo());
				statement.setString(3, test.getStudent().getNo());
				statement.setString(4, test.getSubject().getCd());
				statement.setString(5, test.getSchool().getCd());
			}
			// プリペアードステートメントを実行
			count = statement.executeUpdate();

		} catch (Exception e) {
			throw e;
		} finally {
			if (statement != null) {
				try {
					statement.close();
				} catch (SQLException sqle) {
					throw sqle;
				}
			}
		}

		if (count > 0) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * deleteメソッド プライベート 成績のリストをデータベースから削除する 全て正常終了した場合にのみコミットし、それ以外はロールバックする
	 *
	 * @param list:List<Test>
	 *            成績のリスト
	 * @return 成功:true, 失敗:false
	 * @throws Exception
	 */
	public boolean delete(List<Test> list) throws Exception {
		Connection connection = getConnection();
		// コミット許可フラグ
		boolean canCommit = true;

		try {
			// 自動コミットをオフ
			connection.setAutoCommit(false);
			// リストを全件走査
			for (Test test : list) {
				// 1件ずつ削除
				canCommit = delete(test, connection);
				// 失敗の場合
				if (!canCommit) {
					// ループを抜ける
					break;
				}
			}

			// 全て正常終了の場合
			if (canCommit) {
				// コミット
				connection.commit();
			} else {
				throw new Exception();
			}
		} catch (SQLException sqle) {
			// エラーの場合
			try {
				// ロールバック
				connection.rollback();
			} catch (SQLException e) {
				throw e;
			}

		} finally {
			if (connection != null) {
				try {
					connection.setAutoCommit(true);
					connection.close();
				} catch (SQLException sqle) {
					throw sqle;
				}
			}
		}
		return canCommit;
	}

	/**
	 * deleteメソッド プライベート 成績インスタンスをデータベースから削除する
	 *
	 * @param test:Test
	 *            成績
	 * @return 成功:true, 失敗:false
	 * @throws Exception
	 */
	private boolean delete(Test test, Connection connection) throws Exception {
		PreparedStatement statement = null;
		int count = 0;

		try {
			statement = connection
					.prepareStatement("delete from test where no=? and student_no=? and subject_cd=? and school_cd=?");
			statement.setInt(1, test.getNo());
			statement.setString(2, test.getStudent().getNo());
			statement.setString(3, test.getSubject().getCd());
			statement.setString(4, test.getSchool().getCd());

			count = statement.executeUpdate();

		} catch (Exception e) {
			throw e;
		} finally {
			if (statement != null) {
				try {
					statement.close();
				} catch (SQLException sqle) {
					throw sqle;
				}
			}
		}

		if (count > 0) {
			return true;
		} else {
			return false;
		}
	}

	//追加したもの





	/**
     * 入学年度、クラス番号、科目コード、学校コードでテスト結果をフィルタリングして取得します。
     * @param entYear 入学年度 (nullで全年度)
     * @param classNum クラス番号 (nullまたは空文字で全クラス)
     * @param subjectCd 科目コード (nullまたは空文字で全科目)
     * @param schoolCd 学校コード
     * @return テスト結果のリスト
     * @throws Exception データベースアクセスエラー
     */
    public List<bean.Test> filter(Integer entYear, String classNum, String subjectCd, String schoolCd) throws Exception {
        List<bean.Test> tests = new ArrayList<>();
        Connection con = null;
        PreparedStatement st = null;
        ResultSet rs = null;

        try {
            con = getConnection(); // 親クラス（Dao）のgetConnection()を呼び出すと仮定
            StringBuilder sql = new StringBuilder(
                "SELECT T.STUD_NO, T.SUB_CD, T.NO, T.POINT, S.NAME AS STUDENT_NAME, SUB.NAME AS SUBJECT_NAME " +
                "FROM TEST AS T " +
                "JOIN STUDENT AS S ON T.STUD_NO = S.NO AND T.SCHOOL_CD = S.SCHOOL_CD " +
                "JOIN SUBJECT AS SUB ON T.SUB_CD = SUB.CD AND T.SCHOOL_CD = SUB.SCHOOL_CD " +
                "WHERE T.SCHOOL_CD = ?"
            );
            List<Object> paramList = new ArrayList<>();
            paramList.add(schoolCd);

            if (entYear != null) {
                sql.append(" AND S.ENT_YEAR = ?");
                paramList.add(entYear);
            }
            if (classNum != null && !classNum.isEmpty()) {
                sql.append(" AND S.CLASS_NUM = ?");
                paramList.add(classNum);
            }
            if (subjectCd != null && !subjectCd.isEmpty()) {
                sql.append(" AND T.SUB_CD = ?");
                paramList.add(subjectCd);
            }

            sql.append(" ORDER BY S.NO, T.SUB_CD, T.NO"); // 学生番号、科目コード、回数でソート

            st = con.prepareStatement(sql.toString());
            for (int i = 0; i < paramList.size(); i++) {
                Object param = paramList.get(i);
                if (param instanceof String) {
                    st.setString(i + 1, (String) param);
                } else if (param instanceof Integer) {
                    st.setInt(i + 1, (Integer) param);
                }
            }
            rs = st.executeQuery();

            while (rs.next()) {
                bean.Test test = new bean.Test();
                test.setStudentNo(rs.getString("STUD_NO"));
                test.setSubjectCd(rs.getString("SUB_CD"));
                test.setNo(rs.getInt("NO"));
                test.setPoint(rs.getInt("POINT"));
                // test.setSchoolCd(schoolCd); // もしTest BeanにsetSchoolCdがあれば有効にする
                // bean.Student student = new bean.Student(); // Student Beanが適切に定義されていると仮定
                // student.setNo(rs.getString("STUD_NO"));
                // student.setName(rs.getString("STUDENT_NAME"));
                // test.setStudent(student); // もしTest BeanにsetStudentメソッドがあれば有効にする

                // bean.Subject subject = new bean.Subject(); // Subject Beanが適切に定義されていると仮定
                // subject.setCd(rs.getString("SUB_CD"));
                // subject.setName(rs.getString("SUBJECT_NAME"));
                // test.setSubject(subject); // もしTest BeanにsetSubjectメソッドがあれば有効にする

                tests.add(test);
            }
        } catch (Exception e) {
            System.err.println("Error in TestDao.filter: " + e.getMessage());
            throw e;
        } finally {
            if (rs != null) { try { rs.close(); } catch (Exception ignore) {} }
            if (st != null) { try { st.close(); } catch (Exception ignore) {} }
            if (con != null) { try { con.close(); } catch (Exception ignore) {} }
        }
        return tests;
    }

    /**
     * 学生番号と学校コードでテスト結果をフィルタリングして取得します。
     * @param studentNo 学生番号
     * @param schoolCd 学校コード
     * @return テスト結果のリスト
     * @throws Exception データベースアクセスエラー
     */
    public List<bean.Test> filterByStudent(String studentNo, String schoolCd) throws Exception {
        List<bean.Test> tests = new ArrayList<>();
        Connection con = null;
        PreparedStatement st = null;
        ResultSet rs = null;

        try {
            con = getConnection(); // 親クラス（Dao）のgetConnection()を呼び出すと仮定
            String sql = "SELECT T.STUD_NO, T.SUB_CD, T.NO, T.POINT, S.NAME AS STUDENT_NAME, SUB.NAME AS SUBJECT_NAME " +
                         "FROM TEST AS T " +
                         "JOIN STUDENT AS S ON T.STUD_NO = S.NO AND T.SCHOOL_CD = S.SCHOOL_CD " +
                         "JOIN SUBJECT AS SUB ON T.SUB_CD = SUB.CD AND T.SCHOOL_CD = SUB.SCHOOL_CD " +
                         "WHERE T.STUD_NO = ? AND T.SCHOOL_CD = ? " +
                         "ORDER BY T.SUB_CD, T.NO"; // 科目コード、回数でソート

            st = con.prepareStatement(sql);
            st.setString(1, studentNo);
            st.setString(2, schoolCd);
            rs = st.executeQuery();

            while (rs.next()) {
                bean.Test test = new bean.Test();
                test.setStudentNo(rs.getString("STUD_NO"));
                test.setSubjectCd(rs.getString("SUB_CD"));
                test.setNo(rs.getInt("NO"));
                test.setPoint(rs.getInt("POINT"));
                // test.setSchoolCd(schoolCd); // もしTest BeanにsetSchoolCdがあれば有効にする
                // bean.Student student = new bean.Student(); // Student Beanが適切に定義されていると仮定
                // student.setNo(rs.getString("STUD_NO"));
                // student.setName(rs.getString("STUDENT_NAME"));
                // test.setStudent(student); // もしTest BeanにsetStudentメソッドがあれば有効にする

                // bean.Subject subject = new bean.Subject(); // Subject Beanが適切に定義されていると仮定
                // subject.setCd(rs.getString("SUB_CD"));
                // subject.setName(rs.getString("SUBJECT_NAME"));
                // test.setSubject(subject); // もしTest BeanにsetSubjectメソッドがあれば有効にする

                tests.add(test);
            }
        } catch (Exception e) {
            System.err.println("Error in TestDao.filterByStudent: " + e.getMessage());
            throw e;
        } finally {
            if (rs != null) { try { rs.close(); } catch (Exception ignore) {} }
            if (st != null) { try { st.close(); } catch (Exception ignore) {} }
            if (con != null) { try { con.close(); } catch (Exception ignore) {} }
        }
        return tests;
    }
}
