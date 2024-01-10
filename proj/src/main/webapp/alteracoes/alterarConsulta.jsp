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
<title>Alterar - Consulta</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.maskedinput/1.4.1/jquery.maskedinput.min.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.0/jquery.mask.js"></script>

<link href="../CSS/estilo3.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
		
		$(document).ready(function () { 
	        $(".dataHora").mask('9999/99/99 99:99:99');
	    });
			
			
		</script>
		
</head>
<body>

<h1>Alterar Consulta</h1>
<hr><br>
        <form action="alterarConsulta.jsp">
        Indique o número da sala e data-hora da Consulta que sofrerá alteção: 
        <p>
        Número sala: <input type="number" name="txtSalaConsulta" min=1>
        </p>
        <p>
        Data hora (yyyy/mm/dd HH:mm:ss): <input type="datetime" name="txtDH" class="dataHora">
        </p>
        <p>
        <input type="submit" value="Pesquisar">
        </p>
        
        	<%
        	//exibindo consultas da clinica
        	
        	String idSala = (String) request.getParameter("txtSalaConsulta");
        	String dataHora = (String) request.getParameter("txtDH");
        	
        	String procedimento = "";
        	if (idSala == null || idSala.isEmpty() || idSala == "" || dataHora == null || dataHora.isEmpty() || dataHora == "" ){
        		out.println("<p class='aviso'>Preencha os campos de identificação</p>");
        	}else{
        		String[] splitespaco = dataHora.split(" ");
    			Integer hora, min, seg;
    			//String[] splitespaco = horarioTrabalho.split(" ");
    		
    			//numCadastro = Integer.parseInt(request.getParameter("txtNumCadastro"));
    			
    			if(dataHora.length() != 19){
    				out.println("<p class='aviso'>Horário Inválido: " + dataHora + "</p>");
    				//out.println(splithora1[0].length());
    				//out.println(splithora2[0].length());
    			}else{
    				//validando horario --> 24h/60min/60s
    				String[] splithora = splitespaco[1].split(":");
    				hora = Integer.parseInt(splithora[0]);
    				min = Integer.parseInt(splithora[1]);
    				seg = Integer.parseInt(splithora[2]);
    				
    				//validando data --> ano 1900 --- / mes 1 - 12 / dia 1 - 31 /
    				Integer dia, mes, ano;
    				String[] splitdata = splitespaco[0].split("/");
    				ano = Integer.parseInt(splitdata[0]);
    				mes = Integer.parseInt(splitdata[1]);
    				dia = Integer.parseInt(splitdata[2]);
    	
    				 if(hora > 23 || min > 59 || seg > 59){
    						out.println("<p class='aviso'>Horário Inválido: " + splitespaco[1] + "</p>");
    					}else if(ano < 1900 || mes < 1 || mes > 12 || dia < 1 || dia > 31){
    						out.println("<p class='aviso'>Data Inválida: " + splitespaco[0] + "</p>");
    						
    					}else if(mes == 2 && dia > 28){ //excessao pra feveireiro
    						out.println("<p class='aviso'>Data Inválida: " + splitespaco[0] + "</p>");
    					}
    					else{
        	
    		try{
   
    				cmdSQL = conexaoBD.prepareStatement("Select * From consulta WHERE numSala = '" + idSala + "' AND dataHora = '" + dataHora + "';");
					
    				//cmdSQL = conexaoBD.prepareStatement("SELECT * FROM consulta WHERE numSala = " + idSala + " AND dataHora = " + idDH);
    								
    				rsSet = cmdSQL.executeQuery();
    								
    		if(rsSet.next()){
				do{
    				
    				procedimento = (String) rsSet.getString("procedimento");						
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
    			}
        	}
        	
    		
    		
        	%>
        	
        	</form>
        	<form action="../processamento/consultacrud.jsp" method="GET">
        	<p>
   			Número da Sala: <input name="txtNumSala" type="text" readonly value= "<%= idSala %>" > 
   			</p>
   			<p>
   			Data e Hora: <input name="txtDataHora" class="dataHora" type="text" readonly value="<%= dataHora %>" > 
   			</p>
	       	<p>
    		Procedimento: <input type="text" maxlength="200" name="txtProcedimento" size=60 value= "<%= procedimento %>" />            
    		</p>
		    <br>
            <input type="submit" name="btnOperacao" value="Alterar"  />  
            <input type="submit" name="btnOperacao" value="Voltar"  />                       
            <hr>
        </form>

</body>
</html>