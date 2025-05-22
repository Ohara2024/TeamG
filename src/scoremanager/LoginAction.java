package scoremanager;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tool.Action;

public class LoginAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        // login.jsp にフォワード (正しいパスを指定)
        req.getRequestDispatcher("/main/login.jsp").forward(req, res);
    }
}