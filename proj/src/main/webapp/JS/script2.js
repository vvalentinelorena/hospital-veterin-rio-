//scripts das pags iniciais do secretario e do veterinario


//secretarios menu
$('.veterinarios').click(function(){
	$('.menuLateral ul .itensVeterinarios').toggleClass('mostra');
});

$('.auxiliares').click(function(){
	$('.menuLateral ul .itensAuxiliares').toggleClass('mostra');
});

$('.clientes').click(function(){
	$('.menuLateral ul .itensClientes').toggleClass('mostra');
});

$('.medicamentos').click(function(){
	$('.menuLateral ul .itensMedicamentos').toggleClass('mostra');
});

$('.aparelhos').click(function(){
	$('.menuLateral ul .itensAparelhos').toggleClass('mostra');
});


//veterinarios menu
$('.animais').click(function(){
	$('.menuLateral ul .itensAnimais').toggleClass('mostra');
});

$('.alergias').click(function(){
	$('.menuLateral ul .itensAlergias').toggleClass('mostra');
});

$('.consultas').click(function(){
	$('.menuLateral ul .itensConsultas').toggleClass('mostra');
});

$('.internacoes').click(function(){
	$('.menuLateral ul .itensInternacoes').toggleClass('mostra');
});

//--- mostra/fecha os itens do menu ----

$('.btnAbre').click(function(){
	$('.menuLateral').toggleClass('mostra');
});

$('.btnFecha').click(function(){
	$('.menuLateral').toggleClass('mostra');
});


const $menuLateral = $('.menuLateral');
$(document).mouseup(e => {
	if(!$menuLateral.is(e.target)
	&& $menuLateral.has(e.target).length == 0)
	{
		$menuLateral.removeClass('mostra');
	}
});