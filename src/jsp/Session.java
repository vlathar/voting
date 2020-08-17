package jsp;
import java.util.HashMap;
public class Session {
	private static String lastSessionId[] = new String[2000];
	private static HashMap<String,String>mulsession=new HashMap<String,String>();
	public static boolean isSameSession(String sessionID, int index) {
		if (lastSessionId[index] == null) {
			lastSessionId[index] = sessionID;
			return false;
		} else if (lastSessionId[index].equals("first")) {
			return true;
		}

		else if (lastSessionId[index] == sessionID) {
			return true;

		}

		else
			return false;
	}

	public static void setlastSessionId(String value, int index) {
		lastSessionId[index] = value;
	}
	public static boolean MultipleSessionCheck(String username, String sessionid)
	{
		if(mulsession.containsKey(username)&&mulsession.containsValue(sessionid)) return false;
		return true;
	}
	public static void setSession(String username,String sessionid){
		if(mulsession.containsKey(username)) mulsession.remove(username);
		mulsession.put(username, sessionid);
		
	}
	
}
