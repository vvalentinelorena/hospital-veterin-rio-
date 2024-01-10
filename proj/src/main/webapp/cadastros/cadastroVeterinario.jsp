<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastrar - veterinario</title>
        <link href="../CSS/estilo3.css" rel="stylesheet" type="text/css">
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.maskedinput/1.4.1/jquery.maskedinput.min.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.0/jquery.mask.js"></script>
		
		
		<script type="text/javascript">
		
		$(document).ready(function () { 
	        $(".HorarioAtendimento").mask('99h às 99h');
	    });
			
			
		</script>
		
    </head>
    <body>        
        <h1>Cadastro Veterinário</h1>      
        <hr><br>
        <form action="../processamento/veterinariocrud.jsp" method="GET">  
        	<p>          
            CRMV <input type="number" min=1 name="txtCrmv" />
            </p>
            <p>
            Nome <input type="text" maxlength="100" name="txtNome"  />            
           	</p> 
           	 <p>
            Senha <input type="password" maxlength="50" name="txtSenha"  />            
           	</p> 
           	 <p>
            Faculdade <input type="text" maxlength="150" name="txtFaculdade"  />            
           	</p> 
           	 <p>
            Horario/Atendimento <input type="text" maxlength="45" name="txtHorarioAtendimento" class="HorarioAtendimento" placeholder="99h às 99h" />            
           	</p> 
   			<br>
            <input type="submit" name="btnOperacao" value="Inserir"  /> 
            <input type="submit" name="btnOperacao" value="Visualizar"  />  
            <input type="submit" name="btnOperacao" value = "Voltar">                   
            <hr>
        </form>
    </body>
</html>


