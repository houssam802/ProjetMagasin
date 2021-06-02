<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="CSS/inscription.css">
<title>Inscription</title>
</head>
<body>
	<div id="cadre">
		<h2 style="margin: .3rem .4rem;">INSCRIPTION</h2>
		<form action="./inscription" method="post" name="inscrit" onsubmit=" return checkForm() ">
			<div class="zone">
				<div><label for="nom">Nom</label></div>
				<div>
					<div>
					<input type="text" name="nom" id="nom" placeholder="Nom" value="${ client.nom }">
					</div>
					<div>
					<span></span>
					</div>
				</div>
			</div>
			<div class="zone">
				<div><label for="prenom">Prenom</label></div>
				<div>
					<div>
					<input type="text" name="prenom" id="prenom" placeholder="Prenom" value="${ client.prenom }">
					</div>
					<div>
					<span></span>
					</div>
				</div>
			</div>
			<div class="zone">
				<div><label for="email">Email</label></div>
				<div>
					<div>
						<input type="text" name="email" id="email" placeholder="Email" value="${ client.email }">
					</div>
					<div>
						<span style="color: rgba(255,0,0,0.7);">${ EmailErr }</span>
					</div>
				</div>
			</div>
			<div class="zone">
				<div><label for="tel">Tél</label></div>
				<div>
					<div>
					<input type="text" name="tel" id="tel" placeholder="+212 XXX-XXXXXX" value="${ client.tel }">
					</div>
					<div>
						<span></span>
					</div>
				</div>
			</div>
			<div class="zone">
				<div><label for="adresse">Adresse</label></div>
				<div>
					<div>
					<input type="text" name="adresse" id="adresse" placeholder="Adresse" value="${ client.adresse }">
					</div>
					<div>
						<span></span>
					</div>
				</div>
			</div>
			<div class="zone">
				<div><label for="ville">Ville</label></div>
				<div>
					<div>
					<input type="text" name="ville" id="ville" placeholder="Ville" value="${ client.ville }">
					</div>
					<div>
						<span></span>
					</div>
				</div>
			</div>
			<div class="zone">
				<div><label for="code">CodePostal</label></div>
				<div>
					<div>
					<input type="text" name="codepostal" id="code" placeholder="CodePostal" value="${ client.codepostal }">
					</div>
					<div>
						<span></span>
					</div>
				</div>
			</div>
			<div class="zone">
				<div><label for="mdpass">Mot de passe</label></div>
				<div>
					<div>
					<input type="password" name="motpasse" id="mdpass" placeholder="Mot de passe" value="${ client.motpasse }">
					</div>
					<div>
						<span></span>
					</div>
				</div>
			</div>
			<div class="zone">
				<div><label for="cmdpass">Confirmer votre mot de passe</label></div>
				<div>
					<div>
						<input type="password" name="cmotpasse" id="cmdpass" placeholder="Confirmer mot de passe" >
					</div>
					<div>
						<span></span>
					</div>
				</div>
			</div>
			<div class="zone">
				<div style="display: flex; justify-content: flex-end;">
					<input type="submit" name="submit" value="S'inscrire" >
				</div>
			</div>
		</form>
	</div>
</body>
<script type="text/javascript">
var motpasse;
function checkForm(){
  let formValide = [];
  try{
  let x = document.forms["inscrit"];
  for(let i = 0,j = 0; i < x.length; i++){
	if( x.elements[i].name !== "submit" ) {
	  formValide[j] = (champObligatoire(x.elements[i])) && (verifierInput(x.elements[i]));
	  j++;
    }
  }
  }catch(e){
	console.log(e);
  }finally{
    return formValide.find(ele => { return ele === false; }) === undefined;
  }
}

function champObligatoire(input) {
  cleanInput(input);
  input.value === "" ?  Erreur(input, "Champ obligatoire") : Success(input);
  return input.value !== "";
}

function verifierInput(input) {
  let inputValide = true;
  if( input.name === "email" ){
	inputValide = verifierEmail(input);
  }
  if( input.name === "tel" ){
	inputValide = verifierTel(input);
  }
  if( input.name === "motpasse" ){
	motpasse = input;
  }
  if( input.name === "cmotpasse" ){
	inputValide = veriferMotPasse(motpasse,input);
  }
  return inputValide;
}

function verifierEmail(input){
  if(input.value !== ""){
    const re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    re.test(input.value) ? Success(input) : Erreur(input, "Format email invalid !");
    return re.test(input.value);
  }
}

function verifierTel(input){
  if(input.value !== ""){
  	const re = /^(\+[0-9]{3}( )[6-7][0-9]{2}\-[0-9]{6})$/;
  	re.test(input.value) ? Success(input) : Erreur(input, "Format tel invalid !");
    return re.test(input.value);
  }
}

function veriferMotPasse(motpasse, confirmation){
  let verifier = false;
  const pass = motpasse.value;
  if(pass !== ""){
  	pass.length >= 8 ? Success(motpasse) : Erreur(motpasse, "Au moins 8 caractères");
    verifier = pass.length >= 8;
    if( !motpasse.checkValidity()){
	  Erreur(motpasse, motpasse.validationMessage);
      verifier = false;
	}
  }
  const confir = confirmation.value;
  if(confir !== "" && verifier){
  	pass === confir ? Success(confirmation) : Erreur(confirmation, "Mot de passe différent");
	verifier = pass === confir;
  } else {
	confirmation.style.boxShadow = "0 0 .1rem .2rem rgba(0,0,0,0.2)";
    var span = confirmation.parentNode.nextElementSibling.childNodes[1];
    span.innerHTML = "";
    span.classList.remove("fa");
    span.className -= " fa-check";
  }
  return verifier;
}

function cleanInput(input){
  if( input.name !== "motpasse" && input.name !== "cmotpasse" ){
	if( input.name !== "tel" && input.name !== "email" ){
	  input.value = input.value.trim();
	  input.value = input.value.replace(/[<( )>]+/gi, "");
	}
  }
}

function Erreur(input, message){
  input.style.boxShadow = "0 0 .1rem .2rem rgba(255,0,0,0.5)";
  var span = input.parentNode.nextElementSibling.childNodes[1];
  span.innerHTML = "";
  span.classList.remove("fa");
  span.className -= " fa-check";
  span.innerHTML = message;
  span.style.color = "rgba(255,0,0,0.7)";
}

function Success(input){
  input.style.boxShadow = "0 0 .1rem .2rem rgba(0,255,0,0.5)";
  var span = input.parentNode.nextElementSibling.childNodes[1];
  span.innerHTML = "";
  span.classList.add("fa");
  span.className += " fa-check";
  span.style.color = "rgba(0,255,0,0.7)";
}
</script>
</html>