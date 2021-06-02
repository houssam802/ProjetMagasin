package com.ensa.controleur;

import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.ensa.model.Client;
import com.ensa.model.Erreur;
import com.ensa.model.HashPBKFD2;
import com.ensa.model.SelectInsert;


public class ServInscription extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public ServInscription() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Client client = new Client();
		boolean vc = true;
		RequestDispatcher view = request.getRequestDispatcher("/WEB-INF/Inscription.jsp");
		if(request.getParameter("nom") == null) {
			view.forward(request, response);
		}
		if(request.getParameter("nom") != null) {
			set_valeurs(client,request);
			request.setAttribute("client", client);
			//view.forward(request, response);
		}
		if(client.getPrenom() != null && vc) {
			Cookie newCk = new Cookie("prenom", client.getPrenom());
			newCk.setMaxAge(30*60);//20 minutes
			response.addCookie(newCk);
			newCk = new Cookie("email", client.getEmail());
			newCk.setMaxAge(30*60);//20 minutes
			response.addCookie(newCk);
			try {
				Erreur err = new Erreur();
				String motPasseAncien = client.getMotpasse();
				client.setMotpasse(HashPBKFD2.generateStrongPasswordHash(client.getMotpasse()));
				if( new SelectInsert().InsertClient(client, err) != 0 ) {
					response.sendRedirect(request.getContextPath() + "/accueil");
				} else {
					client.setMotpasse(motPasseAncien);
					request.setAttribute("EmailErr", err.getEmailErrUnique());
					view.forward(request, response);
				}
			} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
				e.printStackTrace();
			}
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	void set_valeurs(Client client,HttpServletRequest request) {
		for(Field field : client.getClass().getDeclaredFields()) {
			for(Method methode : client.getClass().getMethods()) {
        		if(methode.getName().matches("set.+")) {
        			if(methode.getName().toLowerCase().matches("set"+field.getName().toLowerCase())) {
        					try {
        					 if(!((String) request.getParameter(field.getName())).matches(" ")){
								methode.invoke(client,(String) request.getParameter(field.getName()));
        					 }
							} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
        				}
        			}
        		}
		}
	}

}
