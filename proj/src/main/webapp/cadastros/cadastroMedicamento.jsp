<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastrar - medicamento</title>
        <link href="../CSS/estilo3.css" rel="stylesheet" type="text/css">
    </head>
    <body>        
        <h1>Cadastro Medicamento</h1>      
        <hr><br>
        <form action="../processamento/medicamentocrud.jsp" method="GET">  
        	<p>          
            ID: <input type="number" name="txtId" min="1"  />
            </p>
            <p>
            Nome: <input type="text" maxlength="150" name="txtNome"  />            
           	</p> 
            <p>
            Tipo de medicamento: <input type="text" maxlength="60" name="txtTipo"  />            
           	</p> 
           	 <p>
            Instrumento de uso: <input type="text" maxlength="60" name="txtUso"  />            
           	</p> 
   			<br>
            <input type="submit" name="btnOperacao" value="Inserir"  /> 
            <input type="submit" name="btnOperacao" value="Visualizar"  />    
            <input type="submit" name="btnOperacao" value="Voltar"  />                  
            <hr>
        </form>
    </body>
</html>


