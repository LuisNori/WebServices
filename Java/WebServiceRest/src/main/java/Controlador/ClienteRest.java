package Controlador;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import Modelo.Peticion;

public class ClienteRest {

	private String url;
	private String contextPath;

	public ClienteRest(String url, String contextPath) {
		this.url = url;
		this.contextPath = contextPath;
	}

	public Peticion getWebService(String fechai,String fechaf) {
		Peticion result = null;
		try {
			WebTarget client = createClient(
					"datos/" + fechai + "/" + fechaf + "?token=df47961457d1a0a5cd56732503a93ad1d511df360f9fdfba86daef99a71dced7");
			Response response = client.request(MediaType.APPLICATION_JSON).get();
			Integer status = response.getStatus();
			if (Status.OK.getStatusCode() == status) {
				result = response.readEntity(Peticion.class);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		return result;
	}

	protected WebTarget createClient(String path) {
		String assembledPath = assembleEndpoint(path);
		System.out.println("Ruta: " + assembledPath);
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target(assembledPath);
		return target;
	}

	private String assembleEndpoint(String path) {
		String endpoint = url.concat(contextPath).concat(path);
		System.out.println("Calling endpoint " + endpoint);
		return endpoint;
	}
}
