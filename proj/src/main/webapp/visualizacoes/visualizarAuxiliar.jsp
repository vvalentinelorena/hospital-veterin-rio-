<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.Connection" %>   
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>      
    
<%

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
	<title>Visualizar - Auxiliares</title>
	<link href="../CSS/estilo3.css" rel="stylesheet" type="text/css">
	
</head>
<body>
	<h1>Visualizar Auxiliar</h1>
	<hr><br>
	
	<form action="visualizarAuxiliar.jsp" method="GET">
	Indique o Id do estudante auxiliar que deseja visualizar: 
        
        <p>
        Id Auxiliar: <input type="number" name="txtIdAuxiliar" min=1>
        </p>
        <p>
        <input type="submit" value="Pesquisar">
        </p>
        	<%
        	
        	String nomepreenche = "";
        	String faculpreenche = "";
        	String periodopreenche = "";
        	String horarioPreenche = "";
        	
        	String idAuxiliar = (String) request.getParameter("txtIdAuxiliar");
        	
        	if (idAuxiliar == null || idAuxiliar.isEmpty() || idAuxiliar == "" ){
        		out.println("<p class='aviso'>Preencha os campos de identificação</p>");
        	}else{
        	
    		try{
    			
    				cmdSQL = conexaoBD.prepareStatement("Select * From estudante_auxiliar WHERE numCadastro = " + idAuxiliar);
    								
    				rsSet = cmdSQL.executeQuery();
    								
    		if(rsSet.next()){					
    			do{
    				nomepreenche = (String) rsSet.getString("nome");
    				faculpreenche = (String) rsSet.getString("faculdade");
    				periodopreenche = (String) rsSet.getString("periodoFaculdade");
    				horarioPreenche = (String) rsSet.getString("horarioTrabalho");
    								
    											
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
        	
        	<p>
   			ID Auxiliar <input name="txtId" type="text" readonly value= "<%= idAuxiliar %>" > 
   			</p>
          <p>
            Nome <input readonly type="text" maxlength="100" name="txtNome"  value="<%= nomepreenche %>"/>            
           	</p> 
           	 <p>
            Faculdade <input readonly type="text" maxlength="50" name="txtFaculdade" value = "<%= faculpreenche %>" />            
           	</p> 
           	 <p>
            Período faculdade <input readonly type="text" maxlength="150" name="txtPeriodo" value = "<%= periodopreenche %>"/>          
           	</p> 
           	 <p>
            Horario de trabalho <input readonly type="text" maxlength="45" name="txtHorarioTrabalho" class="HorarioTrabalho" value="<%=horarioPreenche %>" />            
           	</p>       
           	 <hr>
			
	<form action="../pagSecretario.jsp" method="get">
		<input type="submit" value="Voltar">
	</form>
</body>
</html>







