package scoremanager.main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tool.Action;

public class LogoutAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // セッションを破棄
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // ログアウト完了画面へ遷移
        return "logout.jsp";
    }
}
