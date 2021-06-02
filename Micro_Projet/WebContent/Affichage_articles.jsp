<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>

<fmt:setLocale value="en_EN" />
<fmt:setBundle basename="com.ensa.model.messages" />
<html lang="es_ES">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"  />
<!--<link rel="stylesheet" type="text/css" href="CSS/affichage_art.css">-->
<title>Articles</title>
<style type="text/css">
	@charset "UTF-8";

body{
  width: 100%;
  height: 100%;
}

#parent{
	margin: 1.2rem 1.4rem;
}
#titre{
	padding: .3rem;
	border: solid 1px transparent;
	border-bottom-color: black;
	display: flex;
	justify-content: space-between;	
}
.fa-sign-out{
	display: inline-block;
    font-size: 1.5rem;
    display: flex;
	justify-content: center;
	align-items: flex-end;
	cursor: pointer;
}

#panier{
	position: absolute;
	top: 14%;
	right: 3%;	
	cursor: pointer;
	display: flex;
}

.fa-shopping-cart{
	display: inline-block;
    font-size: 1.5rem;
    display: flex;
	justify-content: center;
	align-items: flex-end;
	cursor: pointer;
}

#compteur{
	width:20px; 
	height: 20px; 
	display: flex;
	justify-content: center;
	align-items: center;
	border-radius: 10px; 
	color: white; 
	background-color: orange;
	position: absolute;
	top: 60%;
	left: 50%;
}

.article{
    width: clamp(200px, 70%, 800px);
    margin: 1rem auto;
    display: flex;
    flex-wrap: wrap;
    border: 1px black;
}
.img{
	background-position: 50% 50%;
	background-size: contain;
	background-repeat: no-repeat;
}

.article > *:nth-child(1){
    flex: 1 1 20ch;
    min-height: 150px;
    min-width: 30ch;
    border: 1px solid;
}
.article > *:nth-child(2){
    flex: 1 1 45ch;
    min-height: 150px;
    min-width: 30ch;
    border: 1px solid;
}
.info{
    display: flex;
    justify-content: space-between;
    padding: .3rem;
    font-size: 1.2rem;
}
.cart{
    margin-top: .3rem;
    display: flex;
    justify-content: flex-end;
}
.fa-cart-plus{
    margin-right: .5rem;
    cursor: pointer;
}
</style>
</head>
<body onload="set_cmd()">
   	<div id="parent">
		<div id="titre">
			<div style="font-size: 2rem;">Articles</div>
			<span class="fa fa-sign-out" id="deconnecter">Déconnecter</span>
			<div id="panier">
				<a href="commandes" style="text-decoration: none; color: black;">
					<span class="fa fa-shopping-cart"></span>
					<div id="compteur">0</div>
				</a>
			</div>
		</div>
		<br><br>
	 	<form action="articles" method="get">
	 	<div class="container-fluid">
	 	    <label for="catg">Catégorie :</label>
			<select name="categorie" id="catg">
			    <option value="Tous">--Tous les Catégories--</option>
				<option value="Telephone">Télephone</option>
				<option value="PC portable">PC portable</option>
			</select>
	 		<input type="submit" value="filtrage">
	 	</div>
	 	</form>
	 	
	 	 <a href="?country=EUR">FRANCE</a>
	     <a href="?country=USD">USA</a>
	     <a href="?country=MAD">Morrocco</a>
	
	  	<c:forEach items="${ articles }" var="article" varStatus="status">
		  <div class="article">
		     <div class="img" style="background-image: url('${ article.getPhoto() }');" class="col-sm-4">
		     </div>
		     <div class="article_infos">
             	<div class="info">
	                <div class="titre">
	                    ${ article.getDesignation() }
	                </div>
	                <div id="prix">
	                   ${ article.currency(local,rate) }
	                </div>
	            </div>
	            <div class="cart"> 
	                <span onclick="add(this)" class="fa fa-cart-plus" id="${article.getCodeArticle()}" style="font-size:23pt;"></span>
	            </div>
		      </div>
		  </div>
	  	</c:forEach>
	  	</div>
</body>

<script>
	
	document.getElementById("deconnecter").addEventListener("click", () => {
		location = "deconnecter";
	});
	
	let element = document.getElementById("catg");
	element.value = "${categorie }";

  function set_cmd(){
	  var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) {
		    	document.getElementById("compteur").innerHTML =this.responseText;
	    }
	  };
	  xhttp.open("GET", "${pageContext.request.contextPath }/Servlet_nbr_cmd", true);
	  xhttp.send();
	}
  function add(elem){
	  var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) {
		    	document.getElementById("compteur").innerHTML =this.responseText;
	    }
	  };
	  xhttp.open("POST", "${pageContext.request.contextPath }/Servlet_nbr_cmd", true);
	  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	  xhttp.send("CodeArticle="+elem.id);
	}

</script>
</html>