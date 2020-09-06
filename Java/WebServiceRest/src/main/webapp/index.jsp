<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="Modelo.*,Controlador.ClienteRest,java.sql.*,java.util.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TIpo de cambio</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
<link rel="stylesheet" href="css/style.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<h1>Tipos de cambios</h1>
	<h2>Se guardaran los valores de los 3 meses anteriores al mes mas
		antiguo guardado, en caso de no tener registros se tomara a partir del
		mes de hoy.</h2>
	<center>
		<table>
			<tr>
				<td><center>Dolar</center></td>
				<td><center>Euro</center></td>
				<td><center>Libra Esterlina</center></td>
			</tr>
			<tr>
				<td>
					<center>
						<img id="img_dolar" src="img/dolar.jpg" />
					</center>
				</td>
				<td>
					<center>
						<img id="img_euro" src="img/euro.jpg" />
					</center>
				</td>
				<td>
					<center>
						<img id="img_libra" src="img/libra.png" />
					</center>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<form action="index.jsp" method="get">
						Moneda a guardar y consultar: <select name="moneda">
							<option value="1">Dolar</option>
							<option value="2">Euro</option>
							<option value="3">Libra Esterina</option>
						</select> <input type="submit" value="Consultar">
						<div name="error">${values}</div>
					</form>
				</td>
				<%
					String values = "";
				String opcion = request.getParameter("moneda");
				System.out.println(opcion);
				String clave = "";
				if (opcion != null) {
					switch (opcion) {
					case "1":
						clave = "SF57805/";
						break;
					case "2":
						clave = "SF57923/";
						break;
					case "3":
						clave = "SF57815/";
						break;
					}
					ClienteRest cr = new ClienteRest("https://www.banxico.org.mx/SieAPIRest/service/v1/series/", clave);
					Conexion c = new Conexion();
					Connection cn = c.conectar();
					String sql = "SELECT * FROM tipodecambio WHERE tipodemoneda = " + opcion + " order by 2 desc";
					PreparedStatement ps = cn.prepareStatement(sql);
					ResultSet rs = ps.executeQuery(sql);
					String date = "";
					while (rs.next()) {
						date = rs.getString(2);
					}
					System.out.println("Date:" + date);
					String fechaw[] = date.split("-");
					if (!date.equals("")) {
						int mesaux = Integer.parseInt(fechaw[1]);
						int anioaux = Integer.parseInt(fechaw[0]);
						int anioaux2 = Integer.parseInt(fechaw[0]);
						int mes3 = mesaux - 3;
						int mes4 = mesaux;
						String mes2 = "";
						String mes5 = "";
						if (mes3 <= 0) {
					mes3 += 12;
					anioaux--;
						}
						if (mes3 < 10) {
					mes2 = "0" + mes3;
						} else {
					mes2 = "" + mes3;
						}
						if (mes4 < 10) {
					mes5 = "0" + mes4;
						} else {
					mes5 = "" + mes4;
						}
						String fechafin = anioaux2 + "-" + mes5 + "-01";
						String fechain = anioaux + "-" + mes2 + "-01";
						System.out.println(fechafin);
						Peticion p = cr.getWebService(fechain, fechafin);
						List a = p.getBmx().getSeries();
						String valor = "";
						for (int i = 0; i < a.size(); i++) {
					valor = String.valueOf(a.get(i));
					System.out.println(valor);
						}
						String datos = valor.substring(valor.indexOf("datos"));
						System.out.println(datos);
						datos = datos.replace("datos=[{", "");
						datos = datos.replace("fecha=", "");
						datos = datos.replace("dato=", "");
						datos = datos.replace("{", "");
						datos = datos.replace("}", "");
						datos = datos.replace("]", "");
						datos = datos.replace(" ", "");
						System.out.println(datos);
						String insert = "INSERT INTO tipodecambio VALUES(?,?,?)";
						ps = cn.prepareStatement(insert);
						String valores[] = datos.split(",");
						for (int j = 0; j < 3; j++) {
							String daaux[] = valores[j*2].split("/");
							String dat = daaux[2] + "-" + daaux[1] + "-" + daaux[0];
							double dato = Double.parseDouble(valores[(j*2) + 1]);
							String insert2 = "INSERT INTO tipodecambio VALUES(" + opcion +",'" + dat + "'," + dato +")";
							ps = cn.prepareStatement(insert2);
							ps.executeUpdate();
							
						}
					} else {
						java.util.Date d = new java.util.Date();
						String strDateFormat = "YYYY-MM-dd";
						SimpleDateFormat format = new SimpleDateFormat(strDateFormat);
						String fecha = format.format(d);
						System.out.println(fecha);
						String arreglo[] = fecha.split("-");
						String mes2 = "";
						int mesaux = Integer.parseInt(arreglo[1]);
						int anioaux = Integer.parseInt(arreglo[0]);
						int mes3 = mesaux - 3;
						if (mes3 <= 0) {
					mes3 += 12;
					anioaux--;
						}
						if (mesaux < 10) {
					mes2 = "0" + mes3;
						} else {
					mes2 = "" + mes3;
						}
						String fechafin = arreglo[0] + "-" + arreglo[1] + "-01";
						String fechain = anioaux + "-" + mes2 + "-01";
						System.out.println(fechafin);
						Peticion p = cr.getWebService(fechain, fechafin);
						List a = p.getBmx().getSeries();
						String valor = "";
						for (int i = 0; i < a.size(); i++) {
					valor = String.valueOf(a.get(i));
					System.out.println(valor);
						}
						String datos = valor.substring(valor.indexOf("datos"));
						System.out.println(datos);
						datos = datos.replace("datos=[{", "");
						datos = datos.replace("fecha=", "");
						datos = datos.replace("dato=", "");
						datos = datos.replace("{", "");
						datos = datos.replace("}", "");
						datos = datos.replace("}]}", "");
						datos = datos.replace("]", "");
						datos = datos.replace(" ", "");
						System.out.println(datos);
						String valores[] = datos.split(",");
						System.out.println(valores[0]);
						for (int j = 0; j < 3; j++) {
					String daaux[] = valores[j*2].split("/");
					String dat = daaux[2] + "-" + daaux[1] + "-" + daaux[0];
					double dato = Double.parseDouble(valores[(j*2) + 1]);
					String insert = "INSERT INTO tipodecambio VALUES(" + opcion +",'" + dat + "'," + dato +")";
					ps = cn.prepareStatement(insert);
					ps.executeUpdate();
						}
					}
					String consulta = "SELECT * FROM tipodecambio WHERE tipodemoneda = " + opcion;
					ps = cn.prepareStatement(consulta);
					rs = ps.executeQuery();
					String x = "";
					int y = Integer.parseInt(opcion);
					switch (y) {
					case 1:
						x = "Dolar";
						break;
					case 2:
						x = "Euro";
						break;
					case 3:
						x = "Libra esterlina";
						break;
					}
					values = "Moneda: " + x;
					while (rs.next()) {
						values += " Fecha: " + rs.getString(2) + ", Valor: " + rs.getDouble(3) + "\n";
					}
				}
				%>
			</tr>
		</table>
	</center>
	<%=values%>;
</body>
</html>