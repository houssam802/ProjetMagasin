package com.ensa.model;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Client {
	
	private String nom, prenom, email, ville, adresse, codepostal, motpasse, tel;
	
	public String[] getAttrETValue(){
		String[] donnees = new String[2];
		String champs = "", valeurs = "";
		Field[] fields = this.getClass().getDeclaredFields();
		Method[] methods = this.getClass().getMethods();
		for( Method method : methods) {
			if(method.getName().matches("get.+")) {
				for( Field field : fields) {
					if(("get"+field.getName().toLowerCase()).matches(method.getName().toLowerCase())) {
						try {
							champs += field.getName() + ",";
							valeurs += "'" + method.invoke(this, (Object[]) null).toString() + "'" + ",";
						} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
							e.printStackTrace();
						}
					}
				}
			}
		}
		donnees[0] = champs.replaceAll(",$", "");
		donnees[1] = valeurs.replaceAll(",$", "");
		return donnees;
	}

}
