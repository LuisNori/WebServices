package Modelo;

import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {

	protected final String sURL = "jdbc:mysql://localhost:3306/tipocambio";

	public Conexion() {

	}

	public Connection conectar() {
		Connection con = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(sURL, "root", "n0m3l0");
			System.out.println("Conexion establecida");
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		}
		return con;
	}
}