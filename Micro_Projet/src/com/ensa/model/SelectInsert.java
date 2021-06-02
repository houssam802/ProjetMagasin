package com.ensa.model;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class SelectInsert {
	public int InsertClient(Client client, Erreur err){
		ConnectionDB cx=null;
		try {
			cx = new ConnectionDB();
			String sql = "insert into clients (" + client.getAttrETValue()[0] + ") values("+ client.getAttrETValue()[1] +");";
			return cx.getSt().executeUpdate(sql);
		} catch (SQLException ex) {
			err.setEmailErrUnique("Email déjà existe !");
			return 0;
		}
		finally {
			if(cx!=null)
			cx.close();
		}
	}

	public String[] verifierClient( String email ) {
		String existe[] = new String[2];
		ConnectionDB cx = null;
		try {
			cx = new ConnectionDB();
			String sql = "select * from clients where Email=\"" + email + "\";";
			ResultSet rs = cx.getSt().executeQuery(sql);
			while( rs.next() ) {
				existe[0] = rs.getString("MotPasse");
				existe[1] = rs.getString("Prenom");
			}
			return existe;
		} catch (SQLException ex) {
			ex.printStackTrace();
			return existe;
		}
		finally {
			if(cx!=null)
			cx.close();
		}
	}
		
	public ArrayList<Article> selectAll_article(){
		ArrayList<Article> tmp_list=new ArrayList<Article>();
		String sql = "SELECT * FROM articles";  
		ConnectionDB cx = null;
		ResultSet rs;
		 try {
			cx =new ConnectionDB();
			rs = cx.getSt().executeQuery(sql);
		    while (rs.next()) { 
		    	Article tmp=new Article();
				for(Field field : tmp.getClass().getDeclaredFields()) {
					for(Method methode:tmp.getClass().getMethods()) {
						if(methode.getName().matches("set.+")) {
							if(methode.getName().toLowerCase().matches("set"+field.getName().toLowerCase())) {
								  try {
									 if(field.getName().matches("CodeArticle|Categorie")) {
										methode.invoke(tmp,rs.getInt(field.getName()));
									  }else {
										  if(field.getName().matches("prix")) {
											  methode.invoke(tmp,rs.getFloat(field.getName()));
										  }else {
											  methode.invoke(tmp,rs.getString(field.getName()));
										  }
									  }
									}catch (IllegalAccessException | IllegalArgumentException |InvocationTargetException e ) {
										e.printStackTrace();
									}
								  
							}
						}
					}
				}
				tmp_list.add(tmp);
		    }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		 return tmp_list;
	}
	
    public ArrayList<Article> select_articles(String categorie){
		ArrayList<Article> tmp_list=new ArrayList<Article>();
		String sql= "SELECT * FROM categories where Cat ='"+categorie+"';"; 
		int ref_cat=-1;
		ConnectionDB cx = null;
		ResultSet rs;
		 try {
			cx =new ConnectionDB();
			rs = cx.getSt().executeQuery(sql);
			 while (rs.next()) {
				 ref_cat=rs.getInt("RefCat");
			 }
			String sql1 = "SELECT * FROM articles where Categorie="+ref_cat+";";  
			rs =  cx.getSt().executeQuery(sql1);
		    while (rs.next()) { 
		    	Article tmp=new Article();
				for(Field field : tmp.getClass().getDeclaredFields()) {
					for(Method methode:tmp.getClass().getMethods()) {
						if(methode.getName().matches("set.+")) {
							if(methode.getName().toLowerCase().matches("set"+field.getName().toLowerCase())) {
								try {
								  if(field.getName().matches("CodeArticle|Categorie")) {
									  methode.invoke(tmp,rs.getInt(field.getName()));
								  }else {
									  if(field.getName().matches("prix")) {
										  methode.invoke(tmp,rs.getFloat(field.getName()));
									  }else {
										  methode.invoke(tmp,rs.getString(field.getName()));
									  }
								  }
								} catch (IllegalAccessException | IllegalArgumentException |InvocationTargetException e ) {
									e.printStackTrace();
								}
							}
						}
					}
				}
				tmp_list.add(tmp);
		    }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		 return tmp_list;
	}
     
    public Article select_articles_byId(int CodeArticle){
 		Article tmp=new Article();
 		String sql= "SELECT * FROM articles where CodeArticle ="+CodeArticle+";"; 
 		ConnectionDB cx = null;
		ResultSet rs;
		 try {
			cx =new ConnectionDB();
 			rs = cx.getSt().executeQuery(sql);
 		    while (rs.next()) { 
 				for(Field field : tmp.getClass().getDeclaredFields()) {
 					for(Method methode:tmp.getClass().getMethods()) {
 						if(methode.getName().matches("set.+")) {
 							if(methode.getName().toLowerCase().matches("set"+field.getName().toLowerCase())) {
 								try {
 								  if(field.getName().matches("CodeArticle|Categorie")) {
 									  methode.invoke(tmp,rs.getInt(field.getName()));
 								  }else {
 									  if(field.getName().matches("prix")) {
 										  methode.invoke(tmp,rs.getFloat(field.getName()));
 									  }else {
 										  methode.invoke(tmp,rs.getString(field.getName()));
 									  }
 								  }
 								} catch (IllegalAccessException | IllegalArgumentException |InvocationTargetException e ) {
 									e.printStackTrace();
 								}
 							}
 						}
 					}
 				}
 		    }
 		} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		} 
 		 return tmp;
 		
 	}

   public  void ajouter_article_commande(int codeArticle) {
		ConnectionDB cx=null;
		try {
			cx = new ConnectionDB();
			cx.getSt().executeUpdate("INSERT INTO lignescommandes (NumCommande,CodeArticale) VALUES ('"+getnouveau_commande()+"',"+codeArticle+")" );
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void créer_commande(String email) {
		ConnectionDB cx=null;
		int CodeClient = 0;
		try {
			cx = new ConnectionDB();
			ResultSet rs = cx.getSt().executeQuery("select id from clients where Email='"+ email +"';");
			while(rs.next()) {
				CodeClient = rs.getInt("id");
			}
			cx.getSt().executeUpdate("INSERT INTO commandes (CodeClient) VALUES ("+CodeClient+")" );
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public int getnouveau_commande() {
		int i=0;
		ResultSet rset = null;
		ConnectionDB cx=null;
		try {
			cx = new ConnectionDB();
			rset=cx.getSt().executeQuery("select MAX(NumCommande) from commandes ;");
			if (rset.next()) i=rset.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return i;
	}
}
