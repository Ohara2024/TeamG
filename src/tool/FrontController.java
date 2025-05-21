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
        actionMap.put("/main/Login.Action", new LoginAction());
        actionMap.put("/main/LoginExecute.Action", new LoginExecuteAction());
        actionMap.put("/main/Logout.Action", new LogoutAction());
        actionMap.put("/main/Menu.Action", new MenuAction());
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

        String path = request.getServletPath();

        Action action = actionMap.get(path);

        if (action == null) {
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
