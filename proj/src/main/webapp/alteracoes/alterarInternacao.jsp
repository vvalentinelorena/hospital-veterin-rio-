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
<title>Alterar - Internação</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.maskedinput/1.4.1/jquery.maskedinput.min.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.0/jquery.mask.js"></script>
		<script type="text/javascript">
		
		$(document).ready(function () { 
	        $(".horarioVisita").mask('99:99:99');
	    });
		</script>
<link href="../CSS/estilo3.css" rel="stylesheet" type="text/css">
		
</head>
<body>

<h1>Alterar Internação</h1>
<hr><br>
        <form action="alterarInternacao.jsp" method="get">
        <br><br><b>Indique o Id da Internação que sofrerá alteção: </b>
        <p>
        ID Internação: <input type="number" name="txtIdInternacao" min=1>
        </p>
        <p>
        <input type="submit" value="Pesquisar">
        </p>
        	<%
        	
        	String idI = (String) request.getParameter("txtIdInternacao");
        	String registro = "";
        	String horario = "";
        	String duracao = "";
        	if (idI == null || idI.isEmpty() || idI == "" ){
        		out.println("<p class='aviso'>Preencha os campos de identificação</p>");
        	}else{
    		try{
    			
    				cmdSQL = conexaoBD.prepareStatement("Select * From internacao WHERE idInternacao = "+ idI);
    								
    				rsSet = cmdSQL.executeQuery();
    								
    		if(rsSet.next()){
    									
    			
    									
    									
    			do{
    				registro = rsSet.getString("registroAlimentacao");
    				horario = rsSet.getString("horarioVisita");
    				duracao = rsSet.getString("duracaoInternacao");
    								
    											
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
        	<form action="../processamento/internacaocrud.jsp" method="GET">
        	<p>
   			ID Internação: <input name="txtIdInternacao" type="text" readonly value= "<%= idI %>" > 
   			</p>
        	
		    <p>
		    	Registro de Alimentação do Animal <input type="text" maxlength="150" name="txtRegistroAlimentacao" value= "<%=registro %>" />            
		    </p>
		    <p>
				Horario de Visita <input type="time" name="txtHorarioVisita" class="horarioVisita" placeholder="99:99:99" value= "<%=horario %>" />            
			</p>
			<p>
				Duração da Internação <input type="text" maxlength="200" name="txtDuracao" value="<%=duracao %>" />            
			</p>
			        
		    <br>
            <input type="submit" name="btnOperacao" value="Alterar"  />  
            <input type="submit" name="btnOperacao" value="Voltar"  />                       
            <hr>
        </form>

</body>
</html>