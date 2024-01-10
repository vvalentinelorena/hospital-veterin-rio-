<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Hospital Veterinário SCL</title>
<link href="./CSS/estilo.css" rel="stylesheet" type="text/css">
</head>
<body>

<div id="area">
	<div class="box-tab">
    <input class="radio" id="um" name="group" type="radio" checked>
    <input class="radio" id="dois" name="group" type="radio">
    <input class="radio" id="tres" name="group" type="radio">
  
    <div class="tabs">
    
        <label class="tab" id="one-tab" for="um">Secretário</label>
        <label class="tab" id="two-tab" for="dois">Veterinário</label>
   
   </div>
  
    <div class="panels">
  
        <div class="panel" id="tab-um">
            
            <h2 class="tab-title">Você é um secretário?</h2>
           
		   	<form class="formulario" autocomplete="off" action="autenticacao.jsp" method="GET">
		      <fieldset>
		        <legend>Campo de login</legend>
		        <label>E-mail:</label><input class="emailSecretario" name="emailSecretario" type="text"><br>
		        <label>Senha:</label><input class="senhaSecretario" name="senhaSecretario" type="password"><br>
		        <label>Chave de acesso:</label><input class="CASecretario" name="CASecretario" type="password"><br><br>
		        <input type="submit" name="btnOperacao" value="Login Secretario" /> 
		      </fieldset>
		    </form>

           
        
        </div>
        <div class="panel" id="tab-dois">
        
            <h2 class="tab-title">Você é um veterinário?</h2>
                <form class="formulario" autocomplete="off" action="autenticacao.jsp" method="GET">
		      <fieldset>
		        <legend>Campo de login</legend>
		        <label>CRMV:</label><input class="crmvVet" name="crmvVet" type="text"><br>
		        <label>Senha:</label><input class="senhaVet" name="senhaVet" type="password"><br>
		        <label>Chave de acesso:</label><input class="CAVet" name="CAVet" type="password"><br><br>
		        <input type="submit" name="btnOperacao" value="Login Veterinario"  /> 
		      </fieldset>
		    </form>

            
        
        </div>
        
     
  
    </div>
  
	</div>
</div>

</body>
</html>