<%@page import="java.util.ArrayList"%>
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
	//aaaa-mm-dd hh:mm:ss
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
<title>Cadastro - Medicamento(s) da Internação</title>
<link href="../CSS/estilo3.css" rel="stylesheet" type="text/css">

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.maskedinput/1.4.1/jquery.maskedinput.min.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.0/jquery.mask.js"></script>
		
</head>
<body>

<h1>Cadastrar Medicamento(s) da Internação</h1>      
<hr><br>

<form action="cadastroMedicamentoInternacao.jsp" method="get">
	<p>
	Indique o ID da internação para associar um medicamento: <input type="number" name="idI" min=1>
	</p>
	<p>
	Indique o ID do medicamento que será associado: <input type="number" name="idM" min=1>
	</p>
	<p>
	<input type="submit" value="Pesquisar">
	</p>
<%

			String nomeM = "";
    		String idI = (String) request.getParameter("idI");
    		String idM = (String) request.getParameter("idM");
    		
    		if (idI == null || idM == null || idI.isEmpty() || idM.isEmpty() || idI == "" || idM == ""){
        		out.println("<p class='aviso'>Preencha os campos de identificação</p>");
        	}else{
        		try{
        			
    				cmdSQL = conexaoBD.prepareStatement("Select * From internacao WHERE idInternacao = " + idI);
    								
    				rsSet = cmdSQL.executeQuery();
    								
    		if(rsSet.next()){
    			//achou
    			do{
    				
    											
    			}while(rsSet.next());	
    				
    				//pega os dsdos
    			}
    		
    		
    		else{
    			
    			out.println("<p class='aviso'>Nenhum dado de internação foi encontrado por esse ID</p>");
    			
    			}
    								
    		}
    		catch(Exception ex){
    			out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
    			return;
    		}
					try{
        			
    				cmdSQL = conexaoBD.prepareStatement("Select * From medicamento WHERE idMedicamento = " + idM);
    								
    				rsSet = cmdSQL.executeQuery();
    								
    		if(rsSet.next()){
    			//achou
    			do{
    				
    				nomeM = rsSet.getString("nome");
    											
    			}while(rsSet.next());	
    				
    				//pega os dsdos
    			}
    		
    		
    		else{
    			
    			out.println("<p class='aviso'>Nenhum dado de medicamento foi encontrado por esse ID</p>");
    			
    			}
    								
    		}
    		catch(Exception ex){
    			out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
    			return;
    		}
        	}
    %>
</form>
<form action="../processamento/medicamentointernacaocrud.jsp" method="GET">  
	<p>
		Número Internação: <input readonly type="text" name="txtIdInternacao" value= "<%= idI %>" >      
	</p> 
	<p>
	
		<input readonly hidden type="text" name="txtIdMedicamento" value= "<%= idM %>" >    
		Nome do medicamento: <input readonly type="text" name="txtNomeMedicamento" value= "<%= nomeM %>" >   
	
	</p> 
	<p>
	<p>
	<input type="submit" name="btnOperacao" value="Inserir"  /> 
	<input type="submit" name="btnOperacao" value="Visualizar"  /> 
	<input type="submit" name="btnOperacao" value="Voltar"  />   
	</p>              
	<hr>    
</form>



</body>
</html>