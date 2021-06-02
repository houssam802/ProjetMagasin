<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Commande effectuée</title>
</head>
<body>
	<div style="font-size: 2.3rem; margin: 3rem auto; text-align: center;">
		Votre commande sera livrée	
	</div>
	<div style="font-size: 1.8rem; margin: 3rem auto; text-align: center;">
		vous sera redirigé à la page d'accueil dans <span id="elem"></span>
	</div>
</body>
<script>
    var i=5;
    setInterval(() => {
        if(i>=0){
            document.getElementById("elem").innerText = i--;
        } else location = "accueil";
    },1000);
</script>
</html>