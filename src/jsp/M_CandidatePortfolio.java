package jsp;

import java.sql.*;
import java.util.ArrayList;

public class M_CandidatePortfolio {

	public boolean isCand(String rollno, String eventname) {

		Connection c = null;
		Statement st = null;
		ResultSet rs = null;
		try {
			c = MySQL.connect();
			st = c.createStatement();
			rollno = rollno.toUpperCase();
			String query = "select * from candidate where rollno ='" + rollno
					+"' and eventname = '" + eventname + "';";
			System.out.println(query);
			rs = st.executeQuery(query);
			if (rs.absolute(1)) {

				rs.close();
				st.close();
				return true;
			} else {
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

	public boolean deleteCN(String rollno, String eventName) {
		Connection c = null;
		try {
			c = MySQL.connect();
			Statement st = c.createStatement();
			String query = "delete from candidate where rollno = '" + rollno
					+ "' and eventname ='" + eventName +"';" ;
			String query1 = "delete from applicants where isapproved=1 and rollno = '" + rollno
					+ "' and eventname ='" + eventName +"';" ;
			st.executeUpdate(query);
			st.executeUpdate(query1);
			st.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
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
	
	
