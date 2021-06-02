<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Identification</title>
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style type="text/css">
	#cadre{
		background: mintcream;
		margin:5rem auto;
		width: 30%;
		border-radius: .5%;
		padding: 1rem;
		align-items: center;
		box-shadow: 0 0 .1rem .2rem rgba(0,0,0,0.2);
		text-align: center; 
	}

	input[type="submit"]{
		outline: none;
		width: 100%;
		border:none;
		margin: .2rem;
		padding: .5rem 1rem;
		border-radius: 1rem;
		color: white;
		background: #4892C2;
		font-size: 1.1rem;
		cursor: pointer;
	}
	
	input[type="password"],
	input[type="text"]{
		font-size: 1.2rem;
		outline: none;
		border: none;
		width: 100%;
	}
	
	input[type="password"]{
		box-sizing: border-box;
	}
	
	input[name="email"]{
		font-size: 1.2rem;
		background-color: white;
		box-shadow: 0 0 .1rem .2rem rgba(0,0,0,0.2);
		outline: none;
		border: none;
		padding: .5rem;
		border-radius: .2rem;
		width: 90%;
	}
	
	.zone{
		margin: 0 auto;
		width: 80%;
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		text-align: left;
	}
	
	.iconCl{
	    padding:1%;
	    width: 8%;
	    margin: 0 .3rem;
	}
	
	.zone:nth-child(2) > *:nth-child(2){
		display: flex;
		justify-content: space-between;
		background-color: white;
		box-shadow: 0 0 .1rem .2rem rgba(0,0,0,0.2);
		padding: .5rem .1rem;
		width: 91%;
		border-radius: .2rem;
	}
	
	.zone:nth-child(3){
		align-items: center;
	}
	
	.zone > *{
		margin: .2rem;
		font-size: 1.2rem;
	}
</style>
</head>
<body>
	<div id="cadre">
		<h2 style="margin: .3rem .4rem;">S'IDENTIFIER</h2>
		<form action="./identification" method="post">
			<div class="zone">
				<div><label for="email">Email</label></div>
				<div>
					<input type="text" name="email" id="email" placeholder="Email" ${ empty email? "" : 'value=' }  ${ empty email? "" : email }>
				</div>
				<div>
					<span style=" color: rgba(255,0,0,0.7); display: inline-block;">${ errEmail }</span>
				</div>
			</div>
			<div class="zone">
				<div><label for="mdpass">Mot de passe</label></div>
				<div>
					<input type="password" name="motpasse" id="mdpass" placeholder="Mot de passe"  ${ empty motDePasse? "" : "value=" } ${ empty motDePasse? "" : motDePasse}>
					<span class="fa fa-eye-slash iconCl" id="eye" onclick="typeC()" style="cursor: pointer;"></span>
				</div>
				<div>
					<span style=" color: rgba(255,0,0,0.7); display: inline-block;">${ errPass }</span>
				</div>
			</div>
			<div class="zone">
				<div>
					<input type="submit" name="submit" value="Se connecter" >
				</div>
			</div>
		</form>
	</div>
</body>
<script type="text/javascript">
var typeC = ( function () {
    var changer = 0;
    return function () {
      if(changer == 0) {
        document.getElementById("mdpass").type = "text";
        document.getElementById("eye").classList.replace("fa-eye-slash","fa-eye");
        changer = 1;
      } else {
        document.getElementById("mdpass").type = "password";
        document.getElementById("eye").classList.replace("fa-eye","fa-eye-slash");
        changer = 0;
      }
    };
}())
</script>
</html>