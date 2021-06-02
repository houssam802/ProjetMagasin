package com.ensa.controleur;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class FilterP implements Filter {

    public FilterP() {
        // TODO Auto-generated constructor stub
    }

	public void destroy() {
		// TODO Auto-generated method stub
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		String prenom = null;
		HttpServletRequest hrequest = (HttpServletRequest) request;
		HttpServletResponse hresponse = (HttpServletResponse) response;
		Cookie[] cookies = hrequest.getCookies();
		prenom = cherchePrenom(cookies);
		if( prenom == "inconnu" ) {
			// cas ou il n'existe pas appel de la servlet inscrire
			hresponse.sendRedirect("accueil");
		} else {
			chain.doFilter(request, response); 
		}
	}

	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}
	
	String cherchePrenom (Cookie [] cookies) {
		if( cookies != null ) {
			for(Cookie cookie : cookies) {
				if(cookie.getName().matches("prenom")) {
					return cookie.getValue().toUpperCase();
				}
			}
		}
		return "inconnu";
	}

}
