import java.sql.*;

public class Insert {
    void insert() {
        String userName = "root";
        String password = "rootpassword";
        String url = "jdbc:mysql://127.0.0.1:5041/gruppe4";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            Connection conn = DriverManager.getConnection(url, userName, password);
            Statement st = conn.createStatement();

            //st.executeUpdate("DROP TABLE test");
            st.executeUpdate("CREATE TABLE test (name VARCHAR(20))");
            //st.execute("INSERT INTO test VALUES (1, 'test')");
            st.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}


