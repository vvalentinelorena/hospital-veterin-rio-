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
	
	
	//---------------------------------------
	// Dados da tabela
	//---------------------------------------
	
	String crmvVet, nomeV, senhaV, faculdade, horarioAtendimento, numCadastrostr;
	Integer hora1 = 0, hora2 = 0;
	
	
	//---------------------------------------
	// Operações de SQL
	//---------------------------------------
	
	String operacao;
	
	operacao = request.getParameter("btnOperacao");
	
	
	//validando horario --> 24h/60min/60s
			//String[] splitespaco = horarioAtendimento.split(" ");
			//String[] splithora1 = splitespaco[0].split("h");
			//String[] splithora2 = splitespaco[2].split("h");
			//Integer hora1, hora2;
			
			//hora1 = Integer.parseInt(splithora1[0]);
			//hora2 = Integer.parseInt(splithora2[0]);
			
			
		
	
	
	if(operacao.equals("Inserir")){
			//numCadastro = Integer.parseInt(request.getParameter("txtNumCadastro"));
		crmvVet = request.getParameter("txtCrmv");
		nomeV = request.getParameter("txtNome");
		senhaV = request.getParameter("txtSenha");
		faculdade = request.getParameter("txtFaculdade");
		horarioAtendimento = request.getParameter("txtHorarioAtendimento");
				
			if(crmvVet == null || crmvVet.isEmpty() || crmvVet == ""|| nomeV.isEmpty() || nomeV == null || faculdade.isEmpty() || 
					faculdade == null || senhaV.isEmpty() || senhaV == null || horarioAtendimento.isEmpty() ||
							horarioAtendimento == null || horarioAtendimento == "" || nomeV == "" || senhaV == ""
							|| faculdade == "" || crmvVet=="" ){
				out.println("<p class='aviso'>Preencha todos os campos</p>");
				out.println("<form action='../cadastros/cadastroVeterinario.jsp' method='get'>");
				out.println("<input type='submit' value='Voltar'>");
				out.println("</form>");
			}
			else{
				
				String[] splitespaco = horarioAtendimento.split(" ");
				//out.println("tamho: " +horarioTrabalho.length());
				
				//out.println(hora1);
				//out.println(hora2);
				//
				if(horarioAtendimento.length() != 10){
					out.println("<p class='aviso'>Horário Inválido: " + horarioAtendimento + "</p>");
					//out.println(splithora1[0].length());
					//out.println(splithora2[0].length());
				}else{
					//validando horario --> 24h/60min/60s
					String[] splithora1 = splitespaco[0].split("h");
					String[] splithora2 = splitespaco[2].split("h");
					
					hora1 = Integer.parseInt(splithora1[0]);
					hora2 = Integer.parseInt(splithora2[0]);
					if(hora1 > 23 || hora2 > 23 || hora1 == hora2){
						out.println("<p class='aviso'>Horário Inválido: " + horarioAtendimento + "</p>");
					}else{
					
					try{
						//Testa se o crmv indicado pra inserção ja existe no banco
						cmdSQL = conexaoBD.prepareStatement("SELECT * FROM veterinario WHERE numCRMV ='" + crmvVet + "';");
						
						rsVet = cmdSQL.executeQuery();
						
						if(rsVet.next()){ //ja existe
							out.println("<p class='aviso'>Já existe um veterinário cadastrado com esse CRMV</p>");
					}
					else{ //nao existe - vai inserir no bd
					try{
						
						
						//cmdSQL = conexaoBD.prepareStatement("Insert into aluno(nome, media) values('Maria', 9.5)");
						cmdSQL = conexaoBD.prepareStatement("Insert into veterinario(numCRMV, nome, senha, faculdade, "
								+"horarioAtendimento) values('" + crmvVet + "', '" + nomeV + "', '" + senhaV + "', '" + faculdade + "', '" + horarioAtendimento + "')");
								
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
	}
			
		}	
	
	
			
	
	else if(operacao.equals("Visualizar")){
		response.sendRedirect("../visualizacoes/visualizarVeterinario.jsp");
	}
	
	else if(operacao.equals("Voltar")){
		response.sendRedirect("../pagSecretario.jsp");
	}
	
	else if(operacao.equals("Alterar")){
		crmvVet = request.getParameter("txtCrmv");
		nomeV = request.getParameter("txtNome");
		senhaV = request.getParameter("txtSenha");
		faculdade = request.getParameter("txtFaculdade");
		horarioAtendimento = request.getParameter("txtHorarioAtendimento");
				
			if(crmvVet == null || crmvVet.isEmpty() || crmvVet == ""|| nomeV.isEmpty() || nomeV == null || faculdade.isEmpty() || 
					faculdade == null || senhaV.isEmpty() || senhaV == null || horarioAtendimento.isEmpty() ||
							horarioAtendimento == null || horarioAtendimento == "" || nomeV == "" || senhaV == ""
							|| faculdade == "" || crmvVet=="" ){
				out.println("<p class='aviso'>Preencha todos os campos</p>");
				out.println("<form action='../alteracoes/alterarVeterinario.jsp' method='get'>");
				out.println("<input type='submit' value='Voltar'>");
				out.println("</form>");
			}
			else{
				
				String[] splitespaco = horarioAtendimento.split(" ");
				//out.println("tamho: " +horarioTrabalho.length());
				
				//out.println(hora1);
				//out.println(hora2);
				//
				if(horarioAtendimento.length() != 10){
					out.println("<p class='aviso'>Horário Inválido: " + horarioAtendimento + "</p>");
					//out.println(splithora1[0].length());
					//out.println(splithora2[0].length());
				}else{
					//validando horario --> 24h/60min/60s
					String[] splithora1 = splitespaco[0].split("h");
					String[] splithora2 = splitespaco[2].split("h");
					
					hora1 = Integer.parseInt(splithora1[0]);
					hora2 = Integer.parseInt(splithora2[0]);
					if(hora1 > 23 || hora2 > 23 || hora1 == hora2){
						out.println("<p class='aviso'>Horário Inválido: " + horarioAtendimento + "</p>");
					}else{
					
					try{
						//Testa se o crmv indicado pra inserção ja existe no banco
						cmdSQL = conexaoBD.prepareStatement("SELECT * FROM veterinario WHERE numCRMV ='" + crmvVet + "';");
						
						rsVet = cmdSQL.executeQuery();
						
						if(!rsVet.next()){ //ja existe
							out.println("<p class='aviso'>Não existe um veterinário cadastrado com esse CRMV</p>");
					}
					else{ //nao existe - vai inserir no bd
					try{
						
						cmdSQL = conexaoBD.prepareStatement("UPDATE veterinario SET nome='" + nomeV + "', senha='" + senhaV
								+ "', faculdade='" + faculdade + "', horarioAtendimento='" + horarioAtendimento + "' WHERE numCRMV = " + crmvVet + ";");
		
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
				
			}
		
	}
	
else if(operacao.equals("Excluir")){
	crmvVet = request.getParameter("txtCrmv");
	nomeV = request.getParameter("txtNome");
	senhaV = request.getParameter("txtSenha");
	faculdade = request.getParameter("txtFaculdade");
	horarioAtendimento = request.getParameter("txtHorarioAtendimento");
			
		if(crmvVet == null || crmvVet.isEmpty() || crmvVet == ""|| nomeV.isEmpty() || nomeV == null || faculdade.isEmpty() || 
				faculdade == null || senhaV.isEmpty() || senhaV == null || horarioAtendimento.isEmpty() ||
						horarioAtendimento == null || horarioAtendimento == "" || nomeV == "" || senhaV == ""
						|| faculdade == "" || crmvVet=="" ){
			out.println("<p class='aviso'>Preencha todos os campos</p>");
			out.println("<form action='../exclusoes/excluirVeterinario.jsp' method='get'>");
			out.println("<input type='submit' value='Voltar'>");
			out.println("</form>");
		}
		else{
			try{
				//Testa se o crmv indicado pra inserção ja existe no banco
				cmdSQL = conexaoBD.prepareStatement("SELECT * FROM veterinario WHERE numCRMV ='" + crmvVet + "';");
				
				rsVet = cmdSQL.executeQuery();
				
				if(!rsVet.next()){ //ja existe
					out.println("<p class='aviso'>Não existe um veterinário cadastrado com esse CRMV</p>");
			}
			else{ //nao existe - vai inserir no bd
			try{
				cmdSQL = conexaoBD.prepareStatement("DELETE FROM consulta WHERE numCRMVvet = " + crmvVet);
				cmdSQL.executeUpdate();
				cmdSQL = conexaoBD.prepareStatement("DELETE FROM veterinario WHERE numCRMV = " + crmvVet);
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
	
	
%>

</body>
</html> 