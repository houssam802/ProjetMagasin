package com.ensa.controleur;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class ServAccueil extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public ServAccueil() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Cookie ck[] = request.getCookies();	
		boolean cookieExiste = false;
		if( ck != null ) {
			for(Cookie cookie : ck) {
				if(cookie.getName().matches("prenom")) {
					request.setAttribute("prenom", cookie.getValue().toUpperCase());
					cookieExiste = true;
				}
			}
		}
		if(cookieExiste) {
			RequestDispatcher view = request.getRequestDispatcher("/WEB-INF/AccueilConn.jsp");
			view.forward(request, response);
		} else {
			RequestDispatcher view = request.getRequestDispatcher("/WEB-INF/AccueilNonC.jsp");
			view.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
