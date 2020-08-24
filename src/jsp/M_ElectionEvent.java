package jsp;

import java.sql.*;
//import java.util.Date;
//import java.text.DateFormat;
//import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class M_ElectionEvent {

	public boolean createEE(String EE, java.sql.Date date,
			java.sql.Time startTime, java.sql.Time endTime,
			ArrayList<String> positions,ArrayList<String> AllowedC,ArrayList<String> A_Batch) {

		Connection c = null;
		ResultSet rs = null;
		Statement st = null;
		try {
			c = MySQL.connect();
			st = c.createStatement();
			String query = "insert into electionevent values (null,'" + EE
					+ "','" + date + "','" + startTime + "','" + endTime
					+ "');";
			System.out.println(query);
			st.executeUpdate(query);

			query = "select LAST_INSERT_ID()";
			if (c != null) {
				st = c.createStatement();
				rs = st.executeQuery(query);
			}

			int eid = 0;

			while (rs.next())
				eid = rs.getInt(1);
			if(positions.size()==AllowedC.size()) System.out.println("same size");
			for (int i=0;i<positions.size();i++) {

				if ((positions.get(i).equals("President") || positions.get(i).equals("Vice-President")
						|| positions.get(i).equals("G.Sec"))&&
						(!AllowedC.get(i).equals("null"))&&(!A_Batch.get(i).equals("null")))
					query = "insert into positions values (" + eid + ",'"
							+ positions.get(i) + "','"+ AllowedC.get(i) +"','"+A_Batch.get(i)+"');";

				else
					query = "insert into positions values (" + eid + ",'"
							+ positions.get(i) + "','" + "all" + "','all');";
				System.out.println(query);

				if (c != null) {
					st = c.createStatement();
					st.executeUpdate(query);
				}

			}

			st.close();
			rs.close();
			return true;

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {

			MySQL.close(c);
		}

	}

	public boolean updateEE(String EE, java.sql.Date date,
			java.sql.Time startTime, java.sql.Time endTime,
			ArrayList<String> positions,ArrayList<String> AllowedCand,ArrayList<String> AB) {

		boolean isdeleted = deleteEE(EE);
		boolean iscreated = false;

		if (isdeleted) {
			iscreated = createEE(EE, date, startTime, endTime, positions,AllowedCand,AB);

			if (iscreated) {
				return true;
			}

			else
				return false;
		}

		else
			return false;
	}

	public boolean deleteEE(String EE) {

		Connection c = null;
		try {
			c = MySQL.connect();
			Statement st = c.createStatement();
			String query = "delete from electionevent where name = '" + EE
					+ "'";
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

	public ArrayList<String> getEE() {

		Connection c = null;
		Statement st = null;
		ResultSet rs = null;
		ArrayList<String> r = new ArrayList<String>();
		// r.add("test");
		try {
			c = MySQL.connect();
			st = c.createStatement();
			String query = "select name from electionevent";
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
	public int getEEId(String str) {

		Connection c = null;
		Statement st = null;
		ResultSet rs = null;
		int r = 0;
		// r.add("test");
		try {
			c = MySQL.connect();
			st = c.createStatement();
			String query = "select eid from electionevent where name='"+str+"'";
			System.out.println(query);
			rs = st.executeQuery(query);

			 while(rs.next()) {
				String t = rs.getString(1);
				System.out.println(t);
				r=Integer.parseInt(t);
				//r.add(t);
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

	public static ArrayList<String> getEvents(String batch)
	{
		ArrayList<String> alist=new ArrayList<String>();
		//String alwdbatch="all";

		Connection c = null;
		Statement st = null;
		ResultSet rs = null;
		String r=null ;
	
		try
		{
			c = MySQL.connect();
			st = c.createStatement();
			String query = "select distinct e.name from positions p,electionevent e where "
					+ "allowedcandidate = '"+batch+"' or allowedcandidate = 'all' and e.eid=p.eid;";
			System.out.println(query);
			rs = st.executeQuery(query);
			while (rs.next()) 
			{
				r = rs.getString(1);
				alist.add(r);
				System.out.println(r);
			}
		
			rs.close();
			st.close();
			return alist;
		} 
		
		catch (Exception e) {
			e.printStackTrace();
			return alist;
		} 
		finally {
			MySQL.close(c);
		}
	}

public static String[] getDateTime(String eventname){
	Connection c = null;
	Statement st = null;
	ResultSet rs = null;
	String s[] = new String[3];
	
	try 
	{
		c = MySQL.connect();
		st = c.createStatement();
		String query = "select date,starttime,endtime from electionevent where name = '"+eventname+"';";
		System.out.println(query);
		rs = st.executeQuery(query);
		
		while (rs.next())
		{
			s[0] = rs.getString(1);
			s[1] = rs.getString(2);
			s[2] = rs.getString(3);
			System.out.println(s[0]);
			System.out.println(s[1]);
			System.out.println(s[2]);
		}
		
		rs.close();
		st.close();
		return s;
		
	} 
	catch(Exception e)
	{
		e.printStackTrace();
		return s;
	} 
	finally
	{
		MySQL.close(c);
	}
	
}


	public ArrayList<String> getPositions(int eid) {

		Connection c = null;
		Statement st = null;
		ResultSet rs = null;
		ArrayList<String> r = new ArrayList<String>();
		// r.add("test");
		try {
			c = MySQL.connect();
			st = c.createStatement();
			String query = "select position from positions where eid =" + eid
					+ ";";
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

	public boolean setVotedone(String rollno,String eventname,String[] C_roll) {
		Connection c = null;
		Statement st = null;
        rollno = rollno.toUpperCase();
		// r.add("test");
		try {
			c = MySQL.connect();
			st = c.createStatement();
			String query1 = "insert into vote values('"+rollno+"','"+eventname+"');";
			for(String cr:C_roll)
			{
				if(!cr.equals("0"))
				{
					String query2 = "update candidate set votecount=votecount+1 where eventname='"+eventname+
						"' and rollno='"+cr+"'";
					System.out.println(" \n "+query2);
					st.addBatch(query2);
				}
			}
			st.addBatch(query1);
			
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
	public boolean hasVoted(String rollno,String eventname){
        rollno = rollno.toUpperCase();
		Connection c = null;
		Statement st = null;
		ResultSet rs = null;
		//boolean r = true;
		// r.add("test");
		try {
			c = MySQL.connect();
			st = c.createStatement();
			String query = "select * from vote where rollno ='" + rollno
					+ "' and eventname='"+eventname+"';";
			System.out.println(query);
			rs = st.executeQuery(query);
			int flag=0;
			if (!rs.isBeforeFirst() ) {    
			    System.out.println("No data");
			    flag=1;
			} 

			rs.close();
			st.close();
			if (flag==1)
			return false;
			else return true;
		} catch (Exception e) {
			e.printStackTrace();
			return true;
		} finally {
			MySQL.close(c);
		}

	}
	
	public String getEE(int eid){
		Connection c = null;
		Statement st = null;
		ResultSet rs = null;
		String r = null;
		
		try {
			c = MySQL.connect();
			st = c.createStatement();
			String query = "select name from electionevent where eid = "+eid+";";
			System.out.println(query);
			rs = st.executeQuery(query);

			while (rs.next()) {
				 r = rs.getString(1);
				System.out.println(r);
				
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

public ArrayList<String> getVotingCandidates(String ename,String post){
	Connection c = null;
	Statement st = null;
	ResultSet rs = null;
	String r = null;
	ArrayList<String> res=new ArrayList<String>();
	
	try {
		c = MySQL.connect();
		st = c.createStatement();
		String query = "select rollno from applicants where eventname ='"+ename+"' and appliedforpost='"
				+post+ "' and isapproved=1;";
		System.out.println(query);
		rs = st.executeQuery(query);

		while (rs.next()) {
			 r = rs.getString(1);
			 System.out.println(r);
			 res.add(r);
			
		}

		rs.close();
		st.close();
		return res;

		} 
		catch (Exception e) {
			e.printStackTrace();
			return res;
		}
		finally {
			MySQL.close(c);
		}

	
	}
public ArrayList<String> getEligiblePositions(int eid,String batch) {

	Connection c = null;
	Statement st = null;
	ResultSet rs = null;
	ArrayList<String> r = new ArrayList<String>();
	// r.add("test");
	try {
		c = MySQL.connect();
		st = c.createStatement();
		String query = "select position from positions where eid =" + eid
				+ " and ( allowedbatch='"+batch+"' or allowedbatch='all') ;";
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