package jsp;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class Voter {

	public static boolean validate(String username, String password) {

		Connection c = null;
		ResultSet rs = null;
		Statement st = null;
		try {
			c = MySQL.connect();
			st = c.createStatement();
			rs = st.executeQuery("select * from anonymous where username='"
					+ username + "' and password='" + password + "'");
			String uname = "", pass = "";
			if (rs.next()) {
				uname = rs.getString("username");
				pass = rs.getString("password");
			}
			rs.close();
			st.close();
			if (username.equalsIgnoreCase("") && password.equals("")) {
				return false;
			}

			else if (username.equalsIgnoreCase(uname) && password.equals(pass)) {
				return true;

			} else if (!username.equalsIgnoreCase(uname)
					&& !password.equals(pass)) {
				return false;
			} else
				return false;
			

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			
			MySQL.close(c);
		}

		return false;

	}

}

