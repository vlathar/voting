/*package jsp;

public class WriteImage {

	
	public void writeImage(byte[] image){
		try    {

		     
		     // get the image from the database
		     
		     response.setContentType("image/jpeg");
		     OutputStream o = response.getOutputStream();
		     
		     if(imgData == null){

		          try{
		               
		               
		               o.write(imgData);

		          }catch(Exception e){
		               System.out.println(e.toString());
		               
		          }
		          
		     }else{
		          // display the image
		          o.write(imgData);
		     }
		     
		     o.flush();
		     o.close();

		    }
		    catch (Exception e)
		    {
		      e.printStackTrace();
		      throw e;
		    }
		    finally
		    {
		      // Close the connection  ;
		    }

	}

}
*/