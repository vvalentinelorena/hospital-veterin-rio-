<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.concurrent.Delayed"%>
<%@ page import="java.io.*,java.util.*" %>
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
	ResultSet rsCli = null;
	
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
	Integer numCadastro;
	String nomeC, cpf, dataNas, telefone, contato, numCadastrostr;
	
	
	//---------------------------------------
	// Operações de SQL
	//---------------------------------------
	
	String operacao;
	
	operacao = request.getParameter("btnOperacao");
	//media = Float.parseFloat(request.getParameter("txtMedia").toString());
	//
	
	
	
	
	
		if(operacao.equals("Inserir")){
			numCadastrostr = request.getParameter("txtNumCadastro");
			nomeC = request.getParameter("txtNome");
			cpf = request.getParameter("txtCpf");
			dataNas = request.getParameter("txtDataNas");
			telefone = request.getParameter("txtTelefone");
			contato = request.getParameter("txtContato");
			if(numCadastrostr == null || numCadastrostr.isEmpty() || numCadastrostr == "" || nomeC.isEmpty() || nomeC == null || cpf.isEmpty() || 
					cpf == null || dataNas.isEmpty() || dataNas == null || telefone.isEmpty() ||
							telefone == null || contato.isEmpty() || contato == null){
				out.println("<p class='aviso'>Preencha todos os campos</p>");
				out.println("<form action='../cadastros/cadastroCliente.jsp' method='get'>");
				out.println("<input type='submit' value='Voltar'>");
				out.println("</form>");
				
			}else{
				numCadastro = Integer.parseInt(request.getParameter("txtNumCadastro"));
			
			try{
				//Testa se o crmv indicado pra inserção ja existe no banco
				cmdSQL = conexaoBD.prepareStatement("SELECT * FROM cliente WHERE numCadastro ='" + numCadastro + "';");
				
				rsCli = cmdSQL.executeQuery();
				
				if(rsCli.next()){ //ja existe
					out.println("<p class='aviso'>Já existe um cliente cadastrado com esse numero</p>");
					
				}
				else{ //nao existe - vai inserir no bd
					try{
						
					
						//cmdSQL = conexaoBD.prepareStatement("Insert into aluno(nome, media) values('Maria', 9.5)");
						cmdSQL = conexaoBD.prepareStatement("Insert into cliente (numCadastro, nome, cpf, dataNas, telefone, "
								+"contato) values('" + numCadastro + "', '" + nomeC + "', '" + cpf + "', '" + dataNas + "', '" + telefone + "', '" + contato + "')");
								
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
		numCadastrostr = request.getParameter("txtNumCadastro");
		nomeC = request.getParameter("txtNome");
		cpf = request.getParameter("txtCpf");
		dataNas = request.getParameter("txtDataNas");
		telefone = request.getParameter("txtTelefone");
		contato = request.getParameter("txtContato");
		if(numCadastrostr == null || numCadastrostr.isEmpty() || numCadastrostr == "" || nomeC.isEmpty() || nomeC == null || cpf.isEmpty() || 
				cpf == null || dataNas.isEmpty() || dataNas == null || telefone.isEmpty() ||
						telefone == null || contato.isEmpty() || contato == null){
			out.println("<p class='aviso'>Preencha todos os campos</p>");
			out.println("<form action='../alteracoes/alterarCliente.jsp' method='get'>");
			out.println("<input type='submit' value='Voltar'>");
			out.println("</form>");
			
		}else{
			numCadastro = Integer.parseInt(request.getParameter("txtNumCadastro"));
		
		try{
			//Testa se o crmv indicado pra inserção ja existe no banco
			cmdSQL = conexaoBD.prepareStatement("SELECT * FROM cliente WHERE numCadastro ='" + numCadastro + "';");
			
			rsCli = cmdSQL.executeQuery();
			
			if(!rsCli.next()){ 
				out.println("<p class='aviso'>Não existe um cliente cadastrado com esse numero</p>");
				
			}
			else{
				try{
					
				
		//cmdSQL = conexaoBD.prepareStatement("UPDATE estudante_auxiliar SET nome='" + nomeA + "', faculdade='" + faculdade
		//+ "', periodoFaculdade='" + periodo + "', horarioTrabalho='" + horarioTrabalho + "' WHERE numCadastro = " + numCadastro + ";");
					cmdSQL = conexaoBD.prepareStatement("UPDATE cliente SET nome='" + nomeC + "', cpf='" + cpf
					+ "', dataNas='" + dataNas + "', telefone= '" + telefone + "', contato='" + contato + "' WHERE numCadastro = " + numCadastro + ";");
							
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
		
		ArrayList <String> animais = new ArrayList<>();
		numCadastrostr = request.getParameter("txtNumCadastro");
		nomeC = request.getParameter("txtNome");
		cpf = request.getParameter("txtCpf");
		dataNas = request.getParameter("txtDataNas");
		telefone = request.getParameter("txtTelefone");
		contato = request.getParameter("txtContato");
		if(numCadastrostr == null || numCadastrostr.isEmpty() || numCadastrostr == "" || nomeC.isEmpty() || nomeC == null || cpf.isEmpty() || 
				cpf == null || dataNas.isEmpty() || dataNas == null || telefone.isEmpty() ||
						telefone == null || contato.isEmpty() || contato == null){
			out.println("<p class='aviso'>Preencha todos os campos</p>");
			out.println("<form action='../exclusoes/excluirCliente.jsp' method='get'>");
			out.println("<input type='submit' value='Voltar'>");
			out.println("</form>");
			
		}else{
			numCadastro = Integer.parseInt(request.getParameter("txtNumCadastro"));
			try{
				cmdSQL = conexaoBD.prepareStatement("SELECT * FROM animal WHERE numCadastroDono ='" + numCadastro + "';");
				
				rsCli = cmdSQL.executeQuery();
				
				if(rsCli.next()){ 
					do{
	    				//nomepreenche = (String) rsSet.getString("nome");
	    				animais.add((String) rsCli.getString("numCadastro"));
	    											
	    			}while(rsCli.next());	
	    	
	    			
				}
				
			}catch(Exception ex){
				out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
				return;
			}	
		
		try{
			//Testa se o crmv indicado pra inserção ja existe no banco
			cmdSQL = conexaoBD.prepareStatement("SELECT * FROM cliente WHERE numCadastro ='" + numCadastro + "';");
			
			rsCli = cmdSQL.executeQuery();
			
			if(!rsCli.next()){ 
				out.println("<p class='aviso'>Não existe um cliente cadastrado com esse numero</p>");
				
			}
			else{
				try{
					for(int i = 0; i < animais.size(); i++){
						
						cmdSQL = conexaoBD.prepareStatement("Delete From animal Where numCadastro = " + animais.get(i));
						cmdSQL.executeUpdate();
						cmdSQL = conexaoBD.prepareStatement("Delete From animal_alergias Where idAnimal = " + animais.get(i));
						cmdSQL.executeUpdate();
						cmdSQL = conexaoBD.prepareStatement("Delete From internacao Where numCadastroAnimal = " + animais.get(i));	
						cmdSQL.executeUpdate();
						cmdSQL = conexaoBD.prepareStatement("Delete From consulta Where numCadastroAnimal = " + animais.get(i));	
						cmdSQL.executeUpdate();
					
					}	
					
					cmdSQL = conexaoBD.prepareStatement("DELETE FROM cliente WHERE numCadastro = " + numCadastro);
							
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
		response.sendRedirect("../visualizacoes/visualizarCliente.jsp");
	}
		
	else if(operacao.equals("Voltar")){
		response.sendRedirect("../pagSecretario.jsp");
	}
	

%>

</body>
</html>