package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.School;

public class ClassNumDao extends Dao {
	/**
	 * filterメソッド 学校を指定してクラス番号の一覧を取得する
	 *
	 * @param school:School
	 * @return クラス番号の一覧:List<String>
	 * @throws Exception
	 */
	public List<String> filter(School school) throws Exception {
		// リストを初期化
		List<String> list = new ArrayList<>();
		// データベースへのコネクションを確立
		Connection connection = getConnection();
		// プリペアードステートメント
		PreparedStatement statement = null;

		try {
			// プリペアードステートメントにSQL文をセット
			statement = connection
					.prepareStatement("select class_num from class_num where school_cd=? order by class_num");
			// プリペアードステートメントに学校コードをバインド
			statement.setString(1, school.getCd());
			// プリペアードステートメントを実行
			ResultSet rSet = statement.executeQuery();

			// リザルトセットを全件走査
			while (rSet.next()) {
				// リストにクラス番号を追加
				list.add(rSet.getString("class_num"));
			}
		} catch (Exception e) {
			throw e;
		} finally {
			// プリペアードステートメントを閉じる
			if (statement != null) {
				try {
					statement.close();
				} catch (SQLException sqle) {
					throw sqle;
				}
			}
			// コネクションを閉じる
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
	//変更点以下
    public List<bean.ClassNum> filterBySchool(String schoolCd) throws Exception {
        List<bean.ClassNum> classNums = new ArrayList<>();
        Connection con = null;
        PreparedStatement st = null;
        ResultSet rs = null;

        try {
            con = getConnection(); // 親クラス（Dao）のgetConnection()を呼び出すと仮定
            st = con.prepareStatement("SELECT CLASS_NUM FROM CLASS_NUM WHERE SCHOOL_CD = ? ORDER BY CLASS_NUM");
            st.setString(1, schoolCd);
            rs = st.executeQuery();

            while (rs.next()) {
                bean.ClassNum cn = new bean.ClassNum();
                cn.setClassNum(rs.getString("CLASS_NUM"));

                classNums.add(cn);
            }
        } catch (Exception e) {
            System.err.println("Error in ClassNumDao.filterBySchool: " + e.getMessage());
            throw e;
        } finally {
            if (rs != null) { try { rs.close(); } catch (Exception ignore) {} }
            if (st != null) { try { st.close(); } catch (Exception ignore) {} }
            if (con != null) { try { con.close(); } catch (Exception ignore) {} }
        }
        return classNums;
    }
}
