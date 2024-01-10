<%@page import="java.util.concurrent.Delayed"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<html>
<head>
<link href="../CSS/estilo3.css" rel="stylesheet" type="text/css">
</head>
<body>

    
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
	
//operacoes
	String operacao;
	String strIdi, strIdm;
	String nomeM = "", tipoM = "" , instrumentoM = "";
	Integer idI = 0, idM = 0;
	boolean achouI = false, achouM = false;
	operacao = request.getParameter("btnOperacao");
	
	if(operacao.equals("Inserir")){
		strIdi = request.getParameter("txtIdInternacao");
		strIdm = request.getParameter("txtIdMedicamento");
		
		if(strIdi == null ||strIdi.isEmpty() || strIdi == "" || strIdm == null || strIdm.isEmpty() || strIdm == ""){
			out.println("<p class='aviso'>Preencha todos os campos</p>");
			out.println("<form action='../cadastros/cadastroMedicamentoInternacao.jsp' method='get'>");
			out.println("<input type='submit' value='Voltar'>");
			out.println("</form>");
			
		}else{
			idI = Integer.parseInt(request.getParameter("txtIdInternacao"));
			idM = Integer.parseInt(request.getParameter("txtIdMedicamento"));
			try{
				cmdSQL = conexaoBD.prepareStatement("SELECT * FROM internacao WHERE idInternacao = " + idI);
				
				rsSet = cmdSQL.executeQuery();
				if(rsSet.next()){ //existe o id digitado pra animal
					achouI = true;
					
				}else{
					out.println("<p class='aviso'>O id da internação que foi digitado não está cadastrado no sistema</p>");
				}
			}
		
				catch(Exception ex){
					out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
					return;
				}	
			
		
			
			try{
				cmdSQL = conexaoBD.prepareStatement("SELECT * FROM medicamento WHERE idMedicamento = " + idM);
				
				rsSet = cmdSQL.executeQuery();
				if(rsSet.next()){ //existe o id digitado pra animal
					achouM = true;
					nomeM = rsSet.getString("nome");
					tipoM = rsSet.getString("tipoMedicamento");
					instrumentoM = rsSet.getString("instrumentoUso");
					
				}else{
					out.println("<p class='aviso'>O id do medicamento que foi digitado não está cadastrado no sistema</p>");
				}
			}
				catch(Exception ex){
					out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
					return;
				}	
				
			}
		
		if(achouI == true && achouM == true){
		
		try{
			
			cmdSQL = conexaoBD.prepareStatement("SELECT * FROM  medicamentos_internacao WHERE idInternacao = " + idI + " AND idMedicamento =  " + idM);
			
			rsSet = cmdSQL.executeQuery();
			
			if(rsSet.next()){ //ja existe
				out.println("<p class='aviso'>Esse medicamento já está cadastrado para essa internação</p>");
				
			}
			else{ //nao existe - vai inserir no bd
				try{
					
					cmdSQL = conexaoBD.prepareStatement("Insert into medicamentos_internacao(idInternacao, idMedicamento, nome, tipoMedicamento, "
							+"instrumentoUso) values('" + idI + "', '" + idM + "', '" + nomeM + "', '" + tipoM + "', '" + instrumentoM + "')");
					cmdSQL.executeUpdate();
					
					out.println("<h3>Inserção efetuada com sucesso!</h3>");
					out.println("<form action='../pagVeterinario.jsp' method='get'>");
					out.println("<input type='submit' value='Voltar'>");
					out.println("</form>");
					
				}
				catch(Exception ex){
					out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
					return;
				}	
				
			}
			
			
	}
		catch(Exception ex){
			out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
			return;
	}
			
}
	}
	
	else if(operacao.equals("Excluir")){
		strIdi = request.getParameter("txtIdInternacao");
		strIdm = request.getParameter("txtIdMedicamento");
		nomeM = request.getParameter("txtNomeMedicamento");
		tipoM = request.getParameter("txtTipo");
		instrumentoM  = request.getParameter("txtUso");
		if(strIdi == null ||strIdi.isEmpty() || strIdi == "" || strIdm == null ||strIdm.isEmpty() || strIdm == "" || nomeM.isEmpty() || nomeM == null || nomeM == "" ||
				tipoM.isEmpty() || tipoM == null || tipoM == ""  || instrumentoM.isEmpty() || 
						instrumentoM == null || instrumentoM == ""){
			out.println("<p class='aviso'>Preencha todos os campos</p>");
			out.println("<form action='../exclusoes/excluirMedicamentoInternacao.jsp' method='get'>");
			out.println("<input type='submit' value='Voltar'>");
			out.println("</form>");
			
		}else{
			idI = Integer.parseInt(request.getParameter("txtIdInternacao"));
			idM = Integer.parseInt(request.getParameter("txtIdMedicamento"));
			try{
				
				cmdSQL = conexaoBD.prepareStatement("SELECT * FROM  medicamentos_internacao WHERE idInternacao = " + idI + " AND idMedicamento =  " + idM);
				
				rsSet = cmdSQL.executeQuery();
				
				if(!rsSet.next()){ 
					out.println("<p class='aviso'>Essa combinação de ID não está cadastrada no sistema</p>");
					
				}
				else{ 
					try{
						
						cmdSQL = conexaoBD.prepareStatement("DELETE FROM medicamentos_internacao WHERE idInternacao = " + idI + " AND idMedicamento =  " + idM + ";");
						cmdSQL.executeUpdate();
						
						out.println("<h3>Exclusão efetuada com sucesso!</h3>");
						out.println("<form action='../pagVeterinario.jsp' method='get'>");
						out.println("<input type='submit' value='Voltar'>");
						out.println("</form>");
						
					}
					catch(Exception ex){
						out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
						return;
					}	
					
				}
				
				
		}
			catch(Exception ex){
				out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
				return;
		}
				
	}
}
	else if(operacao.equals("Visualizar")){
		response.sendRedirect("../visualizacoes/visualizarMedicamentoInternacao.jsp");
	}
	
	else if(operacao.equals("Voltar")){
		response.sendRedirect("../pagVeterinario.jsp");
	}
	
	
%>

</body>
</html>

