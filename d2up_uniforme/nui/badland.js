$(function() {
	// init();
  
	var actionContainer = $(".actionmenu");
  
	window.addEventListener("message", function(event) {
	  var item = event.data;
  
	  if (item.showmenu) {
		requestClock(item.clothes,item.qtd,item.tipo,item.clothename)
		$('body').css('background-color', 'rgba(0, 0, 0, 0.15)')
		actionContainer.fadeIn();
	  }
  
	  if (item.hidemenu) {
		$('body').css('background-color', 'transparent')
		actionContainer.fadeOut();
	  }
	});
  
	document.onkeyup = function(data) {
	  if (data.which == 27) {
		$('body').css('background-color', 'transparent')
		actionContainer.fadeOut();
		$('.contentContainer').html(``)
		$.post("http://d2up_uniforme/fechar", JSON.stringify({}));
	  }
	};
});

function requestClock(data,qtd,tipo,clothename) {
	$('.titleContainer').html(`<p>${clothename} </p>`)
	for (x = 0;x <= qtd - 1;x++) {
		$('.contentContainer').append(`
			<div class="itemCard">
				<div class="cardAlign">
					<div class="itemImage">
						<img id="image" src="${data[x].img}">
					</div>
				</div>
				<div class="imageHoverDetails">
					<div class="itemTitle">
						<p class="text"> ${data[x].name} </p>
						<div id="doTheAction" class="menuoption" data-clothe="${x}" data-tipo='${tipo}' data-action="vestir"><span>COLOCAR</span></div>
					</div>
				</div>
			</div>
		`)
	}
}
  
$(document).on("click", ".menuoption", function () {
	if ($(this).attr("data-action")) {
		var data = $(this).attr("data-clothe")
		var tipo = $(this).attr("data-tipo")
		$(this).click(function() {
			$.post("http://d2up_uniforme/vestir", JSON.stringify({
				index: data,
				tipo: tipo,
			}));
			$('.contentContainer').html(``)
		});
	}
});

$(document).on("click", ".menuoption-tirar", function () {
	$('.contentContainer').html(``)
	$.post("http://d2up_uniforme/tirar", JSON.stringify({}));
});