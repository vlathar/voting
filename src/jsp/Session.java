package jsp;
import java.util.HashMap;
public class Session {
	private static HashMap<String,String>mulsession=new HashMap<String,String>();
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
