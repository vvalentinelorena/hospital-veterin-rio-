<%@page import="java.sql.Time"%>
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
Integer idAnimal = 0, idCliente = 0, idInternacao = 0;
String registroA, horarioVisita, duracao, strIA, strIC, strII;
boolean achouA = false, achouC = false;
	
		operacao = request.getParameter("btnOperacao");
		if(operacao.equals("Inserir")){
			strIA = request.getParameter("txtIdAnimal");
			strII = request.getParameter("txtIdInternacao");
			registroA =  request.getParameter("txtRegistroAlimentacao");
			horarioVisita =  request.getParameter("txtHorarioVisita");
			duracao =  request.getParameter("txtDuracao");
			if(strIA == null || strIA.isEmpty() || strIA == "" ||
				strII == null || strII.isEmpty() || strII == "" || registroA == null || registroA.isEmpty() || registroA == "" ||
				horarioVisita == null || horarioVisita.isEmpty() || horarioVisita == "" || duracao == null || 
				duracao.isEmpty() || duracao == ""){
				out.println("<p class='aviso'>Preencha todos os campos</p>");
				out.println("<form action='../cadastros/cadastroInternacao.jsp' method='get'>");
				out.println("<input type='submit' value='Voltar'>");
				out.println("</form>");
			}else{
				idInternacao = Integer.parseInt(request.getParameter("txtIdInternacao"));
				idAnimal = Integer.parseInt(request.getParameter("txtIdAnimal"));
				idCliente = Integer.parseInt(request.getParameter("txtIdCliente"));
				try{
					cmdSQL = conexaoBD.prepareStatement("SELECT * FROM animal WHERE numCadastro = " + idAnimal);
					
					rsSet = cmdSQL.executeQuery();
					if(rsSet.next()){ //existe o id digitado pra animal
						achouA = true;
						
					}else{
						out.println("<p class='aviso'>O id do animal que foi digitado não está cadastrado no sistema</p>");
					}
				}
					catch(Exception ex){
						out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
						return;
					}	
				
				try{
					cmdSQL = conexaoBD.prepareStatement("SELECT * FROM cliente WHERE numCadastro = " + idCliente);
					
					rsSet = cmdSQL.executeQuery();
					if(rsSet.next()){ //existe o id digitado pra animal
						achouC = true;
						
					}else{
						out.println("<p class='aviso'>O id do cliente correspondente não está cadastrado no sistema</p>");
					}
				}
					catch(Exception ex){
						out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
						return;
					}	
					
				}
			
			if(achouA == true && achouC == true){
				try{
					
					cmdSQL = conexaoBD.prepareStatement("SELECT * FROM internacao WHERE idInternacao = " + idInternacao);
					
					rsSet = cmdSQL.executeQuery();
					
					if(rsSet.next()){ //ja existe
						out.println("<p class='aviso'>Essa internação já está cadastrada no sistema</p>");
						out.println("<form action='../cadastros/cadastroInternacao.jsp' method='get'>");
						out.println("<input type='submit' value='Voltar'>");
						out.println("</form>");
						
					}
					else{ //nao existe - vai inserir no bd
						try{
							
							
							//cmdSQL = conexaoBD.prepareStatement("Insert into aluno(nome, media) values('Maria', 9.5)");
							cmdSQL = conexaoBD.prepareStatement("Insert into internacao(idInternacao, numCadastroAnimal, numCadastroDono, registroAlimentacao, horarioVisita, "
								+"duracaoInternacao) values('" + idInternacao + "', '" + idAnimal + "', '" + idCliente + "', '" + registroA + "', '" + horarioVisita + "', '" + duracao + "')");
	
									
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
		
		else if(operacao.equals("Alterar")){
			strII = request.getParameter("txtIdInternacao");
			registroA =  request.getParameter("txtRegistroAlimentacao");
			horarioVisita =  request.getParameter("txtHorarioVisita");
			duracao =  request.getParameter("txtDuracao");
			if(strII == null || strII.isEmpty() || strII == "" || strII.equals("null") || registroA == null || registroA.isEmpty() || registroA == "" ||
				registroA.equals("null") || horarioVisita.equals("null") || duracao.equals("null") || horarioVisita == null || horarioVisita.isEmpty() || horarioVisita == "" || duracao == null || 
				duracao.isEmpty() || duracao == ""){
				out.println("<p class='aviso'>Preencha todos os campos</p>");
				out.println("<form action='../alteracoes/alterarInternacao.jsp' method='get'>");
				out.println("<input type='submit' value='Voltar'>");
				out.println("</form>");
			}else{
				idInternacao = Integer.parseInt(request.getParameter("txtIdInternacao"));
				try{
					
					cmdSQL = conexaoBD.prepareStatement("SELECT * FROM internacao WHERE idInternacao = " + idInternacao);
					
					rsSet = cmdSQL.executeQuery();
					
					if(!rsSet.next()){ //
						out.println("<p class='aviso'>Essa internação não está cadastrada no sistema</p>");
						out.println("<form action='../alteracoes/alterarInternacao.jsp' method='get'>");
						out.println("<input type='submit' value='Voltar'>");
						out.println("</form>");
						
					}
					else{ 
						try{
							
							cmdSQL = conexaoBD.prepareStatement("UPDATE internacao SET registroAlimentacao='" + registroA + "', horarioVisita='" + horarioVisita + "', duracaoInternacao='" + duracao + "' WHERE idInternacao = " + idInternacao + ";");	
							cmdSQL.executeUpdate();
							
							out.println("<h3>Alteração efetuada com sucesso!</h3>");
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
			strII = request.getParameter("txtIdInternacao");
			registroA =  request.getParameter("txtRegistroAlimentacao");
			horarioVisita =  request.getParameter("txtHorarioVisita");
			duracao =  request.getParameter("txtDuracao");
			if(strII == null || strII.isEmpty() || strII == "" || strII.equals("null") || registroA == null || registroA.isEmpty() || registroA == "" ||
				registroA.equals("null") || horarioVisita.equals("null") || duracao.equals("null") || horarioVisita == null || horarioVisita.isEmpty() || horarioVisita == "" || duracao == null || 
				duracao.isEmpty() || duracao == ""){
				out.println("<p class='aviso'>Preencha todos os campos</p>");
				out.println("<form action='../exclusoes/excluirInternacao.jsp' method='get'>");
				out.println("<input type='submit' value='Voltar'>");
				out.println("</form>");
			}else{
				idInternacao = Integer.parseInt(request.getParameter("txtIdInternacao"));
				try{
					
					cmdSQL = conexaoBD.prepareStatement("SELECT * FROM internacao WHERE idInternacao = " + idInternacao);
					
					rsSet = cmdSQL.executeQuery();
					
					if(!rsSet.next()){ //
						out.println("<p class='aviso'>Essa internação não está cadastrada no sistema</p>");
						out.println("<form action='../exclusoes/excluirInternacao.jsp' method='get'>");
						out.println("<input type='submit' value='Voltar'>");
						out.println("</form>");
						
					}
					else{ 
						try{
							cmdSQL = conexaoBD.prepareStatement("DELETE FROM medicamentos_internacao WHERE idInternacao = " + idInternacao + ";");
							cmdSQL.executeUpdate();
							cmdSQL = conexaoBD.prepareStatement("DELETE FROM internacao WHERE idInternacao = " + idInternacao + ";");	
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
			response.sendRedirect("../visualizacoes/visualizarInternacao.jsp");
		}
		
		else if(operacao.equals("Voltar")){
			response.sendRedirect("../pagVeterinario.jsp");
		}
			
		
			
			
		
%>


</body>
</html>
