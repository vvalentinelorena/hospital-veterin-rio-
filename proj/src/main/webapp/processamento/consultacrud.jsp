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
	ResultSet rsCon = null;
	
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
	String dataHora, crmvVet, procedimento, numSalastr, idAnimalstr;
	Integer numSala = 0, idAnimal = 0; 
	Integer idDono = null;
	boolean achouAnimal = false;
	boolean achouVet = false;
	boolean achouDono = false;
	
	
	//---------------------------------------
	// Operações de SQL
	//---------------------------------------
	
	String operacao;
	
	operacao = request.getParameter("btnOperacao");
	
	
	if(operacao.equals("Inserir")){
		//numSala = Integer.parseInt(request.getParameter("txtNumSala").toString());
		numSalastr = request.getParameter("txtNumSala");
		dataHora = request.getParameter("txtDataHora");
		crmvVet = request.getParameter("txtIdVet");
		//idAnimal = Integer.parseInt(request.getParameter("txtIdAnimal").toString());
		idAnimalstr = request.getParameter("txtIdAnimal");
		procedimento = request.getParameter("txtProcedimento");
		
		if( numSalastr.isEmpty() || numSalastr == null || numSalastr == "" || dataHora == null || dataHora.isEmpty() ||
				dataHora == "" || crmvVet == null || crmvVet.isEmpty() || crmvVet == "" || idAnimalstr == null ||
				idAnimalstr.isEmpty() || idAnimalstr=="" ||procedimento == null || procedimento.isEmpty() || procedimento == "" ){
			out.println("<p class='aviso'>Preencha todos os campos</p>");
			out.println("<form action='../cadastros/cadastroConsulta.jsp' method='get'>");
			out.println("<input type='submit' value='Voltar'>");
			out.println("</form>");
			
		}else{
			numSala = Integer.parseInt(request.getParameter("txtNumSala").toString());
			idAnimal = Integer.parseInt(request.getParameter("txtIdAnimal").toString());
			try{
				cmdSQL = conexaoBD.prepareStatement("SELECT * FROM animal WHERE numCadastro = " + idAnimal);
				
				rsCon = cmdSQL.executeQuery();
				if(rsCon.next()){ //existe o id digitado pra animal
					achouAnimal = true;
					idDono = rsCon.getInt("numCadastroDono");
					achouDono = true;
					
				}else{
					out.println("<p class='aviso'>O id do animal que foi digitado não está cadastrado no sistema</p>");
				}
			}
				catch(Exception ex){
					out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
					return;
				}	
			
			try{
				cmdSQL = conexaoBD.prepareStatement("SELECT * FROM veterinario WHERE numCRMV = " + crmvVet);
				
				rsCon = cmdSQL.executeQuery();
				if(rsCon.next()){ //existe o id digitado pra animal
					achouVet = true;
					
				}else{
					out.println("<p class='aviso'>O crmv do veterinário que foi digitado não está cadastrado no sistema</p>");
				}
			}
				catch(Exception ex){
					out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
					return;
				}	
				
			}
		
		if(achouAnimal && achouDono && achouVet){
			String[] splitespaco = dataHora.split(" ");
			Integer hora, min, seg;
			//String[] splitespaco = horarioTrabalho.split(" ");
			//numCadastro = Integer.parseInt(request.getParameter("txtNumCadastro"));
			
			if(dataHora.length() != 19){
				out.println("<p class='aviso'>Horário Inválido: " + dataHora + "</p>");
				//out.println(splithora1[0].length());
				//out.println(splithora2[0].length());
			}else{
				//validando horario --> 24h/60min/60s
				String[] splithora = splitespaco[1].split(":");
				hora = Integer.parseInt(splithora[0]);
				min = Integer.parseInt(splithora[1]);
				seg = Integer.parseInt(splithora[2]);
				
				//validando data --> ano 1900 --- / mes 1 - 12 / dia 1 - 31 /
				Integer dia, mes, ano;
				String[] splitdata = splitespaco[0].split("/");
				ano = Integer.parseInt(splitdata[0]);
				mes = Integer.parseInt(splitdata[1]);
				dia = Integer.parseInt(splitdata[2]);
	
				 if(hora > 23 || min > 59 || seg > 59){
						out.println("<p class='aviso'>Horário Inválido: " + splitespaco[1] + "</p>");
					}else if(ano < 1900 || mes < 1 || mes > 12 || dia < 1 || dia > 31){
						out.println("<p class='aviso'>Data Inválida: " + splitespaco[0] + "</p>");
						
					}else if(mes == 2 && dia > 28){ //excessao pra feveireiro
						out.println("<p class='aviso'>Data Inválida: " + splitespaco[0] + "</p>");
					}
					
				else{
			
			try{
				//Testa se o crmv indicado pra inserção ja existe no banco
				cmdSQL = conexaoBD.prepareStatement("SELECT * FROM consulta WHERE numSala ='" + numSala + "' and dataHora = '" + dataHora +"';");
				
				rsCon = cmdSQL.executeQuery();
				
				if(rsCon.next()){ //ja existe
					out.println("<p class='aviso'>Já existe uma consulta cadastrada nessa sala com esse dia e horario</p>");
					out.println("<form action='../cadastros/cadastroConsulta.jsp' method='get'>");
					out.println("<input type='submit' value='Voltar'>");
					out.println("</form>");
					
				}
				else{ //nao existe - vai inserir no bd
					try{
						
						
						//cmdSQL = conexaoBD.prepareStatement("Insert into aluno(nome, media) values('Maria', 9.5)");
						cmdSQL = conexaoBD.prepareStatement("Insert into consulta(numSala, dataHora, numCadastroAnimal, numCRMVvet, numCadastroDono, "
								+"procedimento) values('" + numSala + "', '" + dataHora + "', '" + idAnimal 
										+ "', '" + crmvVet + "', '" + idDono + "', '" + procedimento + "')");
								
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
}
}

	else if(operacao.equals("Alterar")){
		numSalastr = request.getParameter("txtNumSala");
		dataHora = request.getParameter("txtDataHora");
		procedimento = request.getParameter("txtProcedimento");
		if( numSalastr.isEmpty() || numSalastr == null || numSalastr == "" || numSalastr.equals("null") || dataHora == null || dataHora.isEmpty() ||
				dataHora == "" || dataHora.equals("null")|| procedimento.equals("null")||procedimento == null || procedimento.isEmpty() || procedimento == "" ){
			out.println("<p class='aviso'>Preencha todos os campos</p>");
			out.println("<form action='../alteracoes/alterarConsulta.jsp' method='get'>");
			out.println("<input type='submit' value='Voltar'>");
			out.println("</form>");
			
		}else{
			String[] splitespaco = dataHora.split(" ");
			Integer hora, min, seg;
			//String[] splitespaco = horarioTrabalho.split(" ");
			//numCadastro = Integer.parseInt(request.getParameter("txtNumCadastro"));
			
			if(dataHora.length() != 19){
				out.println("<p class='aviso'>Horário Inválido: " + dataHora + "</p>");
				//out.println(splithora1[0].length());
				//out.println(splithora2[0].length());
			}else{
				//validando horario --> 24h/60min/60s
				String[] splithora = splitespaco[1].split(":");
				hora = Integer.parseInt(splithora[0]);
				min = Integer.parseInt(splithora[1]);
				seg = Integer.parseInt(splithora[2]);
				
				//validando data --> ano 1900 --- / mes 1 - 12 / dia 1 - 31 /
				Integer dia, mes, ano;
				String[] splitdata = splitespaco[0].split("/");
				ano = Integer.parseInt(splitdata[0]);
				mes = Integer.parseInt(splitdata[1]);
				dia = Integer.parseInt(splitdata[2]);
	
				 if(hora > 23 || min > 59 || seg > 59){
						out.println("<p class='aviso'>Horário Inválido: " + splitespaco[1] + "</p>");
					}else if(ano < 1900 || mes < 1 || mes > 12 || dia < 1 || dia > 31){
						out.println("<p class='aviso'>Data Inválida: " + splitespaco[0] + "</p>");
						
					}else if(mes == 2 && dia > 28){ //excessao pra feveireiro
						out.println("<p class='aviso'>Data Inválida: " + splitespaco[0] + "</p>");
					}
					
				else{
			
			numSala = Integer.parseInt(request.getParameter("txtNumSala"));
			
			try{
				cmdSQL = conexaoBD.prepareStatement("SELECT * FROM consulta WHERE numSala ='" + numSala + "' and dataHora = '" + dataHora +"';");
				
				rsCon = cmdSQL.executeQuery();
				
				if(!rsCon.next()){ 
					out.println("<p class='aviso'>Não existe uma consulta cadastrada nessa sala com esse dia e horario</p>");
					out.println("<form action='../alteracoes/alterarConsulta.jsp' method='get'>");
					out.println("<input type='submit' value='Voltar'>");
					out.println("</form>");
					
				}
				else{ 
					try{
						
						
						//cmdSQL = conexaoBD.prepareStatement("Insert into aluno(nome, media) values('Maria', 9.5)");
						cmdSQL = conexaoBD.prepareStatement("UPDATE consulta SET  procedimento='" + procedimento + "' WHERE dataHora = '" +dataHora +"' AND numSala= " + numSala + ";");
							
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
		}	
	}
	
	else if(operacao.equals("Excluir")){
		numSalastr = request.getParameter("txtNumSala");
		dataHora = request.getParameter("txtDataHora");
		procedimento = request.getParameter("txtProcedimento");
		if( numSalastr.isEmpty() || numSalastr == null || numSalastr == "" || numSalastr.equals("null") || dataHora == null || dataHora.isEmpty() ||
				dataHora == "" || dataHora.equals("null")|| procedimento.equals("null")||procedimento == null || procedimento.isEmpty() || procedimento == "" ){
			out.println("<p class='aviso'>Preencha todos os campos</p>");
			out.println("<form action='../exclusoes/excluirConsulta.jsp' method='get'>");
			out.println("<input type='submit' value='Voltar'>");
			out.println("</form>");
			
		}else{
			String[] splitespaco = dataHora.split(" ");
			Integer hora, min, seg;
			//String[] splitespaco = horarioTrabalho.split(" ");
			//numCadastro = Integer.parseInt(request.getParameter("txtNumCadastro"));
			
			if(dataHora.length() != 19){
				out.println("<p class='aviso'>Horário Inválido: " + dataHora + "</p>");
				//out.println(splithora1[0].length());
				//out.println(splithora2[0].length());
			}else{
				//validando horario --> 24h/60min/60s
				String[] splithora = splitespaco[1].split(":");
				hora = Integer.parseInt(splithora[0]);
				min = Integer.parseInt(splithora[1]);
				seg = Integer.parseInt(splithora[2]);
				
				//validando data --> ano 1900 --- / mes 1 - 12 / dia 1 - 31 /
				Integer dia, mes, ano;
				String[] splitdata = splitespaco[0].split("/");
				ano = Integer.parseInt(splitdata[0]);
				mes = Integer.parseInt(splitdata[1]);
				dia = Integer.parseInt(splitdata[2]);
	
				 if(hora > 23 || min > 59 || seg > 59){
						out.println("<p class='aviso'>Horário Inválido: " + splitespaco[1] + "</p>");
					}else if(ano < 1900 || mes < 1 || mes > 12 || dia < 1 || dia > 31){
						out.println("<p class='aviso'>Data Inválida: " + splitespaco[0] + "</p>");
						
					}else if(mes == 2 && dia > 28){ //excessao pra feveireiro
						out.println("<p class='aviso'>Data Inválida: " + splitespaco[0] + "</p>");
					}
					
				else{
			
			numSala = Integer.parseInt(request.getParameter("txtNumSala"));
			
			try{
				cmdSQL = conexaoBD.prepareStatement("SELECT * FROM consulta WHERE numSala ='" + numSala + "' and dataHora = '" + dataHora +"';");
				
				rsCon = cmdSQL.executeQuery();
				
				if(!rsCon.next()){ 
					out.println("<p class='aviso'>Não existe uma consulta cadastrada nessa sala com esse dia e horario</p>");
					out.println("<form action='../exclusoes/excluirConsulta.jsp' method='get'>");
					out.println("<input type='submit' value='Voltar'>");
					out.println("</form>");
					
				}
				else{ 
					try{
						
						
						//cmdSQL = conexaoBD.prepareStatement("Insert into aluno(nome, media) values('Maria', 9.5)");
						cmdSQL = conexaoBD.prepareStatement("DELETE FROM consulta WHERE dataHora = '" +dataHora +"' AND numSala= " + numSala + ";");
							
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
		}	
	}
	else if(operacao.equals("Visualizar")){
		response.sendRedirect("../visualizacoes/visualizarConsulta.jsp");
	}
	
	else if(operacao.equals("Voltar")){
		response.sendRedirect("../pagVeterinario.jsp");
	}
	
		
%>	
	
	




</body>
</html>