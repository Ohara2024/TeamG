package tool;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface Action {
    /**
     * リクエストを処理し、フォワード先のJSPパス（相対パス）を返す。
     *
     * @param request  リクエストオブジェクト
     * @param response レスポンスオブジェクト
     * @return フォワード先のJSPファイル名（例: "main/menu.jsp"）
     * @throws Exception 例外が発生した場合
     */
    String execute(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
