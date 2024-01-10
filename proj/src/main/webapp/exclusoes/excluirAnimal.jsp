<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.SQLException" %>

<%
	String banco, usuario, senha;
	
	Connection conexaoBD = null;
	PreparedStatement cmdSQL = null;
	ResultSet rsSet = null;
	
	try{
		banco = "jdbc:mysql://localhost/hospitalveterinariodb";
		usuario = "root";
		senha = "";
		
		Class.forName("com.mysql.jdbc.Driver");
		
		conexaoBD = DriverManager.getConnection(banco, usuario, senha);
	}
	catch(Exception ex){
		out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
		return;
	}
	
%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Excluir Animal</title>
        <link href="../CSS/estilo3.css" rel="stylesheet" type="text/css">
        <style type="text/css"></style>
    </head>
    <body>
        <h1>Excluir Animal</h1>       
        <hr><br>
        <form action="excluirAnimal.jsp" method="get">
        	<br><br><b>Indique o Id do animal que deseja excluir: </b>
        <p>
        Id animal: <input type="number" name="txtIdAnimal" min=1>
        </p>
        <p>
        <input type='submit' value='Pesquisar'>
        </p>
        	<%
        	
        	String nomepreenche = "";
        	String idadepreenche = "";
        	String racapreenche = "";
        	String especiepreenche = "";
        	String numcvpreenche = "";
        
        	String idslc = (String) request.getParameter("txtIdAnimal");
        	if (idslc == null || idslc.isEmpty() || idslc == "" ){
        		out.println("<p class='aviso'>Preencha os campos de identificação</p>");
        	}else{
        		try{
        			
    				cmdSQL = conexaoBD.prepareStatement("Select * From animal WHERE numCadastro = " + idslc);
    								
    				rsSet = cmdSQL.executeQuery();
    								
    		if(rsSet.next()){
    			//achou
    			do{
    				nomepreenche = (String) rsSet.getString("nome");
    				idadepreenche = (String) rsSet.getString("idade");
    				racapreenche = (String) rsSet.getString("raca");
    			    especiepreenche = (String) rsSet.getString("especie");
    			    numcvpreenche = (String) rsSet.getString("numCarteiraVac");
    								
    											
    			}while(rsSet.next());	
    				
    				//pega os dsdos
    			}
    		
    		
    		else{
    			out.println("<p class='aviso'>Nenhum dado foi encontrado</p>");
    			}
    								
    		}
    		catch(Exception ex){
    			out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
    			return;
    		}
        	}
        	
        		
        	%>
        	
        </form>
        <form action="../processamento/animalcrud.jsp" method="GET">
        	<p>
   				ID <input readonly id="idnimal" name="txtIdAnimal" type="text" value= "<%= idslc %>" /> 
   			</p>
        	
	        <p>
				Nome <input readonly type="text" maxlength="100" name="txtNome" id="txtNome" value = "<%=nomepreenche %>" />            
			</p> 
		 	<p>
		 		Idade <input readonly type="number" min="1" name="txtIdade" value = "<%= idadepreenche %>" />            
		    </p> 
			<p>
		    	Raça <input readonly type="text" maxlength="60" name="txtRaca"  value = "<%= racapreenche %>" />            
		    </p>
		    <p>
		    	Espécie <input readonly type="text" maxlength="60" name="txtEspecie"  value = "<%= especiepreenche %>"  />            
		    </p>
		    <p>
		    	Número Carteira Vacinação <input readonly type="text" maxlength="15" name="txtNumCV"  value = "<%= numcvpreenche %>" />            
		    </p>
                        
        	<hr>
            <h1 class="msgExcluir">Deseja realmente excluir os dados?</h1>  
          	<h3 class="msgExcluir">Excluir esse animal também excluirá alergias, internações e consultas em que o animal estiver registrado.</h3>
          	<div class="btnRes">
          	<input type="submit" name="btnOperacao" value="Excluir"  /> 
            <input type="submit" name="btnOperacao" value="Voltar"  />    
            </div> 
        </form>
        
           
    </body>
</html>
