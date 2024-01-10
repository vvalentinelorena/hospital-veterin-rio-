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
<title>Visualizar - Medicamento(s) Internação </title>
<link href="../CSS/estilo3.css" rel="stylesheet" type="text/css">
</head>
<body>
	<h1>Visualizar Medicamento(s) de Internação</h1>
	<hr><br>
	
	<form action="visualizarMedicamentoInternacao.jsp" method="GET">
		
		<p>
	Indique o ID da internação: <input type="number" name="idI" min=1>
	</p>
	<p>
	Indique o ID do medicamento: <input type="number" name="idM" min=1>
	</p>
	<p>
	<input type="submit" value="Pesquisar">
	</p>
<%

			String nomeM = "", tipo="", instrumento="";
    		String idI = (String) request.getParameter("idI");
    		String idM = (String) request.getParameter("idM");
    		
    		if (idI == null || idM == null || idI.isEmpty() || idM.isEmpty() || idI == "" || idM == ""){
        		out.println("<p class='aviso'>Preencha os campos de identificação</p>");
        	}else{
        		
					try{
						cmdSQL = conexaoBD.prepareStatement("Select * From medicamentos_internacao WHERE idMedicamento = '" + idM + "' AND idInternacao = '" + idI + "';");

    								
    				rsSet = cmdSQL.executeQuery();
 
    		if(rsSet.next()){
    			//achou
    			do{
    				
    				nomeM = rsSet.getString("nome");
    				tipo = rsSet.getString("tipoMedicamento");
    				instrumento = rsSet.getString("instrumentoUso");
    											
    			}while(rsSet.next());	
    				
    				//pega os dsdos
    			}
    		
    		
    		else{
    			
    			out.println("<p class='aviso'>Nenhum dado foi encontrado por essa combinação de ID</p>");
    			
    			}
    								
    		}
    		catch(Exception ex){
    			out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
    			return;
    		}
        	}
    %>
  
        <p>
		Número Internação: <input readonly type="text" name="txtIdInternacao" value= "<%= idI %>" >      
		</p> 
		<p>
		Número Medicamento: <input readonly type="text" name="txtIdMedicamento" value= "<%= idM %>" >   
		</p>
		<p>
		<p>
		Nome do medicamento: <input readonly type="text" name="txtNomeMedicamento" value= "<%= nomeM %>" >   
		</p>
		<p>
		Tipo: <input readonly type="text" name="txtTipo" value= "<%= tipo %>" >   
		</p>
		<p>
		Instrumento: <input readonly type="text" name="txtUso" value= "<%= instrumento %>" >   
		</p>
		
	
		
	</form>
	
	<form action="../pagVeterinario.jsp" method="get">
			<input type="submit" name="btnOperacao" value="Voltar" />
	    </form>
	
	
	

</body>
</html>