package tool;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public abstract class FrontController{

    protected abstract void doGet(
    		HttpServletRequest req, HttpServletResponse res
    		) throws Exception;

    protected abstract void doPost(
    		HttpServletRequest req, HttpServletResponse res
    		) throws Exception;


}