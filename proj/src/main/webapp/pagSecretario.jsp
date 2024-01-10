<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    	String nomeS;
    	nomeS = request.getParameter("txtNomeS");
    	out.println("Bem Vindo(a)! - Você está na página dos Secretários");
    %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Página do Secretário</title>
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
		<li><a href="#" class="veterinarios">Veterinários<span class="fa-solid fa-plus"></span></a>
			<ul class="itensVeterinarios">
				<li><a href="./visualizacoes/visualizarVeterinario.jsp">Visualizar</a></li> <!-- ok -->
				<li><a href="./cadastros/cadastroVeterinario.jsp">Cadastrar</a></li> <!-- ok -->
				<li><a href="./alteracoes/alterarVeterinario.jsp">Alterar</a></li> <!-- ok -->
				<li><a href="./exclusoes/excluirVeterinario.jsp">Excluir</a></li> <!-- ok -->
			</ul>
		</li>
		
		
		<li><a href="#" class="auxiliares">Auxiliares<span class="fa-solid fa-plus"></span></a>
			<ul class="itensAuxiliares">
				<li><a href="./visualizacoes/visualizarAuxiliar.jsp">Visualizar</a></li> <!-- ok -->
				<li><a href="./cadastros/cadastroAuxiliar.jsp">Cadastrar</a></li> <!-- ok -->
				<li><a href="./alteracoes/alterarAuxiliar.jsp">Alterar</a></li> <!-- ok -->
				<li><a href="./exclusoes/excluirAuxiliar.jsp">Excluir</a></li> <!-- ok -->
			</ul>
		</li>
		
		
		<li><a href="#" class="clientes">Clientes<span class="fa-solid fa-plus"></span></a>
			<ul class="itensClientes">
				<li><a href="./visualizacoes/visualizarCliente.jsp">Visualizar</a></li> <!-- ok -->
				<li><a href="./cadastros/cadastroCliente.jsp">Cadastrar</a></li> <!-- ok -->
				<li><a href="./alteracoes/alterarCliente.jsp">Alterar</a></li> <!-- ok -->
				<li><a href="./exclusoes/excluirCliente.jsp">Excluir</a></li> <!-- ok -->
			</ul>
		</li>
		
		
		<li><a href="#" class="medicamentos">Medicamentos<span class="fa-solid fa-plus"></span></a>
			<ul class="itensMedicamentos">
				<li><a href="./visualizacoes/visualizarMedicamento.jsp">Visualizar</a></li> <!-- ok -->
				<li><a href="./cadastros/cadastroMedicamento.jsp">Cadastrar</a></li> <!-- ok -->
				<li><a href="./alteracoes/alterarMedicamento.jsp">Alterar</a></li> <!-- ok -->
				<li><a href="./exclusoes/excluirMedicamento.jsp">Excluir</a></li> <!-- ok -->
			</ul>
		</li>
		
		
		<li><a href="#" class="aparelhos">Aparelhos<span class="fa-solid fa-plus"></span></a>
			<ul class="itensAparelhos">
				<li><a href="./visualizacoes/visualizarAparelho.jsp">Visualizar</a></li> <!--  -->
				<li><a href="./cadastros/cadastroAparelho.jsp">Cadastrar</a></li> <!-- ok -->
				<li><a href="./alteracoes/alterarAparelho.jsp">Alterar</a></li> <!-- ok -->
				<li><a href="./exclusoes/excluirAparelho.jsp">Excluir</a></li> <!-- ok  -->
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