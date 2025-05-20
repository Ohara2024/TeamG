package scoremanager.main;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tool.Action;

public class SubjectUpdateExecuteAction extends Action {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            execute(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        String cd = req.getParameter("cdtxt");
        String name = req.getParameter("name");

        // デバッグ出力
        System.out.println("受け取った科目コード：" + cd);
        System.out.println("受け取った科目名：" + name);

        // ▼ 入力チェック（未入力）
        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("error", "科目名を入力してください");
            req.setAttribute("cd", cd);    // 元の入力値を戻す
            req.setAttribute("name", name);
            req.getRequestDispatcher("/SubjectUpdate.jsp").forward(req, res);
            return;
        }

        // ▼ ここにDB更新処理を入れる想定（今は割愛）

        // ▼ 正常終了したら完了画面へ
        req.getRequestDispatcher("/StudentRegistered.jsp").forward(req, res);
    }
}
