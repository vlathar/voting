package jsp;

import java.sql.*;
import java.util.ArrayList;

public class M_CandidatePortfolio {

	public boolean updatePortfolio(String email, String phoneno,
			String agenda, String rollno) {

		rollno = rollno.toUpperCase();

		Connection c = null; // connection to the database

		try {
			// connects to the database

			c = MySQL.connect();

			// constructs SQL statement
			String sql = "update candidates set agenda=?, photo=? where rollno ='"
					+ rollno + "';";
			System.out.println(sql);
			PreparedStatement statement = c.prepareStatement(sql);

			statement.setString(1, agenda);

			statement.executeUpdate();

			sql = "update applicants set email ='" + email + "', phoneno ='"
					+ phoneno + "' where rollno = '" + rollno + "';";
			System.out.println(sql);
			Statement st = c.createStatement();
			st.executeUpdate(sql);
			st.close();
			statement.close();

			return true;

		} catch (Exception ex) {
			System.out.println("Error in candidate portfolio updation");
			ex.printStackTrace();
			return false;
		} finally {
			MySQL.close(c);
		}

	}


	public  ArrayList<ArrayList<String> >getCP() {

		Connection c = null;
		Statement st = null;
		ResultSet rs = null;
		ArrayList<ArrayList<String> > r = new ArrayList<ArrayList<String> >();
		// r.add("test");
		try {
			c = MySQL.connect();
			st = c.createStatement();
			String query = "select rollno, eventname from applicants where isapproved = 1";
			System.out.println(query+" M_CP.java");
			rs = st.executeQuery(query);

			while (rs.next()) {
				ArrayList<String>temp = new ArrayList<String>();
				String rollno = rs.getString(1);
				String eventname = rs.getString(2);
				temp.add(rollno);
				temp.add(eventname);
				r.add(temp);
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

	public ArrayList<String> getPD(String rollno,String eventName) {
		Connection c = null;
		Statement st = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		ArrayList<String> r = new ArrayList<String>();
		// r.add("test");
		try {
			c = MySQL.connect();
			st = c.createStatement();
			String query = "select * from applicants where isapproved=1 and rollno = '" + rollno
					+ "' and eventname ='" + eventName +"';" ;
			System.out.println(query+" M_CA.java");
			rs = st.executeQuery(query);
			rsmd = rs.getMetaData();
			int ss = rsmd.getColumnCount();

			int i = 0;
			System.out.println(ss);
			while (rs.next()) {
				while (i < ss) {
					i++;
					String t = rs.getString(i);
					if(t==null)
						t="add some value";
					System.out.println(t);
					if(i==3||i==4)
						continue;
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
	
	
	public ArrayList<String> getCand(String position, int eid){
		Connection c = null;
		Statement st = null;
		ResultSet rs = null;
		ArrayList<String> r = new ArrayList<String>();
		// r.add("test");
		try {
			c = MySQL.connect();
			st = c.createStatement();
			M_ElectionEvent EE = new M_ElectionEvent();
			String eventname = EE.getEE(eid);
			String query = "select name from applicants where appliedforpost ='"+position+"' and eventname ='"+eventname+"';";
			System.out.println(query);
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
		


		
}
	
	
