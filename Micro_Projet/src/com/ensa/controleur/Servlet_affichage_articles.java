package com.ensa.controleur;

import java.io.BufferedReader;

import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Locale;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.json.simple.JSONObject;
import org.json.simple.parser.*;

import com.ensa.model.Article;
import com.ensa.model.SelectInsert;

public class Servlet_affichage_articles extends HttpServlet {
	SelectInsert select;
	ArrayList<Article> articles;
	Locale locale;
	

	private static final long serialVersionUID = 1L;
       

    public Servlet_affichage_articles() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		articles=new ArrayList<Article>();
        select=new SelectInsert();
		
		setlocale(request);
		
		request.setAttribute("local",locale);
		request.setAttribute("rate",get_rate(request));
		
		if(((String) request.getParameter("categorie"))!=null) {
			if(!((String) request.getParameter("categorie")).contains("Tous")) {
				articles=select.select_articles((String) request.getParameter("categorie"));
			}else articles=select.selectAll_article();
		}else articles=select.selectAll_article();
		
		request.setAttribute("articles", articles);
		request.setAttribute("categorie",(String) request.getParameter("categorie"));
	    
		
		RequestDispatcher view = request.getRequestDispatcher("/Affichage_articles.jsp");
		view.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	
	void setlocale(HttpServletRequest request) throws MalformedURLException {
		 if(((String)request.getParameter("country"))!=null) {  
			   if(((String)request.getParameter("country")).contains("EUR")) {
				   locale = new Locale("FRENCH","FR");	
			   }
			   if(((String)request.getParameter("country")).contains("USD")) {
				   locale = new Locale("ENGLISH","US");
			   }
			   if(((String)request.getParameter("country")).contains("MAD")) {
				   locale = new Locale("FRENCH","MA");
			   }
			 }else locale = new Locale("FRENCH","MA");
	}
	
	
	float get_rate(HttpServletRequest request) throws MalformedURLException {
		  JSONParser parser = new JSONParser();
	      Object obj;
	      float rate=1;
	      if((String) request.getParameter("country")!=null) {
	    	  if(!((String)request.getParameter("country")).contains("MAD")) {
		      URL url = new URL("http://www.floatrates.com/daily/mad.json");
				try {
					obj = parser.parse(new BufferedReader(new InputStreamReader(url.openStream())));
					JSONObject jsonObject = (JSONObject)obj;
					rate=(float) ((double) ((JSONObject) jsonObject.get(((String) request.getParameter("country").toLowerCase()))).get("rate"));
				} catch (IOException | ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	    	  }
	      }
		return rate;
		
	}
	

}
