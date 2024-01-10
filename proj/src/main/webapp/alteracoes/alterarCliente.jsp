<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
    
<%
	//---------------------------------------
	// Conexão com o banco de dados
	//---------------------------------------
	
	String banco, usuario, senha;
	
	Connection conexaoBD = null;
	PreparedStatement cmdSQL = null;
	ResultSet rsSet = null;
	
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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Alterar - Cliente</title>
<link href="../CSS/estilo3.css" rel="stylesheet" type="text/css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.maskedinput/1.4.1/jquery.maskedinput.min.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.0/jquery.mask.js"></script>
		
		<script type="text/javascript">
			jQuery( function($){
			    $(".telefone").mask("(99) 9999-99999");
			    //$(".cpf").mask("000.000.000-00" {reverse: true});
			    $(".telefone").blur(function(event) {
			        if($(this).val().length == 16){
			          $('.telefone').mask('(99) 99999-9999' );
			        } else {
			          $('.telefone').mask('(99) 9999-99999');
			        }
			    });
			});
			
			
		</script>
		
		<script type="text/javascript">
		
		$(document).ready(function () { 
	        $(".cpf").mask('000.000.000-00', {reverse: true});
	    });
			
			
		</script>
		
</head>
<body>

<h1>Alterar Cliente</h1>
<hr><br>
       <form action="alterarCliente.jsp">
        <br><br><b>Indique o Id do cliente que sofrerá alteção: </b>
        <p>
        <input type="number" name="txtIdCliente" min=1>
        </p>
        <p>
        <input type="submit" value="Pesquisar">
        </p>
        	<%
        	
        	String nome = "";
        	String cpf = "";
        	String dataNas = "";
        	String tel = "";
        	String contato = "";
        	
        	String idCliente = request.getParameter("txtIdCliente");
        	if (idCliente == null || idCliente.isEmpty() || idCliente == "" ){
        		out.println("<p class='aviso'>Preencha os campos de identificação</p>");
        	}else{
        	
    		try{
    			
    				cmdSQL = conexaoBD.prepareStatement("Select * From cliente WHERE numCadastro = " + idCliente);
    								
    				rsSet = cmdSQL.executeQuery();
    								
    		if(rsSet.next()){
 					
    			do{
    				nome = (String) rsSet.getString("nome");
    				cpf = (String) rsSet.getString("cpf");
    				dataNas = (String) rsSet.getString("dataNas");
    				tel = (String) rsSet.getString("telefone");
    				contato = (String) rsSet.getString("contato");
    				
    								
    											
    			}while(rsSet.next());	
    				
    				
    			}
    		
    		
    		else{
    			out.println("<p class='aviso'>Nenhum dado foi encontrado</p>");
    			
    			}
    								
    		}
    		catch(Exception ex){
    			out.println("<h3>Erro: " + ex.getMessage()  + "</h3>");
    			return;
    		}
        	}
        	%>
        	</form>
        	 <form action="../processamento/clientecrud.jsp" method="GET">
        	 
        	 
        	<p>
   			ID Cliente <input name="txtNumCadastro" type="text" readonly value= "<%= idCliente %>" > 
   			</p>
          <p>
            Nome <input type="text" maxlength="100" name="txtNome"  value = "<%= nome %>" />            
           	</p> 
           	 <p>
            CPF <input type="text" maxlength="15" name="txtCpf" class="cpf" placeholder="000.000.000-00" value = "<%= cpf %>" />            
           	</p> 
           	 <p>
            Data de nascimento <input type="date" maxlength="15" name="txtDataNas" min="1900-12-31" max="2023-12-31" value = "<%= dataNas %>" />            
           	</p> 
           	 <p>
            Telefone <input type="text" maxlength="15" name="txtTelefone" class="telefone" placeholder="(99) 9999-99999" value = "<%= tel %>" />            
           	</p> 
           	 <p>
            Contato <input type="text" maxlength="15" name="txtContato" class="telefone" placeholder="(99) 9999-99999" value = "<%= contato %>" />            
           	</p>     
           
            <input type="submit" name="btnOperacao" value="Alterar"  />  
            <input type="submit" name="btnOperacao" value="Voltar"  />                       
            <hr>
        </form>

</body>
</html>