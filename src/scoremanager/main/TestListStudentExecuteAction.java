package scoremanager.main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public abstract class TestListStudentExecuteAction{

    public abstract void execute(
    		HttpServletRequest req, HttpServletResponse res
    		) throws Exception;


}