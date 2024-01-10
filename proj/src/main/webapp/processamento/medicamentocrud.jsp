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
	ResultSet rsMed = null;
	
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
	// Dados da tabela
	//---------------------------------------
	Integer id;
	String tipo, uso, nomeM, idstr;
	
	
	//---------------------------------------
	// Operações de SQL
	//---------------------------------------
	
	String operacao;
	
	operacao = request.getParameter("btnOperacao");
	//media = Float.parseFloat(request.getParameter("txtMedia").toString());
	//id = Integer.parseInt(request.getParameter("txtId").toString());
	
	
	
	
	
	
		if(operacao.equals("Inserir")){
			idstr = request.getParameter("txtId");
			nomeM = request.getParameter("txtNome");
			tipo = request.getParameter("txtTipo");
			uso = request.getParameter("txtUso");
			if(idstr == null ||idstr.isEmpty() || idstr == "" || nomeM.isEmpty() || nomeM == null || nomeM == "" ||
					tipo.isEmpty() || tipo == null || tipo == ""  || uso.isEmpty() || 
					uso == null || uso == ""){
				out.println("<p class='aviso'>Preencha todos os campos</p>");
				out.println("<form action='../cadastros/cadastroMedicamento.jsp' method='get'>");
				out.println("<input type='submit' value='Voltar'>");
				out.println("</form>");
				
			}else{
				id = Integer.parseInt(request.getParameter("txtId").toString());
				try{
					//Testa se o crmv indicado pra inserção ja existe no banco
					cmdSQL = conexaoBD.prepareStatement("SELECT * FROM medicamento WHERE idMedicamento ='" + id + "';");
					
					rsMed = cmdSQL.executeQuery();
					
					if(rsMed.next()){ //ja existe
						out.println("<p class='aviso'>Já existe um medicamento cadastrado com esse numero</p>");
						
					}
					else{ //nao existe - vai inserir no bd
						try{
							
							
							//cmdSQL = conexaoBD.prepareStatement("Insert into aluno(nome, media) values('Maria', 9.5)");
							cmdSQL = conexaoBD.prepareStatement("Insert into medicamento(idMedicamento, nome, tipoMedicamento, " + 
									"instrumentoUso) values('" + id + "', '" + nomeM +"', '" + tipo + "', '" + uso + "')");
									
							cmdSQL.executeUpdate();
							
							out.println("<h3>Inserção efetuada com sucesso!</h3>");
							out.println("<form action='../pagSecretario.jsp' method='get'>");
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
			idstr = request.getParameter("txtId");
			nomeM = request.getParameter("txtNome");
			tipo = request.getParameter("txtTipo");
			uso = request.getParameter("txtUso");
			if(idstr == null ||idstr.isEmpty() || idstr == "" || nomeM.isEmpty() || nomeM == null || nomeM == "" ||
					tipo.isEmpty() || tipo == null || tipo == ""  || uso.isEmpty() || 
					uso == null || uso == ""){
				out.println("<p class='aviso'>Preencha todos os campos</p>");
				out.println("<form action='../alteracoes/alterarMedicamento.jsp' method='get'>");
				out.println("<input type='submit' value='Voltar'>");
				out.println("</form>");
				
			}else{
				id = Integer.parseInt(request.getParameter("txtId"));
				try{
					//Testa se o crmv indicado pra inserção ja existe no banco
					cmdSQL = conexaoBD.prepareStatement("SELECT * FROM medicamento WHERE idMedicamento ='" + id + "';");
					
					rsMed = cmdSQL.executeQuery();
					
					if(!rsMed.next()){ 
						out.println("<p class='aviso'>Não existe um medicamento cadastrado com esse numero</p>");
						
					}
					else{ //nao existe - vai inserir no bd
						try{
							
							
							
							cmdSQL = conexaoBD.prepareStatement("UPDATE medicamento SET nome='" + nomeM + "', tipoMedicamento='" + tipo
							+ "', instrumentoUso='" + uso + "' WHERE idMedicamento = " + id + ";");
							cmdSQL.executeUpdate();
							cmdSQL = conexaoBD.prepareStatement("UPDATE medicamentos_internacao SET nome='" + nomeM + "', tipoMedicamento='" + tipo
									+ "', instrumentoUso='" + uso + "' WHERE idMedicamento = " + id + ";");
							cmdSQL.executeUpdate();
							
							
							//cmdSQL = conexaoBD.prepareStatement("Insert into aluno(nome, media) values('Maria', 9.5)");
							
									
							cmdSQL.executeUpdate();
							
							out.println("<h3>Alteração efetuada com sucesso!</h3>");
							out.println("<form action='../pagSecretario.jsp' method='get'>");
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
			idstr = request.getParameter("txtId");
			nomeM = request.getParameter("txtNome");
			tipo = request.getParameter("txtTipo");
			uso = request.getParameter("txtUso");
			if(idstr == null ||idstr.isEmpty() || idstr == "" || nomeM.isEmpty() || nomeM == null || nomeM == "" ||
					tipo.isEmpty() || tipo == null || tipo == ""  || uso.isEmpty() || 
					uso == null || uso == ""){
				out.println("<p class='aviso'>Preencha todos os campos</p>");
				out.println("<form action='../exclusoes/excluirMedicamento.jsp' method='get'>");
				out.println("<input type='submit' value='Voltar'>");
				out.println("</form>");
				
			}else{
				id = Integer.parseInt(request.getParameter("txtId"));
				try{
					//Testa se o crmv indicado pra inserção ja existe no banco
					cmdSQL = conexaoBD.prepareStatement("SELECT * FROM medicamento WHERE idMedicamento ='" + id + "';");
					
					rsMed = cmdSQL.executeQuery();
					
					if(!rsMed.next()){ 
						out.println("<p class='aviso'>Não existe um medicamento cadastrado com esse numero</p>");
						
					}
					else{ //nao existe - vai inserir no bd
						try{
							
							cmdSQL = conexaoBD.prepareStatement("DELETE FROM medicamentos_internacao WHERE idMedicamento = " + id + ";");
							cmdSQL.executeUpdate();
							cmdSQL = conexaoBD.prepareStatement("DELETE FROM medicamento WHERE idMedicamento = " + id + ";");
							
							cmdSQL.executeUpdate();
							
							
							//cmdSQL = conexaoBD.prepareStatement("Insert into aluno(nome, media) values('Maria', 9.5)");
							
									
							cmdSQL.executeUpdate();
							
							out.println("<h3>Exclusão efetuada com sucesso!</h3>");
							out.println("<form action='../pagSecretario.jsp' method='get'>");
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
			response.sendRedirect("../visualizacoes/visualizarMedicamento.jsp");
		}
			
			else if(operacao.equals("Voltar")){
				response.sendRedirect("../pagSecretario.jsp");
			}
	

%>


</body>
</html>