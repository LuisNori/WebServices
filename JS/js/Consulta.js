function consultar(id){
	if(id == "cdolar"){
		$.ajax({
			url : 'https://www.banxico.org.mx/SieAPIRest/service/v1/series/SF43786/datos/oportuno?token=df47961457d1a0a5cd56732503a93ad1d511df360f9fdfba86daef99a71dced7',
			jsonp : 'callback',
			dataType : 'jsonp',
			success : function(response) {
				var series=response.bmx.series;
				for (var i in series) {
					  var serie=series[i];
					  var reg= serie.datos[0].fecha+'= '+serie.datos[0].dato;
					  $('#cdolar').append(reg);
				}
			}
		});
	}else if(id == "ceuro"){
		$.ajax({
			url : 'https://www.banxico.org.mx/SieAPIRest/service/v1/series/SF46410/datos/oportuno?token=df47961457d1a0a5cd56732503a93ad1d511df360f9fdfba86daef99a71dced7',
			jsonp : 'callback',
			dataType : 'jsonp',
			success : function(response) {
				var series=response.bmx.series;
				for (var i in series) {
					  var serie=series[i];
					  var reg= serie.datos[0].fecha+'= '+serie.datos[0].dato;
					  $('#ceuro').append(reg);
				}
			}
		});
	}else{
		$.ajax({
			url : 'https://www.banxico.org.mx/SieAPIRest/service/v1/series/SF46407/datos/oportuno?token=df47961457d1a0a5cd56732503a93ad1d511df360f9fdfba86daef99a71dced7',
			jsonp : 'callback',
			dataType : 'jsonp',
			success : function(response) {
				var series=response.bmx.series;
				for (var i in series) {
					  var serie=series[i];
					  var reg= serie.datos[0].fecha+'= '+serie.datos[0].dato;
					  $('#clibra').append(reg);
				}
			}
		});
	}
};