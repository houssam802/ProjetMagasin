package com.ensa.controleur;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ensa.model.SelectInsert;


public class Servlet_passer_cmd extends HttpServlet {
	private static final long serialVersionUID = 1L;
	SelectInsert insert;

    public Servlet_passer_cmd() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		insert=new SelectInsert();
		String json = (String) request.getParameter("data");
		String numberOnly= (json.split(":")[1]).replaceAll("[^0-9,]", "");
		String[] codes = numberOnly.split(",");
		Cookie ck[] = request.getCookies();
		if( ck != null ) {
			for(Cookie cookie : ck) {
				if(cookie.getName().matches("email")) {
					insert.créer_commande(cookie.getValue());
				}
			}
		}
		for( int i = 0; i <codes.length; i++ ) {
			insert.ajouter_article_commande(Integer.parseInt(codes[i]));
		}
		HttpSession session = request.getSession(false);
		if (session != null) {
		    session.invalidate();
		}
		this.getServletContext().getRequestDispatcher("/WEB-INF/commander.jsp").forward(request, response);;
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
