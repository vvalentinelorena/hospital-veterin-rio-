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
	ResultSet rsAux = null;
	
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
	Integer numCadastro = 0;
	String nomeA ="", faculdade = "", periodo = "", horarioTrabalho = "", numCadastrostr;
	
	
	//---------------------------------------
	// Operações de SQL
	//---------------------------------------
	
	String operacao;
	Integer hora1 = 0, hora2 = 0;
	operacao = request.getParameter("btnOperacao");
	//media = Float.parseFloat(request.getParameter("txtMedia").toString());
	
	
	
		if(operacao.equals("Inserir")){
			//numCadastro = Integer.parseInt(request.getParameter("txtNumCadastro"));
			numCadastrostr = request.getParameter("txtNumCadastro");
			nomeA = request.getParameter("txtNome");
			faculdade = request.getParameter("txtFaculdade");
			periodo = request.getParameter("txtPeriodo");
			horarioTrabalho = request.getParameter("txtHorarioTrabalho");
			
			if(numCadastrostr == null || numCadastrostr.equals("null") || numCadastrostr == "" || nomeA.isEmpty() || nomeA == null || faculdade.isEmpty() || 
					faculdade == null || periodo.isEmpty() || periodo == null || horarioTrabalho.isEmpty() ||
							horarioTrabalho == null || horarioTrabalho == "" || nomeA == "" || faculdade == ""
							|| periodo == ""){
				out.println("<p class='aviso'>Preencha todos os campos</p>");
				out.println("<form action='../cadastros/cadastroAuxiliar.jsp' method='get'>");
				out.println("<input type='submit' value='Voltar'>");
				out.println("</form>");
			}
			else{
				
				String[] splitespaco = horarioTrabalho.split(" ");
				//out.println("tamho: " +horarioTrabalho.length());
				numCadastro = Integer.parseInt(request.getParameter("txtNumCadastro"));
				//out.println(hora1);
				//out.println(hora2);
				//
				if(horarioTrabalho.length() != 10){
					out.println("<p class='aviso'>Horário Inválido: " + horarioTrabalho + "</p>");
					out.println("<form action='../cadastros/cadastroAuxiliar.jsp' method='get'>");
					out.println("<input type='submit' value='Voltar'>");
					out.println("</form>");
					//out.println(splithora1[0].length());
					//out.println(splithora2[0].length());
				}else{
					//validando horario --> 24h/60min/60s
					String[] splithora1 = splitespaco[0].split("h");
					String[] splithora2 = splitespaco[2].split("h");
					
					hora1 = Integer.parseInt(splithora1[0]);
					hora2 = Integer.parseInt(splithora2[0]);
					if(hora1 > 23 || hora2 > 23 || hora1 == hora2){
						out.println("<p class='aviso'>Horário Inválido: " + horarioTrabalho + "</p>");
						out.println("<form action='../cadastros/cadastroAuxiliar.jsp' method='get'>");
						out.println("<input type='submit' value='Voltar'>");
						out.println("</form>");
					}else{
					
					try{
						//Testa se o crmv indicado pra inserção ja existe no banco
						cmdSQL = conexaoBD.prepareStatement("SELECT * FROM estudante_auxiliar WHERE numCadastro ='" + numCadastro + "';");
						
						rsAux = cmdSQL.executeQuery();
						
						if(rsAux.next()){ //ja existe
							out.println("<p class='aviso'>Já existe um auxiliar cadastrado com esse numero</p>");
					}
					else{ //nao existe - vai inserir no bd
					try{
						
						
						//cmdSQL = conexaoBD.prepareStatement("Insert into aluno(nome, media) values('Maria', 9.5)");
						cmdSQL = conexaoBD.prepareStatement("Insert into estudante_auxiliar(numCadastro, nome, faculdade, periodoFaculdade, "
								+"horarioTrabalho) values('" + numCadastro + "', '" + nomeA + "', '" + faculdade + "', '" + periodo + "', '" + horarioTrabalho + "')");
								
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
		response.sendRedirect("../visualizacoes/visualizarAuxiliar.jsp");
	}
		
		else if(operacao.equals("Alterar")){
			numCadastrostr = request.getParameter("txtId");
			nomeA = request.getParameter("txtNome");
			faculdade = request.getParameter("txtFaculdade");
			periodo = request.getParameter("txtPeriodo");
			horarioTrabalho = request.getParameter("txtHorarioTrabalho");
			
			if(numCadastrostr == null || numCadastrostr.equals("null") || numCadastrostr == "" || nomeA.isEmpty() || nomeA == null || faculdade.isEmpty() || 
					faculdade == null || periodo.isEmpty() || periodo == null || horarioTrabalho.isEmpty() ||
							horarioTrabalho == null || horarioTrabalho == "" || nomeA == "" || faculdade == ""
							|| periodo == ""){
				out.println("<p class='aviso'>Preencha todos os campos</p>");
				out.println("<form action='../alteracoes/alterarAuxiliar.jsp' method='get'>");
				out.println("<input type='submit' value='Voltar'>");
				out.println("</form>");
			}
			else{
				
				String[] splitespaco = horarioTrabalho.split(" ");
				//out.println("tamho: " +horarioTrabalho.length());
				numCadastro = Integer.parseInt(request.getParameter("txtId"));
				//out.println(hora1);
				//out.println(hora2);
				//
				if(horarioTrabalho.length() != 10){
					out.println("<p class='aviso'>Horário Inválido: " + horarioTrabalho + "</p>");
					out.println("<form action='../alteracoes/alterarAuxiliar.jsp' method='get'>");
					out.println("<input type='submit' value='Voltar'>");
					out.println("</form>");
					//out.println(splithora1[0].length());
					//out.println(splithora2[0].length());
				}else{
					//validando horario --> 24h/60min/60s
					String[] splithora1 = splitespaco[0].split("h");
					String[] splithora2 = splitespaco[2].split("h");
					
					hora1 = Integer.parseInt(splithora1[0]);
					hora2 = Integer.parseInt(splithora2[0]);
					if(hora1 > 23 || hora2 > 23 || hora1 == hora2){
						out.println("<p class='aviso'>Horário Inválido: " + horarioTrabalho + "</p>");
						out.println("<form action='../alteracoes/alterarAuxiliar.jsp' method='get'>");
						out.println("<input type='submit' value='Voltar'>");
						out.println("</form>");
					}else{
					
					try{
						//Testa se o crmv indicado pra inserção ja existe no banco
						cmdSQL = conexaoBD.prepareStatement("SELECT * FROM estudante_auxiliar WHERE numCadastro ='" + numCadastro + "';");
						
						rsAux = cmdSQL.executeQuery();
						
						if(!rsAux.next()){ //ja existe
							out.println("<p class='aviso'>Não existe um auxiliar cadastrado com esse numero de ID</p>");
					}
					else{ //nao existe - vai inserir no bd
					try{
						
						
						//cmdSQL = conexaoBD.prepareStatement("Insert into aluno(nome, media) values('Maria', 9.5)");
						//cmdSQL = conexaoBD.prepareStatement("Insert into estudante_auxiliar(numCadastro, nome, faculdade, periodoFaculdade, "
								//+"horarioTrabalho) values('" + numCadastro + "', '" + nomeA + "', '" + faculdade + "', '" + periodo + "', '" + horarioTrabalho + "')");
							
					
						cmdSQL = conexaoBD.prepareStatement("UPDATE estudante_auxiliar SET nome='" + nomeA + "', faculdade='" + faculdade
							+ "', periodoFaculdade='" + periodo + "', horarioTrabalho='" + horarioTrabalho + "' WHERE numCadastro = " + numCadastro + ";");
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
		
		
	
		else if(operacao.equals("Voltar")){
			response.sendRedirect("../pagSecretario.jsp");
		}
	
		
		else if(operacao.equals("Excluir")){
			numCadastrostr = request.getParameter("txtId");
			nomeA = request.getParameter("txtNome");
			faculdade = request.getParameter("txtFaculdade");
			periodo = request.getParameter("txtPeriodo");
			horarioTrabalho = request.getParameter("txtHorarioTrabalho");
			
			if(numCadastrostr == null || numCadastrostr.equals("null") || numCadastrostr == "" || nomeA.isEmpty() || nomeA == null || faculdade.isEmpty() || 
					faculdade == null || periodo.isEmpty() || periodo == null || horarioTrabalho.isEmpty() ||
							horarioTrabalho == null || horarioTrabalho == "" || nomeA == "" || faculdade == ""
							|| periodo == ""){
				out.println("<p class='aviso'>Preencha todos os campos</p>");
				out.println("<form action='../exclusoes/excluirAuxiliar.jsp' method='get'>");
				out.println("<input type='submit' value='Voltar'>");
				out.println("</form>");
			}
			else{
				numCadastro = Integer.parseInt(request.getParameter("txtId"));
				
				
				try{
					//Testa se o crmv indicado pra inserção ja existe no banco
					cmdSQL = conexaoBD.prepareStatement("SELECT * FROM estudante_auxiliar WHERE numCadastro ='" + numCadastro + "';");
					
					rsAux = cmdSQL.executeQuery();
					
					if(!rsAux.next()){ //ja existe
						out.println("<p class='aviso'>Não existe um auxiliar cadastrado com esse numero de ID</p>");
				}
				else{ //nao existe - vai inserir no bd
				try{
					
					
				//cmdSQL = conexaoBD.prepareStatement("DELETE FROM aparelho WHERE idAparelho = " + id);	
					cmdSQL = conexaoBD.prepareStatement("DELETE FROM estudante_auxiliar WHERE numCadastro = " + numCadastro);
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