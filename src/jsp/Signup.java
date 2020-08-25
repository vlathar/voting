package jsp;

import java.sql.*;

public class Signup {
	public static boolean signupuser(String rollno, String name, String cgpa, String batch, String gender, String email, String mobile, String password) {
		String sqlQuery = null;
		Connection con = null;
		PreparedStatement pst = null;
		try {
			sqlQuery = "insert into students (rollno,name,cgpa,batch,gender,email,mobile,password,verified) values(?,?,?,?,?,?,?,?,?)";
			int verified=1;
			con = MySQL.connect();
			pst = con.prepareStatement(sqlQuery);
			pst.setString(1,rollno);
			pst.setString(2,name);
			pst.setString(3,cgpa);
			pst.setString(4,batch);
			pst.setString(5,gender);
			pst.setString(6,email);
			pst.setString(7,mobile);
			pst.setString(8, password);
			pst.setInt(9, verified);
			int i = pst.executeUpdate();
			if(i!=0) {
				System.out.println("message at signup.java:student registered into database");
				Statement st = con.createStatement();
				sqlQuery = "insert into login values('" + rollno + "' , '" + password + "');";
				System.out.println(sqlQuery+":Signup.java");
				st.executeUpdate(sqlQuery);
				return true;
			}
			else {
				System.out.println("message at signup.java:student not registered into database due to some issue");
				return false;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
