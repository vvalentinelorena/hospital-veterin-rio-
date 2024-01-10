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
	ResultSet rsVet = null;
	
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
<title>Alterar - veterinario (ainda nao funcionando)</title>

<link href="../CSS/estilo3.css" rel="stylesheet" type="text/css">

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.maskedinput/1.4.1/jquery.maskedinput.min.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.0/jquery.mask.js"></script>
		
		<script type="text/javascript">
		
		$(document).ready(function () { 
	        $(".HorarioAtendimento").mask('99h às 99h');
	    });
			
			
</script>
		
</head>
<body>

<h1>Alterar Veterinário</h1>
     
        <hr><br>
       <form action="alterarVeterinario.jsp">
       <br><br><b>Indique o CRMV do veterinario que sofrerá alteção: </b>
       <P>
       CRMV: <input type="number" min=1  name="txtIdVet">
       </p>
       <p>
       <input type="submit" value="Pesquisar">
       </p>
        
        	<%
        	
        	String crmv = (String) request.getParameter("txtIdVet");
        	String nome = "";
        	String senhaV = "";
        	String faculdade = "";
        	String horario = "";
     
        	
        	if (crmv == null || crmv.isEmpty() || crmv == "" ){
        		out.println("<p class='aviso'>Preencha os campos de identificação</p>");
        	}else{
    		try{
    			
    				cmdSQL = conexaoBD.prepareStatement("Select * From veterinario WHERE numCRMV = " + crmv);
    								
    				rsVet = cmdSQL.executeQuery();
    								
    		if(rsVet.next()){
    									
    			
    									
    									
    			do{
    				nome = rsVet.getString("nome");
    				senhaV = rsVet.getString("senha");
    				faculdade = rsVet.getString ("faculdade");
    				horario = rsVet.getString("horarioAtendimento");
    								
    											
    			}while(rsVet.next());	
    				
    				
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
        	 <form action="../processamento/veterinariocrud.jsp" method="GET">
        	<p>
   			CRMV: <input readonly id="idvet" name="txtCrmv" min=1 type="number" value= "<%= crmv %>" > 
   			</p>
            <p>
            Nome <input type="text" maxlength="100" name="txtNome"  value = "<%=nome %>"/>            
           	</p> 
           	 <p>
            Senha <input type="password" maxlength="50" name="txtSenha" value= "<%=senhaV %>" />            
           	</p> 
           	 <p>
            Faculdade <input type="text" maxlength="150" name="txtFaculdade"  value= "<%=faculdade %>"/>            
           	</p> 
           	 <p>
            Horario/Atendimento <input type="text" maxlength="45" name="txtHorarioAtendimento" class="HorarioAtendimento" value= "<%=horario %>" />            
           	</p>           
           
            <input type="submit" name="btnOperacao" value="Alterar"  />  
            <input type="submit" name="btnOperacao" value="Voltar"  />                       
            <hr>
        </form>

</body>
</html>