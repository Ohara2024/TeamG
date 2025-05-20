package scoremanager.main;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tool.Action;

public class SubjectUpdateAction extends Action {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            execute(request, response); // ← これでOK
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        // ここに実際の処理を書く
        System.out.println("executeメソッドが呼び出されました");
        // 例：リクエストから値取得 → DB更新 → JSPへフォワード など
    }
}
