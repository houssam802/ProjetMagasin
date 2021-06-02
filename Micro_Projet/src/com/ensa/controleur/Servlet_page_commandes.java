package com.ensa.controleur;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ensa.model.Article;
import com.ensa.model.SelectInsert;


public class Servlet_page_commandes extends HttpServlet {
	private static final long serialVersionUID = 1L;

	ArrayList<Article> articles_cmds;
	
    public Servlet_page_commandes() {
        super();
        // TODO Auto-generated constructor stub
    }
    
	@SuppressWarnings("deprecation")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		articles_cmds=new ArrayList<Article>();
	    HttpSession session = request.getSession();
	    if( session.getValueNames().length != 1) {
		    for(int i=0;i<session.getValueNames().length-1;i++) {
		    	int code=Integer.parseInt(session.getAttribute(Integer.toString(i)).toString());
		    	articles_cmds.add(new SelectInsert().select_articles_byId(code));
		    }
		    request.setAttribute("articles", articles_cmds);
		    RequestDispatcher view = request.getRequestDispatcher("/WEB-INF/Page_commandes.jsp");
			view.forward(request, response);
	    } else {
		    response.sendRedirect("articles");
	    }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
