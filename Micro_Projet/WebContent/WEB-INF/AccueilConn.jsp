<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Accueil</title>
	<style type="text/css">
		#parent{
			margin: 2rem;
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
		    font-size: 1.3rem;
		    display: flex;
			justify-content: center;
			align-items: flex-end;
			cursor: pointer;
		}
		a{
			text-decoration: none;
			font-size: 1.2rem;
			color: #4892C2;
		}
		a::before{
			content: '';
			display: inline-block;
			border: 0.35rem solid transparent;
			border-left-color: #4892C2;
		}
	</style>
</head>
<body>
	<div id="parent">
		<div id="titre">
			<div style="font-size: 2rem;">Bonjour ${ prenom }</div>
			<span class="fa fa-sign-out" id="deconnecter">Déconnecter</span>
		</div>
		<br><br>
		<a href="articles"> Articles </a>
	</div>
</body>
<script type="text/javascript">
	document.getElementById("deconnecter").addEventListener("click", () => {
		location = "deconnecter";
	});
</script>
</html>