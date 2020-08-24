package jsp;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
public class M_CandidatureApplication {

	public String getBatch(String rollno) {
		rollno = rollno.toUpperCase();
		Connection c = null;
		Statement st = null;
		ResultSet rs = null;
		String batch = "";

		try {

			c = MySQL.connect();
			st = c.createStatement();
			String query = "select batch from students where rollno ='"
					+ rollno + "';";
			System.out.println(query+" M_CA.java");
			rs = st.executeQuery(query);

			while (rs.next()) {
				batch = rs.getString(1);
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
	public String getBatch(String eventname, String position) {
		Connection c = null;
		Statement st = null;
		ResultSet rs = null;
		String temp = "";
		M_ElectionEvent me = new M_ElectionEvent();
		int eid = me.getEEId(eventname);
		try {

			c = MySQL.connect();
			st = c.createStatement();
			String query = "select allowedcandidate from positions where eid ="
					+ eid + " and position ='" + position + "';";
			System.out.println(query+" M_CA.java");
			rs = st.executeQuery(query);
			while (rs.next()) {
				 temp = rs.getString(1);
				System.out.println("temp:---------------"+temp);
			}
			rs.close();
			st.close();
			return temp;
		} catch (Exception e) {
			e.printStackTrace();
			return temp;
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

	public boolean createAP(String EventName, String position, String rollno, String agenda, String points) {
		Connection c = null;
		Statement st = null;
		rollno=rollno.toUpperCase();
		try {
			c = MySQL.connect();
			st = c.createStatement();
			String query = "insert into applicants values ('" + EventName + "','" + position + "',0,'" + rollno + "','"+ agenda + "','"+ points + "');";
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
			String query = "select rollno from applicants where isapproved=0";
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

	public ArrayList<String> getAD(String rollno,String eventName) {
		Connection c = null;
		Statement st = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		ArrayList<String> r = new ArrayList<String>();
		try {
			c = MySQL.connect();
			st = c.createStatement();
			String query = "select * from applicants where rollno = '" + rollno
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

	public boolean approve(String rollno,String eventName, String position) {
		Connection c = null;
		Statement st = null;
		try {
			c = MySQL.connect();
			st = c.createStatement();
			rollno = rollno.toUpperCase();
			String query = "update applicants set isapproved = 1 where rollno ='"
					+ rollno + "' and eventname ='" + eventName +"';" ;
			System.out.println(query+" M_CA.java");
			st.executeUpdate(query);
			query = "insert into candidate (rollno, eventname, position, votecount) values ('"
					+ rollno +"', '" + eventName +"', '" + position + "',0);";
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
	public boolean reject(String rollno,String EventName) {
		Connection c = null;
		Statement st = null;
		try {
			c = MySQL.connect();
			st = c.createStatement();
			rollno = rollno.toUpperCase();
			String query = "delete from applicants where rollno ='"
					+ rollno + "' and eventname ='" + EventName +"';" ;
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

	public boolean deleteAP(String rollno,String eventName) {

		Connection c = null;
		try {
			c = MySQL.connect();
			Statement st = c.createStatement();
			String query = "delete from candidate where rollno = '" + rollno
					+ "' and eventname ='" + eventName +"';" ;
			String query1 = "delete from applicants where isapproved=1 and rollno = '" + rollno
					+ "' and eventname ='" + eventName +"';" ;
			st.addBatch(query);
			st.addBatch(query1);
			//System.out.println(query+" M_CA.java");
			st.executeBatch();
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
	
	public static Map< String,ArrayList<String> > getApplications(int choice)
    {
		Connection c = null;
		Statement st = null;
		ResultSet rs = null;
		String rollno;
		String eventname;
		Map < String,ArrayList<String> > applications=new HashMap< String,ArrayList<String> >();
		try {
			c = MySQL.connect();
			st = c.createStatement();
			String query = "select eventname,rollno from applicants where isapproved = "+choice;
			System.out.println(query);
			rs = st.executeQuery(query);
			while(rs.next()){
				eventname=rs.getString(1);
				rollno= rs.getString(2);
				if(applications.containsKey(eventname))
				{
					applications.get(eventname).add(rollno);
				}
				else
				{
					applications.put(eventname,new ArrayList<String>());
					applications.get(eventname).add(rollno);
				}		
			}
		
			rs.close();
			st.close();
			return applications;

		}
		catch (Exception e) {
			e.printStackTrace();
			return applications;
		}
		finally {
			MySQL.close(c);
		}

   
    }
	
}
