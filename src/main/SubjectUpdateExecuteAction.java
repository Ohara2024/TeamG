package main;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tool.Action;

public class SubjectUpdateExecuteAction extends Action{


    protected void doGet(HttpServletRequest request, HttpServletResponse response)
             throws ServletException, IOException {

    	    public void execute(HttpServletRequest request, HttpServletResponse response)
    	            throws ServletException, IOException; {
    	        // ここで学生の登録処理を書く
    	        String name = request.getParameter("name");
    	        // 登録処理...
    	        request.getRequestDispatcher("/StudentRegistered.jsp").forward(request, response);
    	    }
    	}

    }
