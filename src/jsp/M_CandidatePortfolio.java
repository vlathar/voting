package jsp;

import java.sql.*;
import java.util.ArrayList;

public class M_CandidatePortfolio {

	public boolean updatePortfolio(String email, String phoneno, byte[] photo,
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

			statement.setBytes(2, photo);
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

	public boolean isCand(String rollno) {

		Connection c = null;
		Statement st = null;
		ResultSet rs = null;
		try {
			c = MySQL.connect();
			st = c.createStatement();
			rollno = rollno.toUpperCase();
			String query = "select * from candidates where rollno ='" + rollno
					+ "';";
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

	public ArrayList<String> getCP() {

		Connection c = null;
		Statement st = null;
		ResultSet rs = null;
		ArrayList<String> r = new ArrayList<String>();
		// r.add("test");
		try {
			c = MySQL.connect();
			st = c.createStatement();
			String query = "select rollno from candidates";
			System.out.println(query+" M_CP.java");
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

	public ArrayList<String> getPD(String rollno) {
		Connection c = null;
		Statement st = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		ArrayList<String> r = new ArrayList<String>();
		rollno=rollno.toUpperCase();
		r.clear();
		// r.add("test");
		try {
			c = MySQL.connect();
			st = c.createStatement();
			String query = "select * from applicants where rollno = '" + rollno
					+ "';";
			System.out.println(query+" M_CP.java");
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
					
					if(i==3)
					if (t.equals("P"))
						t = "President";
					else if (t.equals("VP"))
						t = "Vice President";
					else if (t.equals("GSS"))
						t = "General Secretary Sports";
					else if (t.equals("GSST"))
						t = "General Secretary Science and Technology";
					else if (t.equals("GSC"))
						t = "General Secretary Cultural";
					
					r.add(t);
				}
			}

			query = "select * from candidates where rollno = '" + rollno + "';";
			System.out.println(query);
			rs = st.executeQuery(query);
			rsmd = rs.getMetaData();
			ss = rsmd.getColumnCount();

			i = 1;
			System.out.println(ss+" M_CP.java");
			while (rs.next()) {
				while (i <= ss) {
					String t = rs.getString(i);
					System.out.println(t);
					i++;
					if (i == 2||i==5||i==6 || i==8)
						continue;
					/*if (t.equals("P"))
						t = "President";
					else if (t.equals("VP"))
						t = "Vice President";
					else if (t.equals("GSS"))
						t = "General Secretary Sports";
					else if (t.equals("GSSC"))
						t = "General Secretary Science and Technology";
					else if (t.equals("GSC"))
						t = "General Secretary Cultural";*/
					r.add(t);
				}
			}

			for(i=0;i<r.size();i++){
				System.out.println(i+"" +r.get(i));
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
	
	public byte[] getImage(String rollno){
		
		byte[] imgData = null ;
		try{
		String req = "" ;
	    Blob img ;
	    
	    Connection conn = MySQL.connect();
	    Statement stmt = conn.createStatement ();
	   
	    // Query
	    req = "Select photo from candidates where rollno = '" + rollno+"'" ;
	   
	    ResultSet rset  = stmt.executeQuery ( req );
	   
	    while (rset.next ())
	    {   
	      img = rset.getBlob(1);
	      imgData = img.getBytes(1,(int)img.length());
	    }   
	   
	    rset.close();
	    stmt.close();
	   
	    return imgData ;
	    
		}catch(Exception e){
			e.printStackTrace();
			return imgData;
			
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
	
	public int getPoints(String cand){
		
		Connection c = null;
		Statement st = null;
		ResultSet rs = null;
		int r= -1;
		// r.add("test");
		try {
			c = MySQL.connect();
			st = c.createStatement();
			M_CandidatureApplication CA = new M_CandidatureApplication();
			String rollno = CA.getRollno(cand);
			String query = "select points from candidates where rollno ='"+rollno+"';";
			System.out.println(query);
			rs = st.executeQuery(query);

			while (rs.next()) {
				r=rs.getInt(1);
				
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
	
	
	public void setPoints(String cand,int points){
		Connection c = null;
		Statement st = null;
		// r.add("test");
		try {
			c = MySQL.connect();
			st = c.createStatement();
			M_CandidatureApplication CA = new M_CandidatureApplication();
			String rollno = CA.getRollno(cand);
			String query = "update candidates set points = "+points+" where rollno ='"+rollno+"';";
			System.out.println(query);
			st.executeUpdate(query);
			st.close();
			

		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			MySQL.close(c);
		}


		
	}
	
	
	
	
}
