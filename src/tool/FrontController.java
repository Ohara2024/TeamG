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
// 必要に応じて他のActionもimportしてください

public class FrontController extends HttpServlet {

    private Map<String, Action> actionMap = new HashMap<>();

    @Override
    public void init() throws ServletException {
        // URLとアクションクラスのマッピングを定義
        actionMap.put("/main/Login.action", new LoginAction());
        actionMap.put("/main/LoginExecute.action", new LoginExecuteAction());
        actionMap.put("/main/Logout.action", new LogoutAction());
        // 例:
        // actionMap.put("/student/StudentList.action", new StudentListAction());
        // actionMap.put("/score/ScoreInsertForm.action", new ScoreInsertFormAction());
        // actionMap.put("/subject/SubjectList.action", new SubjectListAction());
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

        // リクエストパス取得（コンテキストパスを除いたもの）
        String path = request.getServletPath();

        Action action = actionMap.get(path);

        if (action == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        try {
            // アクションの処理を実行し、戻り値（JSP名）を取得
            String forward = action.execute(request, response);
            if (forward != null) {
                request.getRequestDispatcher("/WEB-INF/jsp/" + forward).forward(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
