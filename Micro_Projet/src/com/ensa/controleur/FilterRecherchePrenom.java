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


public class FilterRecherchePrenom implements Filter {

    public FilterRecherchePrenom() {
        // TODO Auto-generated constructor stub
    }

	public void destroy() {
		// TODO Auto-generated method stub
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		String prenom = null;
		HttpServletRequest hrequest = (HttpServletRequest) request;
		Cookie[] cookies = hrequest.getCookies();
		prenom = cherchePrenom(cookies);
	    request.setAttribute("prenom",prenom);
	    chain.doFilter(request, response);
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
