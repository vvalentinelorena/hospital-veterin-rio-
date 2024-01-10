<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@page import="java.util.concurrent.Delayed"%>
    
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
   
<html>
<head>
	<link href="./CSS/estilo3.css" rel="stylesheet" type="text/css">
</head>
<body>


<%
	//---------------------------------------
	// Conexão com o banco de dados
	//---------------------------------------
	
	String banco, usuario, senha;
	
	Connection conexaoBD = null;
	PreparedStatement cmdSQL = null;
	ResultSet rsS = null;
	ResultSet rsV = null;
	
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
	
	
	//---------------------------------------
		// Operações
    //---------------------------------------
	
	
	String operacao, emailS, senhaS, caS, crmvV, senhaV, caV;
	operacao = request.getParameter("btnOperacao");

	
	emailS = request.getParameter("emailSecretario");
	senhaS = request.getParameter("senhaSecretario");
	caS = request.getParameter("CASecretario");
	
	crmvV = request.getParameter("crmvVet");
	senhaV = request.getParameter("senhaVet");
	caV = request.getParameter("CAVet");
	
	
	//Verificação
	if(operacao.equals("Login Secretario")){
		
		if(emailS.isEmpty() || emailS==null || senhaS.isEmpty() || senhaS == null|| caS.isEmpty() || caS == null){
			out.println("<p class='aviso'>Preencha todos os campos</p>");
		}
		else{
			try{
				//SELECT * FROM `movies` WHERE `category_id` = 2 AND `year_released` = 2008;
				//"SELECT * FROM cantor WHERE idcantor=" + idCantor +";"
				//UPDATE cantor SET nome='" + nome + "', idade='" + idade + 
				cmdSQL = conexaoBD.prepareStatement("SELECT * FROM secretario WHERE email ='" + emailS 
				+ "' and senha ='" + senhaS + "';");
				
				rsS = cmdSQL.executeQuery();
				
				if(rsS.next() && caS.equals("GF%qR$@Ggd")){ //encontrou no banco + chave de acesso certa
					response.sendRedirect("pagSecretario.jsp?txtNomeS=" + rsS.getString("nome") + "'");
					
				}
				else{
					
					out.println("<p class='aviso'>Nenhuma informação encontrada!</p>");
				}
				
		}
		catch(Exception ex){
			out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
			return;
			}	
		}
	}
	
if(operacao.equals("Login Veterinario")){
		
		if(crmvV.isEmpty() || crmvV==null || senhaV.isEmpty() || senhaV == null|| caV.isEmpty() || caV == null){
			out.println("<p class='aviso'>Preencha todos os campos</p>");
		}
		else{
			try{
				//SELECT * FROM `movies` WHERE `category_id` = 2 AND `year_released` = 2008;
				//"SELECT * FROM cantor WHERE idcantor=" + idCantor +";"
				//UPDATE cantor SET nome='" + nome + "', idade='" + idade + 
				cmdSQL = conexaoBD.prepareStatement("SELECT * FROM veterinario WHERE numCRMV ='" + crmvV 
				+ "' and senha ='" + senhaV + "';");
				
				rsV = cmdSQL.executeQuery();
				
				if(rsV.next() && caV.equals("IS0!ceCPyq")){ //encontrou no banco + chave de acesso certa
					response.sendRedirect("pagVeterinario.jsp?txtNomeV=" + rsV.getString("nome") + "'");
					
					
				}
				else{
					
					out.println("<p class='aviso'>Nenhuma informação encontrada!</p>");
				}
				
		}
		catch(Exception ex){
			out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
			return;
			}	
		}
	}
	
%>

</body>
</html>
