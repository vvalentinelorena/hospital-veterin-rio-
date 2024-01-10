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
        <title>Excluir Aparelho</title>
        <link href="../CSS/estilo3.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <h1>Excluir Aparelho</h1>       
        <hr><br>
        <form action="excluirAparelho.jsp" method="get">
        <br><br><b>Indique o Id do aparelho que deseja excluir: </b>
        <p>
        <input type="number" name="txtIdAparelho" min=1>
        </p>
        <p>
        <input type="submit" value="Pesquisar">
		</p>
        	<%
        	
        	String nomepreenche = "";
        	String objetivopreenche = "";
        	String idAparelho = (String) request.getParameter("txtIdAparelho");
        	
        	if (idAparelho == null || idAparelho.isEmpty() || idAparelho == "" ){
        		out.println("<p class='aviso'>Preencha os campos de identificação</p>");
        	}else{
    		try{
    			
    				cmdSQL = conexaoBD.prepareStatement("Select * From aparelho WHERE idAparelho = " + idAparelho);
    								
    				rsSet = cmdSQL.executeQuery();
    								
    		if(rsSet.next()){
    									
    			
    									
    									
    			do{
    				nomepreenche = (String) rsSet.getString("nome");
	    			objetivopreenche = (String) rsSet.getString("objetivoUso");
    								
    											
    			}while(rsSet.next());	
    				
	    			
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
        	
        <form action="../processamento/aparelhocrud.jsp" method="GET">
        	
        	<p>
   				ID aparelho <input name="txtId" type="text" readonly value= "<%= idAparelho %>" /> 
   			</p>
        	
         <p>
            nome <input readonly type="text" maxlength="150" name="txtNome" value= "<%= nomepreenche %>"  />            
           	</p> 
            <p>
            Objetivo de uso <input readonly type="text" maxlength="60" name="txtUso"  size=60 value= "<%= objetivopreenche %>" />            
           	</p> 
           
                            
            <hr>
            <h1 class="msgExcluir">Deseja realmente excluir os dados?</h1> 
          	<div class="btnRes">
          	<input type="submit" name="btnOperacao" value="Excluir"  /> 
            <input type="submit" name="btnOperacao" value="Voltar"  />    
            </div> 
        </form>
    </body>
</html>
