<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
    
<%
	//---------------------------------------
	// Conexão com o banco de dados
	//---------------------------------------
	
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
<title>Cadastro - Alergias (ainda nao funcionando)</title>
<link href="../CSS/estilo3.css" rel="stylesheet" type="text/css">
</head>
<body>

<h1>Cadastrar Alergias</h1>      
<hr><br>

<form action="cadastroAlergias.jsp">
	<br><br><b>Indique o ID do animal para associar à alergia do medicamento </b>
	<p>
	<input type="number" name="txtIdA">
	</p>
	<b>Indique o ID do medicamento que causa alergia </b>
	<p>
	<input type="number" name="txtIdM">
	</p>
	<p>
	<input type="submit" value="Pesquisar">
	</p>
	<% 
			String nomeA = "";
			String nomeM = "";
        	

    		String idanimal = (String) request.getParameter("txtIdA");
    		String idmed = (String) request.getParameter("txtIdM");
    		
    		if (idanimal == null || idmed == null || idanimal.isEmpty() || idmed.isEmpty() || idanimal == "" || idmed == ""){
        		out.println("<p class='aviso'>Preencha os campos de identificação</p>");
        	}else{
        		try{
        			
    				cmdSQL = conexaoBD.prepareStatement("Select * From animal WHERE numCadastro = " + idanimal);
    								
    				rsSet = cmdSQL.executeQuery();
    								
    		if(rsSet.next()){
    			//achou
    			do{
    				
    				nomeA = rsSet.getString("nome");
    											
    			}while(rsSet.next());	
    				
    				//pega os dsdos
    			}
    		
    		
    		else{
    			
    			out.println("<p class='aviso'>Nenhum dado de animal foi encontrado</p>");
    			
    			}
    								
    		}
    		catch(Exception ex){
    			out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
    			return;
    		}
try{
        			
    				cmdSQL = conexaoBD.prepareStatement("Select * From medicamento WHERE idMedicamento = " + idmed);
    								
    				rsSet = cmdSQL.executeQuery();
    								
    		if(rsSet.next()){
    			//achou
    			do{
    				
    				nomeM = rsSet.getString("nome");
    											
    			}while(rsSet.next());	
    				
    				//pega os dsdos
    			}
    		
    		
    		else{
    			
    			out.println("<p class='aviso'>Nenhum dado de medicamento foi encontrado</p>");
    			
    			}
    								
    		}
    		catch(Exception ex){
    			out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
    			return;
    		}
        	}
    %>
</form>

<form action="../processamento/animalalergiascrud.jsp" method="GET">	
	<p>
		<input readonly hidden type="text" maxlength="10" name="idA" value="<%=idanimal %>" >    
		Nome do animal: <input readonly type="text" maxlength="10" name="nomeA" value="<%= nomeA %>" />     
	</p> 
	<p>
		<input readonly hidden type="text" maxlength="10" name="idM" value="<%=idmed %>" />    
		Nome do medicamento: <input readonly  type="text" maxlength="10" name="nomeA" value="<%= nomeM %>" />     
	</p> 
	
    <p>
		Nível de alergia: <input type="text" maxlength="10" name="txtNivelAlergia"  >            
	</p> 
	<p>
	
	
	<input type="submit" name="btnOperacao" value="Inserir"  /> 
	<input type="submit" name="btnOperacao" value="Visualizar"  />   
	<input type="submit" name="btnOperacao" value="Voltar"  />   
	</p>              
	<hr>    
</form>



</body>
</html>