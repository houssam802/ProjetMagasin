<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Commandes</title>
<link rel="stylesheet" type="text/css" href="CSS/commande.css">
</head>
<body>

   	<div id="parent">
		<div id="titre">
			<div style="font-size: 2rem;">Votre commande</div>
		</div>
		<br><br>
		<c:forEach items="${ articles }" var="article" varStatus="status">
			  <div class="article" id="${ article.codeArticle}">
			     <div>
			     	<div class="photo" style="background-image: url('${ article.photo }') ;">
			       	</div>
			      	<div class="prix">
			      	     ${ article.prix }
			       	</div>
			       	<div class="text">
			       		${ article.designation }
			       	</div>
			     </div>
			  </div>
		  </c:forEach>
		  <div class="boutons">
		  	<a href="${pageContext.request.contextPath }/Servlet_annuler_cmd">Annuler la commande</a>
		  	<div class="bouton" onclick="commander()">Passer la commande</div>
		  </div>
	  </div>
</body>

<script type="text/javascript">
	function commander(){
		var produits = { articles : [] };
		var codes = document.getElementsByClassName("article");
		for(let element of codes){
			produits.articles.push(element.id);
		}
		var produitsJSON = JSON.stringify(produits);
		console.log(produitsJSON);
		redirect('confirmer', 'post', produitsJSON);
	}
	function redirect(url, method, data) {
	    var form = document.createElement('form');
	    form.method = method;
	    form.action = url;
	    var input = document.createElement('input');
	    input.type = "text";
	    input.name = "data";
	    input.value = data;
	    form.appendChild(input);
	    form.style.display = "none";
	    document.body.appendChild(form);
	    form.submit();
	}
</script>

</html>