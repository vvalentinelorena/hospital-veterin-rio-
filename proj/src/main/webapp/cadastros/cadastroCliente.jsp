<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/estilo3.css" rel="stylesheet" type="text/css">
        <!-- scripts para manipular mascaras de tel. e contato -->
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.maskedinput/1.4.1/jquery.maskedinput.min.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.0/jquery.mask.js"></script>
		<script type="text/javascript">
			jQuery( function($){
			    $(".telefone").mask("(99) 9999-99999");
			    //$(".cpf").mask("000.000.000-00" {reverse: true});
			    $(".telefone").blur(function(event) {
			        if($(this).val().length == 16){
			          $('.telefone').mask('(99) 99999-9999' );
			        } else {
			          $('.telefone').mask('(99) 9999-99999');
			        }
			    });
			});
			
			
		</script>
		
		<script type="text/javascript">
		
		$(document).ready(function () { 
	        $(".cpf").mask('000.000.000-00', {reverse: true});
	    });
			
			
		</script>

	  
        <title>Cadastrar - cliente</title>
    </head>
    <body>        
        <h1>Cadastro Cliente</h1>      
        <hr><br>
        <form action="../processamento/clientecrud.jsp" method="GET">  
        	<p>          
            Número de cadastro <input type="number" name="txtNumCadastro" min="1"  />
            </p>
            <p>
            Nome <input type="text" maxlength="100" name="txtNome"  />            
           	</p> 
           	 <p>
            CPF <input type="text" maxlength="15" name="txtCpf" class="cpf" placeholder="000.000.000-00"  />            
           	</p> 
           	 <p>
            Data de nascimento <input type="date" maxlength="15" name="txtDataNas" min="1900-12-31" max="2023-12-31" />            
           	</p> 
           	 <p>
            Telefone <input type="text" maxlength="15" name="txtTelefone" class="telefone" placeholder="(99) 9999-99999" />            
           	</p> 
           	 <p>
            Contato <input type="text" maxlength="15" name="txtContato" class="telefone" placeholder="(99) 9999-99999"/>            
           	</p> 
   			<br>
            <input type="submit" name="btnOperacao" value="Inserir"  /> 
            <input type="submit" name="btnOperacao" value="Visualizar"  />    
            <input type="submit" name="btnOperacao" value="Voltar"  />
            <hr>
        </form>
    </body>
</html>


