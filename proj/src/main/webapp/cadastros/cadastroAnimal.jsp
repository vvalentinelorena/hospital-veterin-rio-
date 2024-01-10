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
	ResultSet rsDono = null;
	
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
<title>Cadastro - animal</title>
<link href="../CSS/estilo3.css" rel="stylesheet" type="text/css">
</head>
<body>

<h1>Cadastrar Animal</h1>      
<hr><br>
<form action="cadastroAnimal.jsp" method="GET">
	<p>
   <b>Indique o ID do dono do animal a ser cadastrado</b> <input type="number" name="txtIdDono">
   </p>
   <p>
   <input type="submit" value="Pesquisar">
   </p>
</form>

<%
	String idD = (String) request.getParameter("txtIdDono");
	String nomeD = "";

	if (idD == null || idD.isEmpty()|| idD == ""){
		out.println("<p class='aviso'>Preencha os campos de identificação</p>");
	}else{
	try{
	
		cmdSQL = conexaoBD.prepareStatement("Select * From cliente WHERE numCadastro = " + idD);
						
		rsDono = cmdSQL.executeQuery();
						
		if(rsDono.next()){
							
	
								
								
		do{
			
			nomeD = rsDono.getString("nome");		
										
										
		}while(rsDono.next());	
			
		}
	
	
	else{
		out.println("<p class='aviso'>Não existe um cliente cadastrado no site com o número de identificação encontrado</p>");
		}
							
	}
	catch(Exception ex){
		out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
		return;
	}
}
%>



<form action="../processamento/animalcrud.jsp" method="GET">  
<p>
		<input readonly hidden type="text" maxlength="10" name="idDono" value="<%= idD %>" />    
		Nome do dono: <input readonly type="text" maxlength="10" name="nomeD" value="<%= nomeD %>" />     
	</p> 

	<p>          
		Número de cadastro <input type="number" name="txtNumCadastro" min="1"  />
    </p>
    <p>
		Nome <input type="text" maxlength="100" name="txtNome"  />            
	</p> 
 	<p>
 		Idade <input type="number" min="1" name="txtIdade"  />            
    </p> 
	<p>
    	Raça <input type="text" maxlength="60" name="txtRaca"  />            
    </p>
    <p>
    	Espécie <input type="text" maxlength="60" name="txtEspecie"  />            
    </p>
    <p>
    	Número Carteira Vacinação <input type="text" maxlength="15" name="txtNumCV"  />            
    </p>
   

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