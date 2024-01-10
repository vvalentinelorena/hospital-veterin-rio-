<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    	String nomeV;
    	nomeV = request.getParameter("txtNomeV");
    	out.println("Bem Vindo(a)! - Você está na página dos Veterinários");
    %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Página do Veterinário</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script
  src="https://code.jquery.com/jquery-3.7.0.js"
  integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM="
  crossorigin="anonymous"></script>
<link href="./CSS/estilo2.css" rel="stylesheet" type="text/css">
</head>
<body>

<div class="btnAbre"><span class="fa-solid fa-bars"></span></div>
<nav class="menuLateral">
	<div class=titulo> Painel de Controle <span class="fas fa-times btnFecha"></span></div>
	<ul>
		<li><a href="#" class="animais">Animais<span class="fa-solid fa-plus"></span></a>
			<ul class="itensAnimais">
				<li><a href="./visualizacoes/visualizarAnimal.jsp">Visualizar</a></li> <!-- ok -->
				<li><a href="./cadastros/cadastroAnimal.jsp">Cadastrar</a></li> <!-- ok -->
				<li><a href="./alteracoes/alterarAnimal.jsp">Alterar</a></li> <!-- ok -->
				<li><a href="./exclusoes/excluirAnimal.jsp">Excluir</a></li> <!-- ok -->
			</ul>
		</li>
		
		<li><a href="#" class=aparelhos>Alergias - Animais <span class="fa-solid fa-plus"></span></a>
			<ul class="itensAparelhos">
				<li><a href="./visualizacoes/visualizarAlergias.jsp">Visualizar</a></li> <!-- ok -->
				<li><a href="./cadastros/cadastroAlergias.jsp">Cadastrar</a></li> <!-- ok -->
				<li><a href="./alteracoes/alterarAlergias.jsp">Alterar</a></li> <!-- ok -->
				<li><a href="./exclusoes/excluirAlergias.jsp">Excluir</a></li> <!-- ok -->
			</ul>
		</li>
		
		
		<li><a href="#" class="consultas">Consultas<span class="fa-solid fa-plus"></span></a>
			<ul class="itensConsultas">
				<li><a href="./visualizacoes/visualizarConsulta.jsp">Visualizar</a></li> <!-- ok -->
				<li><a href="./cadastros/cadastroConsulta.jsp">Cadastrar</a></li> <!-- ok -->
				<li><a href="./alteracoes/alterarConsulta.jsp">Alterar</a></li> <!-- ok -->
				<li><a href="./exclusoes/excluirConsulta.jsp">Excluir</a></li> <!-- ok  -->
			</ul>
		</li>
		
		
		<li><a href="#" class="internacoes">Internações<span class="fa-solid fa-plus"></span></a>
			<ul class="itensInternacoes">
				<li><a href="./visualizacoes/visualizarInternacao.jsp">Visualizar</a></li> <!-- ok -->
				<li><a href="./cadastros/cadastroInternacao.jsp">Cadastrar</a></li> <!-- ok -->
				<li><a href="./alteracoes/alterarInternacao.jsp">Alterar</a></li> <!-- ok  -->
				<li><a href="./exclusoes/excluirInternacao.jsp">Excluir</a></li> <!-- ok  -->
			</ul>
		</li>
		<li><a href="#" class="medicamentos">Medicamento(s)<span class="fa-solid fa-plus"></span></a>
			<ul class="itensMedicamentos">
				<li><a href="./visualizacoes/visualizarMedicamentoInternacao.jsp">Visualizar</a></li> <!-- ok -->
				<li><a href="./cadastros/cadastroMedicamentoInternacao.jsp">Cadastrar</a></li> <!-- ok -->
				<li><a href="./exclusoes/excluirMedicamentoInternacao.jsp">Excluir</a></li> <!-- ok  -->
			</ul>
		</li>
	</ul>

	<form action="clinica.jsp">
		<input type="submit" value="Sair">
	</form>
</nav>
<script type="text/javascript" src="./JS/script2.js"></script>


</body>
</html>