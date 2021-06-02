package com.ensa.controleur;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Servlet_nbr_cmd")
public class Servlet_nbr_cmd extends HttpServlet {
	private static final long serialVersionUID = 1L;

	int nbr_cmd=0;
	
    public Servlet_nbr_cmd() {
        super();
        // TODO Auto-generated constructor stub
    }

	@SuppressWarnings("deprecation")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session=request.getSession();
	    if(session!=null) {
	    	nbr_cmd=session.getValueNames().length-1;
	    }
	    if((String) request.getParameter("CodeArticle")!=null) {
	    	session.setAttribute(Integer.toString(nbr_cmd++),request.getParameter("CodeArticle"));
	    }
	    PrintWriter out = response.getWriter();
		out.print(nbr_cmd);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
