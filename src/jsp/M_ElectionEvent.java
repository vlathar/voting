package jsp;

import java.sql.*;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class M_ElectionEvent {

	public boolean createEE(String EE, java.sql.Date date,
			java.sql.Time startTime, java.sql.Time endTime,
			ArrayList<String> positions) {

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

			for (String position : positions) {

				if (position.equals("P") || position.equals("VP")
						|| position.equals("GSS") || position.equals("GSC")
						|| position.equals("GSST"))
					query = "insert into positions values (" + eid + ",'"
							+ position + "','all');";

				else
					query = "insert into positions values (" + eid + ",'"
							+ position + "','" + position + "');";
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
			ArrayList<String> positions) {

		boolean isdeleted = deleteEE(EE);
		boolean iscreated = false;

		if (isdeleted) {
			iscreated = createEE(EE, date, startTime, endTime, positions);

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

	public int getCurrentEE() {

		Connection c = null;
		Statement st = null;
		ResultSet rs = null;
		int r = -1;
		// r.add("test");
		try {
			c = MySQL.connect();
			st = c.createStatement();
			// getting current date and time using Date class
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date dateobj = new Date();
			String currentdatetime = df.format(dateobj);
			String currentdate = currentdatetime.substring(0, 10);
			String currenttime = currentdatetime.substring(11, 13);
			System.out.println(currentdate + "  " + currenttime);

			String query = "select eid ,starttime , endtime from electionevent where date = '"
					+ currentdate + "';";
			System.out.println(query);
			rs = st.executeQuery(query);

			int i = 0;
			java.sql.Time start = null;
			java.sql.Time end = null;

			while (rs.next()) {
				i = rs.getInt(1);
				start = rs.getTime(2);
				end = rs.getTime(3);

				DateFormat df1 = new SimpleDateFormat("HH:mm:ss");
				String startt = df1.format(start).substring(0, 2);
				String endt = df1.format(end).substring(0, 2);
				System.out.println(i + " " + startt + " " + endt);
				if (Integer.parseInt(currenttime) >= Integer.parseInt(startt)
						&& Integer.parseInt(currenttime) <= Integer
								.parseInt(endt)) {
					r = i;
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

	public void setVotedone(String rollno) {
		Connection c = null;
		Statement st = null;
        rollno = rollno.toUpperCase();
		// r.add("test");
		try {
			c = MySQL.connect();
			st = c.createStatement();
			String query = "update students set votegiven = 1 where rollno = '"
					+ rollno + "';";
			System.out.println(query);
			st.executeUpdate(query);

			st.close();

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			MySQL.close(c);
		}

	}
	public boolean hasVoted(String rollno){
        rollno = rollno.toUpperCase();
		Connection c = null;
		Statement st = null;
		ResultSet rs = null;
		//boolean r = true;
		// r.add("test");
		try {
			c = MySQL.connect();
			st = c.createStatement();
			String query = "select votegiven from students where rollno ='" + rollno
					+ "';";
			System.out.println(query);
			rs = st.executeQuery(query);
            int t=1;
			while (rs.next()) {
				t=rs.getInt(1);
				System.out.println(t);
				
			}

			rs.close();
			st.close();
			if (t==1)
			return true;
			else return false;
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

}