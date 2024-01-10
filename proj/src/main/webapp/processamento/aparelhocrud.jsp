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
	ResultSet rsAP = null;
	
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
	Integer id = 0;
	String uso, nomeAp, idstr;
	
	
	//---------------------------------------
	// Operações de SQL
	//---------------------------------------
	
	String operacao;
	
	operacao = request.getParameter("btnOperacao");
	//media = Float.parseFloat(request.getParameter("txtMedia").toString());
	

	
		if(operacao.equals("Inserir")){
			//id = Integer.parseInt(request.getParameter("txtId").toString());
			idstr = request.getParameter("txtId");
			nomeAp = request.getParameter("txtNome");
			uso = request.getParameter("txtUso");
			if(idstr == null || idstr.equals("null") || idstr == "" ||nomeAp.isEmpty() || nomeAp == null || uso.isEmpty() || uso == null){
				out.println("<p class='aviso'>Preencha todos os campos</p>");
				out.println("<form action='../cadastros/cadastroAparelho.jsp' method='get'>");
				out.println("<input type='submit' value='Voltar'>");
				out.println("</form>");
			}else{
				id = Integer.parseInt(request.getParameter("txtId").toString());
			
			
			try{
				//Testa se o crmv indicado pra inserção ja existe no banco
				cmdSQL = conexaoBD.prepareStatement("SELECT * FROM aparelho WHERE idAparelho ='" + id + "';");
				
				rsAP = cmdSQL.executeQuery();
				
				if(rsAP.next()){ //ja existe
					out.println("<p class='aviso'>Já existe um aparelho cadastrado com esse id</p>");
					
				}
				else{ //nao existe - vai inserir no bd
					try{
						
						
						//cmdSQL = conexaoBD.prepareStatement("Insert into aluno(nome, media) values('Maria', 9.5)");
						cmdSQL = conexaoBD.prepareStatement("Insert into aparelho(idAparelho, nome, objetivoUso) values('" + id + "', '" + nomeAp +"', '" + uso + "')");
								
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
			nomeAp = request.getParameter("txtNome");
			uso = request.getParameter("txtUso");
			if(idstr == null || idstr.equals("null") || idstr == "" || nomeAp.isEmpty() || nomeAp == null || uso.isEmpty() || uso == null){
				out.println("<p class='aviso'>Preencha todos os campos</p>");
				out.println("<form action='../alteracoes/alterarAparelho.jsp' method='get'>");
				out.println("<input type='submit' value='Voltar'>");
				out.println("</form>");
			}else{
				id = Integer.parseInt(request.getParameter("txtId").toString());
			
			
			try{
				//Testa se o crmv indicado pra inserção ja existe no banco
				cmdSQL = conexaoBD.prepareStatement("SELECT * FROM aparelho WHERE idAparelho ='" + id + "';");
				
				rsAP = cmdSQL.executeQuery();
				
				if(!rsAP.next()){ //ja existe
					out.println("<p class='aviso'>Não existe um aparelho cadastrado com o ID informado</p>");
					
				}
				else{ //nao existe - vai inserir no bd
					try{
						
						
						//"UPDATE animal SET nome='" + nome + "', idade='" + idade + "', raca='" + raca
						//+ "', especie='" + especie + "', numCarteiraVac='" + numCV + "' Where numCadastro = " + idAnimal + ";"
						cmdSQL = conexaoBD.prepareStatement("UPDATE aparelho SET nome='" + nomeAp + "', objetivoUso='" + uso + "' WHERE idAparelho = " + id + ";");
								
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
			nomeAp = request.getParameter("txtNome");
			uso = request.getParameter("txtUso");
		
			if(idstr == null || idstr.equals("null") || idstr == "" ||nomeAp.isEmpty() || nomeAp == null || uso.isEmpty() || uso == null){
				out.println("<p class='aviso'>Preencha todos os campos</p>");
				out.println("<form action='../exclusoes/excluirAparelho.jsp' method='get'>");
				out.println("<input type='submit' value='Voltar'>");
				out.println("</form>");
			}else{
				
			id = Integer.parseInt(request.getParameter("txtId"));
			try{
				
				cmdSQL = conexaoBD.prepareStatement("SELECT * FROM aparelho WHERE idAparelho=" + id +";");			
				rsAP = cmdSQL.executeQuery();
				
				if(rsAP.next()){
					
				
					cmdSQL = conexaoBD.prepareStatement("DELETE FROM aparelho WHERE idAparelho = " + id);	
					cmdSQL.executeUpdate();
					
					out.println("<h3>Exclusão efetuada com sucesso!</h3>");
					out.println("<form action='../pagSecretario.jsp' method='get'>");
					out.println("<input type='submit' value='Voltar'>");
					out.println("</form>");
					
				}
				else{
					out.println("<p class='aviso'>Esse Id de aparelho não está cadastrado no sistema</p>");
				}
				
			}
			catch(Exception ex){
				out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
				return;
			}	
		}
		}
			
			
	
		else if(operacao.equals("Visualizar")){
		response.sendRedirect("../visualizacoes/visualizarAparelho.jsp");
	}
	
		else if(operacao.equals("Voltar")){
			response.sendRedirect("../pagSecretario.jsp");
		}

%>

 </body>
 </html>