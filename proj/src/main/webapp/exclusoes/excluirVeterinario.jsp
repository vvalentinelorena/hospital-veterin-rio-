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
	
	
//excluir consultas rfereciadas
%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Excluir Veterinário</title>
      <link href="../CSS/estilo3.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <h1>Excluir Veterinário</h1>       
        <hr><br>
       <form action="excluirVeterinario.jsp">
       <br><br><b>Indique o CRMV do veterinario que deseja excluir: </b>
       <P>
       CRMV: <input type="number" min=1 name="txtIdVet">
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
   			CRMV: <input readonly id="idvet" name="txtCrmv" type="number" value= "<%= crmv %>" > 
   			</p>
            <p>
            Nome <input type="text" readonly maxlength="100" name="txtNome"  value = "<%=nome %>"/>            
           	</p> 
           	 <p>
            Senha <input type="password" readonly maxlength="50" name="txtSenha" value= "<%=senhaV %>" />            
           	</p> 
           	 <p>
            Faculdade <input type="text" readonly maxlength="150" name="txtFaculdade"  value= "<%=faculdade %>"/>            
           	</p> 
           	 <p>
            Horario/Atendimento <input type="text" readonly maxlength="45" name="txtHorarioAtendimento" value= "<%=horario %>" />            
           	</p>           
             <hr>
             <h1 class="msgExcluir">Deseja realmente excluir os dados?</h1> 
             <h3 class="msgExcluir">Excluir esse veterinário também excluirá as consultas referentes a ele.</h3>
            
          	<div class="btnRes">
          	<input type="submit" name="btnOperacao" value="Excluir"  /> 
            <input type="submit" name="btnOperacao" value="Voltar"  />    
            </div> 
        </form>
        
        
    </body>
</html>
