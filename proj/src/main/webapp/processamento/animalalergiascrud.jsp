<%@page import="org.apache.jasper.tagplugins.jstl.core.Param"%>
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
	ResultSet rsAux = null, rsAux2 = null;
	
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
	Integer idMed = 0, idAnimal = 0;
	String nivelAlergia, idAnimalstr, idMedstr;
	boolean achouA = false;
	boolean achouM = false;
	
	
	//---------------------------------------
	// Operações de SQL
	//---------------------------------------
	
	String operacao;
	
	operacao = request.getParameter("btnOperacao");
	
	
	
	
	
	
		if(operacao.equals("Inserir")){
			idAnimalstr = (request.getParameter("idA"));
			idMedstr = (request.getParameter("idM"));
			//idMedstr = Integer.parseInt(request.getParameter("idM").toString());
			nivelAlergia = request.getParameter("txtNivelAlergia");
			if( nivelAlergia.isEmpty() || nivelAlergia == null || nivelAlergia == "" || idAnimalstr == null || idMedstr == null
					|| idAnimalstr.equals("null") || idMedstr.equals("null") ){
				out.println("<p class='aviso'>Preencha todos os campos</p>");
				out.println("<form action='../cadastros/cadastroAlergias.jsp' method='get'>");
				out.println("<input type='submit' value='Voltar'>");
				out.println("</form>");
				
			}else{
				idMed = Integer.parseInt(request.getParameter("idM").toString());
				idAnimal = Integer.parseInt(request.getParameter("idA").toString());
				try{
					cmdSQL = conexaoBD.prepareStatement("SELECT * FROM animal WHERE numCadastro = " + idAnimal);
					
					rsAux = cmdSQL.executeQuery();
					if(rsAux.next()){ //existe o id digitado pra animal
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
					cmdSQL = conexaoBD.prepareStatement("SELECT * FROM medicamento WHERE idMedicamento = " + idMed);
					
					rsAux = cmdSQL.executeQuery();
					if(rsAux.next()){ //existe o id digitado pra animal
						achouM = true;
						
					}else{
						out.println("<p class='aviso'>O id do medicamento que foi digitado não está cadastrado no sistema</p>");
					}
				}
					catch(Exception ex){
						out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
						return;
					}	
					
				}
			
			if(achouA == true && achouM == true){
			
			try{
				
				cmdSQL = conexaoBD.prepareStatement("SELECT * FROM animal_alergias WHERE idMedicamento = " + idMed + " AND idAnimal =  " + idAnimal);
				
				rsAux = cmdSQL.executeQuery();
				
				if(rsAux.next()){ //ja existe
					out.println("<p class='aviso'>Essa alergia já está cadastrada para esse animal</p>");
					
				}
				else{ //nao existe - vai inserir no bd
					try{
						
						
						//cmdSQL = conexaoBD.prepareStatement("Insert into aluno(nome, media) values('Maria', 9.5)");
						cmdSQL = conexaoBD.prepareStatement("Insert into animal_alergias(idMedicamento, idAnimal, nivelAlergia) values('" + idMed + "', '" + idAnimal + "', '" + nivelAlergia + "')");
								
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
		idAnimalstr = (request.getParameter("idA"));
		idMedstr = (request.getParameter("idM"));
		//idMedstr = Integer.parseInt(request.getParameter("idM").toString());
		nivelAlergia = request.getParameter("txtNivelAlergia");
		if(nivelAlergia.isEmpty() || nivelAlergia == null || nivelAlergia == "" || idAnimalstr == null || idMedstr == null
				|| idAnimalstr.equals("null") || idMedstr.equals("null")){
			out.println("<p class='aviso'>Preencha todos os campos</p>");
			
			out.println("<form action='../alteracoes/alterarAlergias.jsp' method='get'>");
			out.println("<input type='submit' value='Voltar'>");
			out.println("</form>");
			
		}else{
			idMed = Integer.parseInt(request.getParameter("idM").toString());
			idAnimal = Integer.parseInt(request.getParameter("idA").toString());
			try{
				cmdSQL = conexaoBD.prepareStatement("SELECT * FROM animal_alergias WHERE idMedicamento = '" + idMed + "' AND idAnimal = '" + idAnimal  +"';");
				rsAux = cmdSQL.executeQuery();
				if(rsAux.next()){ 
					achouA = true;
					achouM = true;
					
				}else{
					out.println("<p class='aviso'>Essa combinação de id não está cadastrada em nenhuma alergia do sistema</p>");
				}
			}
			
				catch(Exception ex){
					out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
					return;
				}	
		
				
			}
		
		
		if(achouA == true && achouM == true){
		
			try{
				//"UPDATE animal SET nome='" + nome + "', idade='" + idade + "', raca='" + raca
				//+ "', especie='" + especie + "', numCarteiraVac='" + numCV + "' Where numCadastro = " + idAnimal + ";");
			
				//WHERE numSala ='" + numSala + "' and dataHora = '" + dataHora +"';");
				
				cmdSQL = conexaoBD.prepareStatement("UPDATE animal_alergias SET nivelAlergia = '" + nivelAlergia + "' WHERE idMedicamento = '" + idMed + "' AND idAnimal = '" + idAnimal  +"';");
							
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
	
		
		
	else if(operacao.equals("Excluir")){
		idAnimalstr = (request.getParameter("idA"));
		idMedstr = (request.getParameter("idM"));
		//idMedstr = Integer.parseInt(request.getParameter("idM").toString());
		nivelAlergia = request.getParameter("txtNivelAlergia");
		if(nivelAlergia.isEmpty() || nivelAlergia == null || nivelAlergia == "" || idAnimalstr == null || idMedstr == null
				|| idAnimalstr.equals("null") || idMedstr.equals("null")){
			out.println("<p class='aviso'>Preencha todos os campos</p>");
			out.println("<form action='../exclusoes/excluirAlergias.jsp' method='get'>");
			out.println("<input type='submit' value='Voltar'>");
			out.println("</form>");
			
		}else{
			idMed = Integer.parseInt(request.getParameter("idM").toString());
			idAnimal = Integer.parseInt(request.getParameter("idA").toString());
			try{
				cmdSQL = conexaoBD.prepareStatement("SELECT * FROM animal_alergias WHERE idMedicamento = '" + idMed + "' AND idAnimal = '" + idAnimal  +"';");
				rsAux = cmdSQL.executeQuery();
				if(rsAux.next()){ 
					achouA = true;
					achouM = true;
					
				}else{
					out.println("<p class='aviso'>Essa combinação de id não está cadastrada em nenhuma alergia do sistema</p>");
				}
			}
			
				catch(Exception ex){
					out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
					return;
				}	
		
				
			}
		
		
			if(achouA == true && achouM == true){
		
			try{
				
				
				cmdSQL = conexaoBD.prepareStatement("DELETE FROM animal_alergias WHERE idMedicamento = '" + idMed + "' AND idAnimal = '" + idAnimal  +"';");
							
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
		
	else if(operacao.equals("Visualizar")){
		response.sendRedirect("../visualizacoes/visualizarAlergias.jsp");
	}
		
	else if(operacao.equals("Voltar")){
		response.sendRedirect("../pagVeterinario.jsp");
	}
	
	

%>


</body>
</html>
