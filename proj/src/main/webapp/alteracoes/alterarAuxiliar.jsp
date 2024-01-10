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
<title>Alterar - Auxiliar</title>
<link href="../CSS/estilo3.css" rel="stylesheet" type="text/css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.maskedinput/1.4.1/jquery.maskedinput.min.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.0/jquery.mask.js"></script>
		
        <script type="text/javascript">
		
		$(document).ready(function () { 
	        $(".HorarioTrabalho").mask('99h às 99h');
	    });
		</script>
		
		

		
</head>
<body>

<h1>Alterar Auxiliar</h1>
<hr><br>
        <form action="alterarAuxiliar.jsp">
        <br><br><b>Indique o Id do estudante auxiliar que sofrerá alteção: </b>
        
        <p>
        Id Auxiliar: <input type="number" name="txtIdAuxiliar" min=1>
        </p>
        <p>
        <input type="submit" value="Pesquisar">
        </p>
        	<%
        	
        	String nomepreenche = "";
        	String faculpreenche = "";
        	String periodopreenche = "";
        	String horarioPreenche = "";
        	
        	String idAuxiliar = (String) request.getParameter("txtIdAuxiliar");
        	
        	if (idAuxiliar == null || idAuxiliar.isEmpty() || idAuxiliar == "" ){
        		out.println("<p class='aviso'>Preencha os campos de identificação</p>");
        	}else{
        		
    		try{
    			
    				cmdSQL = conexaoBD.prepareStatement("Select * From estudante_auxiliar WHERE numCadastro = " + idAuxiliar);
    								
    				rsSet = cmdSQL.executeQuery();
    								
    		if(rsSet.next()){					
    			do{
    				nomepreenche = (String) rsSet.getString("nome");
    				faculpreenche = (String) rsSet.getString("faculdade");
    				periodopreenche = (String) rsSet.getString("periodoFaculdade");
    				horarioPreenche = (String) rsSet.getString("horarioTrabalho");
    								
    											
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
        	
        	//String[] splithora2 = splitespaco[2].split("h");
        	
        	
        	%>
        	</form>
        	<form action="../processamento/auxiliarcrud.jsp" method="GET">
        	<p>
   			ID Auxiliar <input name="txtId" readonly value= "<%= idAuxiliar %>" > 
   			</p>
          <p>
            Nome <input type="text" maxlength="100" name="txtNome"  value= "<%= nomepreenche %>"/>            
           	</p> 
           	 <p>
            Faculdade <input type="text" maxlength="50" name="txtFaculdade" value = "<%= faculpreenche %>" />            
           	</p> 
           	 <p>
            Período faculdade <input type="text" maxlength="150" name="txtPeriodo" value="<%= periodopreenche %>"/>
                 
           	</p> 
           	 <p>
            Horario de trabalho <input type="text" maxlength="45" name="txtHorarioTrabalho" class="HorarioTrabalho" value= "<%=horarioPreenche %>" />            
           	</p>       
           
            <input type="submit" name="btnOperacao" value="Alterar"  />  
            <input type="submit" name="btnOperacao" value="Voltar"  />                       
            <hr>
        </form>
        
     

</body>
</html>