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
<title>Cadastro - Consulta</title>
<link href="../CSS/estilo3.css" rel="stylesheet" type="text/css">

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.maskedinput/1.4.1/jquery.maskedinput.min.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.0/jquery.mask.js"></script>
		
		<script type="text/javascript">
		
		$(document).ready(function () { 
	        $(".dataHora").mask('9999/99/99 99:99:99');
	    });
			
			
		</script>
		
</head>
<body>

<h1>Cadastrar Consulta</h1>      
<hr><br>

<form action="cadastroConsulta.jsp" method="get">
<p>
	Indique o CRMV do veterinario que realizará a consulta:  <input type="text" name="txtIdVet">
	</p>
	<p>Indique o ID do animal a ser consultado: <input type="number" name="txtIdA">
	</p>
	<p>
	<input type="submit" value="Pesquisar">
	</p>
	<% 
		String nomeA = "";
		String nomeV = "";
        	

    		String idA = (String) request.getParameter("txtIdA");
    		String idV = (String) request.getParameter("txtIdVet");
    		
    		if (idA == null || idV == null || idA.isEmpty() || idV.isEmpty() || idA == "" || idV == "" || idA.equals("null") || idV.equals("null")){
        		out.println("<p class='aviso'>Preencha os campos de identificação</p>");
        	}else{
        		try{
        			
    				cmdSQL = conexaoBD.prepareStatement("Select * From animal WHERE numCadastro = " + idA);
    								
    				rsSet = cmdSQL.executeQuery();
    								
    		if(rsSet.next()){
    			//achou
    			do{
    				
    				nomeA = rsSet.getString("nome");
    											
    			}while(rsSet.next());	
    				
    				//pega os dsdos
    			}
    		
    		
    		else{
    			
    			out.println("<p class='aviso'>Nenhum dado de animal foi encontrado com esse ID</p>");
    			
    			}
    								
    		}
    		catch(Exception ex){
    			out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
    			return;
    		}
					try{
        			
    				cmdSQL = conexaoBD.prepareStatement("Select * From veterinario WHERE numCRMV = " + idV);
    								
    				rsSet = cmdSQL.executeQuery();
    								
    		if(rsSet.next()){
    			//achou
    			do{
    				
    				nomeV = rsSet.getString("nome");
    											
    			}while(rsSet.next());	
    				
    				//pega os dsdos
    			}
    		
    		
    		else{
    			
    			out.println("<p class='aviso'>Nenhum dado de veterinário foi encontrado com  esse CRMV</p>");
    			
    			}
    								
    		}
    		catch(Exception ex){
    			out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
    			return;
    		}
        	}
    %>
    
</form>


<form action="../processamento/consultacrud.jsp" method="GET"> 
<p>
		<input readonly hidden type="text" maxlength="10" name="txtIdVet" value= "<%=idV%>" >    
		Nome do Veterinário: <input readonly type="text" maxlength="10" name="nomeV" value= "<%= nomeV %>" >     
	</p> 
	<p>
		<input readonly hidden type="text" maxlength="10" name="txtIdAnimal" value= "<%= idA %>" >    
		Nome do Animal: <input readonly  type="text" maxlength="10" name="nomeA" value= "<%= nomeA %>" >     
	</p>  
	
	<p>          
		Número da sala <input type="number" name="txtNumSala" min="1"  />
    </p>
    <p>
		Data e Hora <input type="datetime" name="txtDataHora" class="dataHora" />            
	</p>  
	<p>
    	Procedimento <input type="text" maxlength="200" size=60 name="txtProcedimento"  />            
    </p>
    
    <br>

	<br>
	<br>
	
	
	
	<p>
	<input type="submit" name="btnOperacao" value="Inserir"  /> 
	<input type="submit" name="btnOperacao" value="Visualizar"  />   
	<input type="submit" name="btnOperacao" value="Voltar"  />    
	</p>              
	<hr>    
</form>



</body>
</html>