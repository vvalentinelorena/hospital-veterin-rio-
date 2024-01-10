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
	
	//excluir medicamntos_intrnacao referenciados
	

%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Excluir Medicamento</title>
        <link href="../CSS/estilo3.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <h1>Excluir Medicamento</h1>       
        <hr><br>
        <form action="excluirMedicamento.jsp" method="GET">
        
	         <br><br><b>Indique o Id do medicamento que deseja excluir: </b>
        <p>
        ID medicamento: <input type="number" name="txtIdMedicamento" min=1>
        </p>
        <p>
        <input type="submit" value="Pesquisar">
        </p>
        	<%
        	
        	String idM = request.getParameter("txtIdMedicamento");
        	String nome = "";
        	String tipo = "";
        	String instrumento = "";
        	if (idM == null || idM.isEmpty() || idM == "" ){
        		out.println("<p class='aviso'>Preencha os campos de identificação</p>");
        	}else{
    		try{
    			
    				cmdSQL = conexaoBD.prepareStatement("Select * From medicamento WHERE idMedicamento = " + idM);
    								
    				rsSet = cmdSQL.executeQuery();
    								
    		if(rsSet.next()){
    									
    			
    			
    									
    									
    			do{
    				nome = rsSet.getString("nome");
    				tipo = rsSet.getString("tipoMedicamento");
    				instrumento = rsSet.getString("instrumentoUso");
    								
    											
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
        <form action="../processamento/medicamentocrud.jsp" method="GET">
        	<p>
   			ID Medicamento: <input name="txtId" type="text" readonly value= "<%= idM %>" > 
   			</p>
         <p>
            Nome: <input type="text" maxlength="150" name="txtNome" readonly value= "<%=nome %>" />            
           	</p> 
            <p>
            Tipo de medicamento: <input type="text" maxlength="60" name="txtTipo"  readonly value = "<%=tipo %>" />            
           	</p> 
           	 <p>
            Instrumento de uso: <input type="text" maxlength="60" name="txtUso" readonly value = "<%=instrumento %>" />            
           	</p> 
       
             <hr>
             <h1 class="msgExcluir">Deseja realmente excluir os dados?</h1> 
             <h3 class="msgExcluir">Excluir essa medicação também excluirá os medicamentos de internação referentes à ela.</h3>
            
          	<div class="btnRes">
          	<input type="submit" name="btnOperacao" value="Excluir"  /> 
            <input type="submit" name="btnOperacao" value="Voltar"  />    
            </div> 
        </form>
                       
           
        	
    </body>
</html>
