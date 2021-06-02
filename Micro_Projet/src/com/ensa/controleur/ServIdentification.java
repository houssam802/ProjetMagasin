package com.ensa.controleur;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ensa.model.HashPBKFD2;
import com.ensa.model.SelectInsert;

public class ServIdentification extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public ServIdentification() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String email = (String) request.getParameter("email");
		String motDePasse = (String) request.getParameter("motpasse");
		RequestDispatcher view = request.getRequestDispatcher("/WEB-INF/Identification.jsp");
		if( email != null) {
			request.setAttribute("email", email);
			request.setAttribute("motDePasse", motDePasse);
			String[] motPasseStock = new String[2];
			motPasseStock = new SelectInsert().verifierClient(email);
			if( motPasseStock[0] == null ) {
				request.setAttribute("errEmail", "Email inconnue");
				view.forward(request, response);
			} else {
				try {
					if(HashPBKFD2.validatePassword(motDePasse , motPasseStock[0])) {
						Cookie newCk = new Cookie("prenom", motPasseStock[1]);
						newCk.setMaxAge(30*60);//20 minutes
						response.addCookie(newCk);
						newCk = new Cookie("email", email);
						newCk.setMaxAge(30*60);//20 minutes
						response.addCookie(newCk);
						response.sendRedirect(request.getContextPath() + "/accueil");
					} else {
						request.setAttribute("errPass", "Mot de passe incorrect");
						view.forward(request, response);
					}
				} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
					e.printStackTrace();
				}
			}
		} else {
			view.forward(request, response);
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
