package mysql.db;

public class MysqlConnect {
	String driver="com.mysql.jdbc.Driver";
	String myurl="jdbc:mysql://localhost:3306/java0901";
	String gangsaurl="jdbc:mysql://192.168.0.4:3306/java0901";
	String myid="java";
	String mypass="1234";
	String gangsaid="bit301";
	String gangsapass="1234";
	
	public MysqlConnect() {
		// TODO Auto-generated constructor stub
		
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			// TODO: handle exception
			System.out.println("Mysql 드라이버 오류:"+e.getMessage());
		}
	}
	
	
	
}


