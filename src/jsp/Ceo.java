package jsp;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class Ceo {

	public static boolean validate(String username, String password) {

		Connection c = null;
		ResultSet rs = null;
		Statement st = null;
		try {
			c = MySQL.connect();
			st = c.createStatement();
			password="md5('"+password+"')";
			rs = st.executeQuery("select * from voting.admin where username='"
					+ username + "' and password=" + password + ";");
			String uname = "", pass = "";
			if (rs.next()) {
				uname = rs.getString("username");
				pass = rs.getString("password");
			}
			rs = st.executeQuery("Select "+password+";");
			//String password2="";
			if(rs.next())
			{
				password=rs.getString(password);
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
