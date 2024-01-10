<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastrar - Aparelho</title>
        <link href="../CSS/estilo3.css" rel="stylesheet" type="text/css">
    </head>
    <body>        
        <h1>Cadastro Aparelho</h1>      
        <hr><br>
        <form action="../processamento/aparelhocrud.jsp" method="GET">  
        	<p>          
            ID <input type="number" name="txtId" min="1"  />
            </p>
            <p>
            nome <input type="text" maxlength="150" name="txtNome"  />            
           	</p> 
            <p>
            Objetivo de uso <input type="text" maxlength="60" name="txtUso"  />            
           	</p> 
   			<br>
            <input type="submit" name="btnOperacao" value="Inserir"  /> 
            <input type="submit" name="btnOperacao" value="Visualizar"  />   
            <input type="submit" name="btnOperacao" value="Voltar">                  
            <hr>
        </form>
    </body>
</html>


