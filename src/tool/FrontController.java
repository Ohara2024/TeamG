package tool;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import scoremanager.LoginAction;
import scoremanager.LoginExecuteAction;
import scoremanager.main.LogoutAction;
import scoremanager.main.MenuAction;

public class FrontController extends HttpServlet {

    private Map<String, Action> actionMap = new HashMap<>();

    @Override
    public void init() throws ServletException {
        // マッピングのキーをすべて小文字の .action に変更します
        actionMap.put("/main/Login.action", new LoginAction());
        actionMap.put("/main/LoginExecute.action", new LoginExecuteAction());
        actionMap.put("/main/Logout.action", new LogoutAction());
        actionMap.put("/main/Menu.action", new MenuAction()); // ★ここを修正します★
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        process(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        process(request, response);
    }

    private void process(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath(); // 例: /main/Menu.action (小文字)

        Action action = actionMap.get(path); // ここでマップからアクションを取得

        if (action == null) {
            // アクションが見つからなかった場合、404エラーを返す
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        try {
            action.execute(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}