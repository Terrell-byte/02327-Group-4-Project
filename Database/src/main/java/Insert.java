import java.sql.*;

public class Insert {
    void insert() {
        String url = "jdbc:mariadb://localhost:5041/";
        String driver = "org.mariadb.jdbc.Driver";
        String userName = "root";
        String password = "rootpassword";
        try {
            Class.forName(driver).newInstance();
            Connection conn = DriverManager.getConnection(url, userName, password);
            Statement st = conn.createStatement();
            st.executeUpdate("INSERT INTO test VALUES (1, 'test')");
            st.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }


