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
	
	
	
	//---------------------------------------
	// Operações de SQL
	//---------------------------------------
	
	String operacao;
	
	operacao = request.getParameter("btnOperacao");
	

	
	
	//if(numCadastro == null || nomeAn.isEmpty() || nomeAn == null || numCdstr == null || idadestr == null || raca.isEmpty() || 
	//		raca == null || especie.isEmpty() || especie == null || numCV.isEmpty() ||
	//				numCV == null || numCdstr == null || achouDono == false){
	//	out.println("<h3>Preencha todos os campos</h3>");
		
	//}else{
	
		if(operacao.equals("Inserir")){
			Integer numCadastro = 0,  numCD = 0;
			String nomeAn, raca, especie, numCV, numCadastrostr, idadestr, numCdstr;
			Integer idade; 
			boolean achouDono = false;
			
			numCadastrostr = request.getParameter("txtNumCadastro");
			//
			nomeAn = request.getParameter("txtNome");
			//
			numCdstr = request.getParameter("idDono");
			idadestr = request.getParameter("txtIdade");
			//
			raca = request.getParameter("txtRaca");
			especie = request.getParameter("txtEspecie");
			numCV = request.getParameter("txtNumCV");
			
			if(numCadastrostr == null || nomeAn.isEmpty() || nomeAn == null || numCdstr == null || idadestr == null || raca.isEmpty() || 
			raca == null || especie.isEmpty() || especie == null || numCV.isEmpty() ||
			numCV == null || numCdstr == null){
			out.println("<p class='aviso'>Preencha todos os campos</p>");
			out.println("<form action='../cadastros/cadastroAnimal.jsp' method='get'>");
			out.println("<input type='submit' value='Voltar'>");
			out.println("</form>");
						
			}else{
				numCadastro = Integer.parseInt(request.getParameter("txtNumCadastro").toString());
				numCD = Integer.parseInt(request.getParameter("idDono").toString());
				idade = Integer.parseInt(request.getParameter("txtIdade").toString());
				
				try{
					cmdSQL = conexaoBD.prepareStatement("SELECT * FROM cliente WHERE numCadastro ='" + numCD + "';");
					
					rsAux = cmdSQL.executeQuery();
					
					if(rsAux.next()){ // existe
						achouDono = true;
						
					}
					else{ //nao existe 
						achouDono = false;
					}
					
					}catch(Exception ex){
					out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
					return;
				}	
			
				try{
					//Testa se o crmv indicado pra inserção ja existe no banco
					cmdSQL = conexaoBD.prepareStatement("SELECT * FROM animal WHERE numCadastro ='" + numCadastro + "';");
					
					rsAux = cmdSQL.executeQuery();
					
					if(rsAux.next()){ //ja existe
						out.println("<p class='aviso'>Já existe um animal cadastrado com esse numero</p>");
						
					}
					else{ //nao existe - vai inserir no bd
						if(achouDono == false){
							out.println("<p class='aviso'>Não existe um cliente cadastrado no site com o ID informado</p>");
						}else{
						try{
							
							
							//cmdSQL = conexaoBD.prepareStatement("Insert into aluno(nome, media) values('Maria', 9.5)");
							cmdSQL = conexaoBD.prepareStatement("Insert into animal(numCadastro, nome, numCadastroDono, idade, raca, especie, "
									+"numCarteiraVac) values('" + numCadastro + "', '" + nomeAn + "', '" + numCD + "', '" + idade 
											+ "', '" + raca + "', '" + especie + "', '" + numCV + "')");
									
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
					
			}
			catch(Exception ex){
				out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
				return;
				}	
			}
		}
			
			
			
			
	
	else if(operacao.equals("Visualizar")){
		response.sendRedirect("../visualizacoes/visualizarAnimal.jsp");
	}
	
	//}
	
	else if (operacao.equals("Alterar")){
		boolean achouAnimal = false;
		Integer idAnimal, idade;
		String idAnimalstr, nome, idadestr, raca, especie, numCV;
		idAnimalstr = request.getParameter("txtIdAnimal");
		nome = request.getParameter("txtNome");
		idadestr = request.getParameter("txtIdade");
		raca = request.getParameter("txtRaca");
		especie = request.getParameter("txtEspecie");
		numCV = request.getParameter("txtNumCV");
		
		if(idAnimalstr.isEmpty() || idAnimalstr == null || idAnimalstr == "" || nome.isEmpty() || nome == null || nome == "" 
		|| idadestr.isEmpty() || idadestr == null || idadestr == "" || raca.isEmpty() || raca == null || raca == "" ||
		especie.isEmpty() || especie == null || especie == "" || numCV.isEmpty() || numCV == null || numCV == ""){
			out.println("<p class='aviso'> Preencha todos os campos </p>");
			out.println("<form action='../alteracoes/alterarAnimal.jsp' method='get'>");
			out.println("<input type='submit' value='Voltar'>");
			out.println("</form>");
		}else{
			idAnimal = Integer.parseInt(request.getParameter("txtIdAnimal"));
			idade = Integer.parseInt(request.getParameter("txtIdade"));
			try{
				
				cmdSQL = conexaoBD.prepareStatement("SELECT * FROM animal WHERE numCadastro=" + idAnimal +";");			
				rsAux = cmdSQL.executeQuery();
				
				if(rsAux.next()){
					
					cmdSQL = conexaoBD.prepareStatement("UPDATE animal SET nome='" + nome + "', idade='" + idade + "', raca='" + raca
							+ "', especie='" + especie + "', numCarteiraVac='" + numCV + "' Where numCadastro = " + idAnimal + ";");
					cmdSQL.executeUpdate();
					
					out.println("<h3>Alteração efetuada com sucesso!</h3>");
					out.println("<form action='../pagVeterinario.jsp' method='get'>");
					out.println("<input type='submit' value='Voltar'>");
					out.println("</form>");
					
				}
				else{
					out.println("<p class='aviso'>Esse Id de animal não está cadastrado no sistema</p>");
				}
				
			}
			catch(Exception ex){
				out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
				return;
			}	
		}
	}	
	
	else if (operacao.equals("Excluir")){
		Integer idAnimal, idade;
		String idAnimalstr, nome, idadestr, raca, especie, numCV;
		idAnimalstr = request.getParameter("txtIdAnimal");
		nome = request.getParameter("txtNome");
		idadestr = request.getParameter("txtIdade");
		raca = request.getParameter("txtRaca");
		especie = request.getParameter("txtEspecie");
		numCV = request.getParameter("txtNumCV");
		
		if(idAnimalstr.isEmpty() || idAnimalstr == null || idAnimalstr == "" || nome.isEmpty() || nome == null || nome == "" 
		|| idadestr.isEmpty() || idadestr == null || idadestr == "" || raca.isEmpty() || raca == null || raca == "" ||
		especie.isEmpty() || especie == null || especie == "" || numCV.isEmpty() || numCV == null || numCV == ""){
			out.println("<p class='aviso'> Preencha todos os campos </p>");
			out.println("<form action='../exclusoes/excluirAnimal.jsp' method='get'>");
			out.println("<input type='submit' value='Voltar'>");
			out.println("</form>");
		}else{
			idAnimal = Integer.parseInt(request.getParameter("txtIdAnimal"));
			idade = Integer.parseInt(request.getParameter("txtIdade"));
		try{
			
			cmdSQL = conexaoBD.prepareStatement("SELECT * FROM animal WHERE numCadastro=" + idAnimal +";");			
			rsAux = cmdSQL.executeQuery();
			
			if(rsAux.next()){
				
				//excluindo a tabela animal e as tabelas referenciadas a ele pelo id digitado na pag de exclusao
				cmdSQL = conexaoBD.prepareStatement("Delete From animal Where numCadastro = " + idAnimal);	
				cmdSQL.executeUpdate();
				cmdSQL = conexaoBD.prepareStatement("Delete From animal_alergias Where idAnimal = " + idAnimal);	
				cmdSQL.executeUpdate();
				cmdSQL = conexaoBD.prepareStatement("Delete From internacao Where numCadastroAnimal = " + idAnimal);	
				cmdSQL.executeUpdate();
				cmdSQL = conexaoBD.prepareStatement("Delete From consulta Where numCadastroAnimal = " + idAnimal);	
				cmdSQL.executeUpdate();
				
				out.println("<h3>Exclusão efetuada com sucesso!</h3>");
				out.println("<form action='../pagVeterinario.jsp' method='get'>");
				out.println("<input type='submit' value='Voltar'>");
				out.println("</form>");
				
			}
			else{
				out.println("<p class='aviso'>Esse Id de animal não está cadastrado no sistema</p>");
			}
			
		}
		catch(Exception ex){
			out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
			return;
		}	
	}
}
	
	else if(operacao.equals("Voltar")){
		response.sendRedirect("../pagVeterinario.jsp");
	}
			

%>
</body>
</html> 