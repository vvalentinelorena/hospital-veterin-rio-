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
<meta charset="UTF-8">
<link href="../CSS/estilo3.css" rel="stylesheet" type="text/css">
<title>Alterar - Animal</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.maskedinput/1.4.1/jquery.maskedinput.min.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.0/jquery.mask.js"></script>
	
		
</head>
<body>

<h1>Alterar Animal</h1>
<hr><br>
        <form action="alterarAnimal.jsp"  method="GET">
        <br><br><b>Indique o Id do animal que sofrerá alteção: </b>
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
        	
        	<form action="../processamento/animalcrud.jsp" method="get">
        	
   			<p>
   				ID <input id="idnimal" name="txtIdAnimal" type="text" value= "<%= idslc %>" readonly="readonly" > 
   			</p>
        	
	        <p>
				Nome <input type="text" maxlength="100" name="txtNome" id="txtNome" value = "<%=nomepreenche %>" />            
			</p> 
		 	<p>
		 		Idade <input type="number" min="1" name="txtIdade" value = "<%= idadepreenche %>" />            
		    </p> 
			<p>
		    	Raça <input type="text" maxlength="60" name="txtRaca"  value = "<%= racapreenche %>" />            
		    </p>
		    <p>
		    	Espécie <input type="text" maxlength="60" name="txtEspecie"  value = "<%= especiepreenche %>"  />            
		    </p>
		    <p>
		    	Número Carteira Vacinação <input type="text" maxlength="15" name="txtNumCV"  value ="<%= numcvpreenche %>" />            
		    </p>
		    <br>
            <input type="submit" name="btnOperacao" value="Alterar"  />  
            <input type="submit" name="btnOperacao" value="Voltar"  />                       
            <hr>
        </form>
        
       
        
        

</body>
</html>