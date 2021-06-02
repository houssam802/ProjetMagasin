package com.ensa.model;

import java.text.NumberFormat;
import java.util.Locale;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Article {
    private int CodeArticle,Categorie;
    private String Designation,Stock,Photo;
    float prix;
    
    public String currency(Locale local,float rate) {
    	NumberFormat nft = NumberFormat.getCurrencyInstance(local);
		String formattedCurr = nft.format(valeur(rate));
		return formattedCurr;
    }
    
    public Float valeur(float rate) {
    	return prix*rate;
    }
}
