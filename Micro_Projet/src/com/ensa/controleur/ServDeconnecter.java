package com.ensa.controleur;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ServDeconnecter extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ServDeconnecter() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Cookie ck[] = request.getCookies();
		if( ck != null ) {
			for(Cookie cookie : ck) {
				if(cookie.getName().matches("prenom") || cookie.getName().matches("email")) {
					Cookie cook = new Cookie(cookie.getName(), "");
			        cook.setMaxAge(0);
			        response.addCookie(cook);
				}
			}
		}
		response.sendRedirect(request.getContextPath() + "/accueil");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
