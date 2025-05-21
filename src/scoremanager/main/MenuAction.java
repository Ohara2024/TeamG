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
            res.sendRedirect(req.getContextPath() + "//Login.action");
            return;
        }

        // セッションのuser属性はTeacherオブジェクトである想定
        req.getRequestDispatcher("/menu.jsp").forward(req, res);
    }
}
