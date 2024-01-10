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
	ResultSet rsCon = null;
	
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
<title>Cadastro - Internação</title>
<link href="../CSS/estilo3.css" rel="stylesheet" type="text/css">

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.maskedinput/1.4.1/jquery.maskedinput.min.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.0/jquery.mask.js"></script>
		
		<script type="text/javascript">
		
		$(document).ready(function () { 
	        $(".horarioVisita").mask('99:99:99');
	    });
			
			
		</script>
		
</head>
<body>

<h1>Cadastrar Internação</h1>      
<hr><br>

<form action="cadastroInternacao.jsp" method="get">
<p>
Indique o ID do animal a ser internado: <input type="number" name="txtIdA">
</p>
<p>
<input type="submit" value="Pesquisar">
</p>
<%
	String idAnimal = (String) request.getParameter("txtIdA");
	String nomeA = "", nomeC = "";
	Integer numCD = 0;
	if (idAnimal == null || idAnimal.isEmpty() || idAnimal == ""){
	out.println("<p class='aviso'>Preencha os campos de identificação</p>");
	}else{

	try{
		
		
			cmdSQL = conexaoBD.prepareStatement("Select * From animal WHERE numCadastro = " + idAnimal);
							
			rsCon = cmdSQL.executeQuery();
							
	if(rsCon.next()){
								
								
		do{
			nomeA = rsCon.getString("nome");
			numCD = rsCon.getInt("numCadastroDono");
							
										
		}while(rsCon.next());	
			
		}
	
	
	else{
		out.println("<p class='aviso'>Nenhum dado de animal foi encontrado</p>");
		}
							
	}
	catch(Exception ex){
		out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
		return;
	}
}
	if(numCD != null && numCD != 0){
		try{
			cmdSQL = conexaoBD.prepareStatement("Select * From cliente WHERE numCadastro = " + numCD);
							
			rsCon = cmdSQL.executeQuery();
							
		if(rsCon.next()){
								
								
		do{
			nomeC = rsCon.getString("nome");
							
										
		}while(rsCon.next());	
			
		
		}
	
	
	else{
		out.println("<p class='aviso'>Nenhum dado de cliente foi encontrado por esse id de animal</p>");
		}
							
	}
	catch(Exception ex){
		out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
		return;
	}
}
	
	
%>
</form>


<form action="../processamento/internacaocrud.jsp" method="GET">  
	<p>
		<input readonly hidden type="text" maxlength="10" name="txtIdAnimal" value= "<%=idAnimal %>" >    
		Nome do animal: <input readonly type="text" maxlength="10" name="nomeA" value="<%= nomeA %>" >     
	</p> 
	<p>
		<input readonly hidden type="text" maxlength="10" name="txtIdCliente" value="<%= numCD %>" >    
		Nome do Dono do animal: <input readonly type="text" maxlength="10" name="nomeC" value="<%= nomeC %>" >     
	</p> 
	<p>          
		ID Internação <input type="number" name="txtIdInternacao" min="1"  />
    </p>  
	<p>
    	Registro de Alimentação do Animal <input type="text" maxlength="150" name="txtRegistroAlimentacao"  />            
    </p>
    <p>
		Horario de Visita <input type="time" name="txtHorarioVisita" placeholder="99:99:99" />            
	</p>
	<p>
		Duração da Internação <input type="text" maxlength="200" name="txtDuracao" placeholder="xx horas/dias/meses"/>            
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