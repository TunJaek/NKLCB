package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.ActionBean;
import services.auth.Auth;
import services.registration.Registration;

@WebServlet({"/JoinAccess","/Access","/AccessOut"})
//잡코드 안에 슬래시 필수!, @WebServlet은 하나의 데이터 개체만 받을 수 있음(여러개를 넣을 땐 배열화 시켜서 넣어줌)
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
    public FrontController() {
        super();
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    	req.setCharacterEncoding("UTF-8");
    	String jobCode = req.getRequestURI().substring(req.getContextPath().length()+1);
    	ActionBean action = null;
    	if (jobCode.equals("JoinAccess")) action = new Registration(req).backController(1);
    	if (jobCode.equals("GosuAccess")) action = new Registration(req).backController(2);
    	if (jobCode.equals("Access")) action = new Auth(req).backController(0);
    	if (jobCode.equals("AccessOut")) action = new Auth(req).backController(-1);
    	if(action.isRedirect()) {
    		res.sendRedirect(action.getPage());
    	}else {
    		RequestDispatcher dispatcher = req.getRequestDispatcher(action.getPage());
    		dispatcher.forward(req, res);
    	}

    }
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String jobCode = req.getRequestURI().substring(req.getContextPath().length()+1);
		ActionBean action = null;
		Registration reg = null;

		if(action.isRedirect()) {
    		res.sendRedirect(action.getPage());
    	}else {
    		RequestDispatcher dispatcher = req.getRequestDispatcher(action.getPage());
    		dispatcher.forward(req, res);
    	}
		
	}

}
