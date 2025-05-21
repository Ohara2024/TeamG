package scoremanager.main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tool.Action;

public class MenuAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        HttpSession session = req.getSession(false);
        if(session == null || session.getAttribute("user") == null) {
            // ログインしていなければログイン画面へリダイレクト
            // ここも念のため、先頭にスラッシュを追加しておくとより確実です
            res.sendRedirect(req.getContextPath() + "/main/Login.action");
            return;
        }

        // セッションのuser属性はTeacherオブジェクトである想定
        // ★追加ここから★
        System.out.println("MenuAction: /menu.jsp にフォワードします。");
        // ★追加ここまで★
     // MenuAction.java
        req.getRequestDispatcher("/main/menu.jsp").forward(req, res);

    }
}