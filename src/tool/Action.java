package tool;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public abstract class Action {
    // サブクラスで実装するメイン処理
    public abstract void execute(HttpServletRequest req, HttpServletResponse res) throws Exception;
}
