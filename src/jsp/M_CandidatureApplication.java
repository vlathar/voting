package jsp;

import java.sql.*;
import java.util.ArrayList;

public class M_CandidatureApplication {

	public int getBatch(String rollno) {
		rollno = rollno.toUpperCase();
		Connection c = null;
		Statement st = null;
		ResultSet rs = null;
		int batch = 0;

		try {

			c = MySQL.connect();
			st = c.createStatement();
			String query = "select batch from students where rollno ='"
					+ rollno + "';";
			System.out.println(query+" M_CA.java");
			rs = st.executeQuery(query);

			while (rs.next()) {
				batch = rs.getInt(1);
			}

			rs.close();
			st.close();
			return batch;

		} catch (Exception e) {

			e.printStackTrace();
			return batch;

		} finally {
			MySQL.close(c);
		}

	}

	public double getcgpa(String rollno) {
		rollno = rollno.toUpperCase();
		Connection c = null;
		Statement st = null;
		ResultSet rs = null;
		double cgpa = 0.0;

		try {

			c = MySQL.connect();
			st = c.createStatement();
			String query = "select cgpa from students where rollno ='" + rollno
					+ "';";
			System.out.println(query+" M_CA.java");
			rs = st.executeQuery(query);

			while (rs.next()) {
				cgpa = rs.getDouble(1);
			}

			rs.close();
			st.close();
			return cgpa;

		} catch (Exception e) {

			e.printStackTrace();
			return cgpa;

		} finally {
			MySQL.close(c);
		}

	}

	public boolean createAP(String EventName, String position, String rollno,
			String name, String email, String phoneno, String gender) {
		Connection c = null;
		Statement st = null;
		rollno=rollno.toUpperCase();
		try {
			c = MySQL.connect();
			st = c.createStatement();
			String query = "insert into applicants values ('" + EventName
					+ "','" + position + "',0,'" + rollno + "','" + name
					+ "','" + email + "','" + phoneno + "','" + gender + "');";
			System.out.println(query+" M_CA.java");
			st.executeUpdate(query);

			st.close();
			return true;

		} catch (Exception e) {

			e.printStackTrace();
			return false;
		} finally {

			MySQL.close(c);
		}

	}

	public ArrayList<String> getCA() {

		Connection c = null;
		Statement st = null;
		ResultSet rs = null;
		ArrayList<String> r = new ArrayList<String>();
		// r.add("test");
		try {
			c = MySQL.connect();
			st = c.createStatement();
			String query = "select rollno from applicants";
			System.out.println(query+" M_CA.java");
			rs = st.executeQuery(query);

			while (rs.next()) {
				String t = rs.getString(1);
				System.out.println(t);
				r.add(t);
			}

			rs.close();
			st.close();
			return r;

		} catch (Exception e) {
			e.printStackTrace();
			return r;
		} finally {
			MySQL.close(c);
		}
	}

	public ArrayList<String> getAD(String rollno) {
		Connection c = null;
		Statement st = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		ArrayList<String> r = new ArrayList<String>();
		// r.add("test");
		try {
			c = MySQL.connect();
			st = c.createStatement();
			String query = "select * from applicants where rollno = '" + rollno
					+ "';";
			System.out.println(query+" M_CA.java");
			rs = st.executeQuery(query);
			rsmd = rs.getMetaData();
			int ss = rsmd.getColumnCount();

			int i = 1;
			System.out.println(ss);
			while (rs.next()) {
				while (i <= ss) {
					String t = rs.getString(i);
					System.out.println(t);
					i++;
					if (i == 4 || i == 5)
						continue;
					if (t.equals("P"))
						t = "President";
					else if (t.equals("VP"))
						t = "Vice President";
					else if (t.equals("GSS"))
						t = "General Secretary Sports";
					else if (t.equals("GSSC"))
						t = "General Secretary Science and Technology";
					else if (t.equals("GSC"))
						t = "General Secretary Cultural";
					r.add(t);
				}
			}

			rs.close();
			st.close();
			return r;

		} catch (Exception e) {
			e.printStackTrace();
			return r;
		} finally {
			MySQL.close(c);
		}

	}

	public boolean approve(String rollno) {
		Connection c = null;
		Statement st = null;
		try {
			c = MySQL.connect();
			st = c.createStatement();
			rollno = rollno.toUpperCase();
			String query = "update applicants set isapproved = 1 where rollno ='"
					+ rollno + "';";
			System.out.println(query+" M_CA.java");
			st.executeUpdate(query);
			query = "insert into candidates (rollno, haswon) values ('"
					+ rollno + "',0);";
			System.out.println(query+" M_CA.java");
			st.executeUpdate(query);
			st.close();
			return true;

		} catch (Exception e) {

			e.printStackTrace();
			return false;

		} finally {

			MySQL.close(c);
		}

	}
	public boolean isApplicant(String rollno) {

		Connection c = null;
		Statement st = null;
		ResultSet rs = null;
		try {
			c = MySQL.connect();
			st = c.createStatement();
			rollno = rollno.toUpperCase();
			String query = "select * from applicants where rollno ='" + rollno
					+ "';";
			System.out.println(query+" M_CA.java");
			rs = st.executeQuery(query);
			if (rs.absolute(1)) {
				
				rs.close();
				st.close();
				return true;
			}
			else{
				rs.close();
				st.close();
				return false;
				
			}
			
			
			

		} catch (Exception e) {

			e.printStackTrace();
			return false;

		} finally {

			MySQL.close(c);
		}

	}

	public boolean deleteAP(String rollno) {

		Connection c = null;
		try {
			c = MySQL.connect();
			Statement st = c.createStatement();
			String query = "delete from applicants where rollno = '" + rollno
					+ "'";
			System.out.println(query+" M_CA.java");
			st.executeUpdate(query);
			st.close();
			return true;

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {

			MySQL.close(c);
		}

	}
	
	public String getRollno(String name){
		Connection c = null;
		Statement st = null;
		ResultSet rs = null;
		String rollno = null;
		try {
			c = MySQL.connect();
			st = c.createStatement();
			String query = "select rollno from applicants where name ='" + name
					+ "';";
			System.out.println(query+" M_CA.java");
			rs = st.executeQuery(query);
			while(rs.next()){
				rollno= rs.getString(1);
				
			}
			
			rs.close();
			st.close();
			return rollno;
			

		} catch (Exception e) {

			e.printStackTrace();
			return rollno;

		} finally {

			MySQL.close(c);
		}

	}

	
}
