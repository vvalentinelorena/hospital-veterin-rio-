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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Visualizar - Alergias de Animais </title>
<link href="../CSS/estilo3.css" rel="stylesheet" type="text/css">
</head>
<body>
	<h1>Visualizar Alergias</h1>
	<hr><br>
	
	 <form action="visualizarAlergias.jsp"  method="GET">
        
        Indique o Id do animal e do medicamento para visualizae a alergia: 
        <p>
        Id animal: <input type="number" name="txtIdAnimal" min=1>
        </p>
         <p>
        Id Medicamento: <input type="number" name="txtIdMedicamento" min=1>
        </p>
        <p>
    	<input type='submit' value='Pesquisar'>
    	<p>
        
        	<%
        	
			String nivelalergia = "";
        	
			Integer idanimal = 0, idmed = 0;
    		String idanimalstr = (String) request.getParameter("txtIdAnimal");
    		String idmedstr = (String) request.getParameter("txtIdMedicamento");
    		
    		if (idanimalstr == null || idanimalstr.equals("null") ||idmedstr.equals("null") || idmedstr == null || idanimalstr.isEmpty() || idmedstr.isEmpty() || idanimalstr == "" || idmedstr == ""){
        		out.println("<p class='aviso'>Preencha os campos de identificação</p>");
        	}else{
        		idanimal = Integer.parseInt(request.getParameter("txtIdAnimal"));
        		idmed = Integer.parseInt(request.getParameter("txtIdMedicamento"));
        		try{
        			
    				cmdSQL = conexaoBD.prepareStatement("Select * From animal_alergias WHERE idAnimal = " + idanimal + " AND idMedicamento = " + idmed);
    								
    				rsSet = cmdSQL.executeQuery();
    								
    		if(rsSet.next()){
    			//achou
    			do{
    				nivelalergia = (String) rsSet.getString("nivelAlergia");
    				
    											
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
    
         <p>
   				ID Animal <input name="idA" type="text" value= "<%= idanimal %>" readonly > 
   			</p>
   			<p>
   				ID Medicamento<input name="idM" type="text" value="<%= idmed %>" readonly  > 
   			</p>
        	
	        <p>
			Nível de alergia: <input readonly type="text" maxlength="10" name="txtNivelAlergia" value = "<%= nivelalergia %>" />            
			</p> 
        </form>
        
        <form action="../pagVeterinario.jsp" method="GET">
		<p><br>
		<input type="submit" name="btnOperacao" value="Voltar" />
		</p>
	</form>

	
	

</body>
</html>