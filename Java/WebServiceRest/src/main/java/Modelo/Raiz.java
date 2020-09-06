package Modelo;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Raiz {
	@JsonProperty("series")
	private List series;
	
	@JsonProperty("idSerie")
	private String idSerie;
	
	@JsonProperty("datos")
	private List datos;

	public List getSeries() {
		return series;
	}

	public void setSeries(List series) {
		this.series = series;
	}

	public String getIdSerie() {
		return idSerie;
	}

	public void setIdSerie(String idSerie) {
		this.idSerie = idSerie;
	}

	public List getDatos() {
		return datos;
	}

	public void setDatos(List datos) {
		this.datos = datos;
	}
	

	
}
