import java.sql.*;

public class Insert {

    private Connection conn;
    private Statement st;

    void openConn() {
        String userName = "root";
        String password = "rootpassword";
        String url = "jdbc:mysql://127.0.0.1:5041/gruppe4";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            conn = DriverManager.getConnection(url, userName, password);
            st = conn.createStatement();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void createTables() {
        try {
            st.executeUpdate("CREATE TABLE IF NOT EXISTS Footage (Title varchar(40), DateShot date, DurationLength int, ReporterCPR CHAR(10), constraint FootageID primary key(Title, DateShot))");
            st.executeUpdate("CREATE TABLE IF NOT EXISTS Journalist ( CPR CHAR(10) primary key, FirstName varchar(20), LastName varchar(20), Address varchar(30), Civic varchar(5), City varchar(20), ZIP char(4), Country char(2) )");
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void insertFootage(String title, Date dateShot, int duration, String reporterCPR) {
        try {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO Footage (Title, DateShot, DurationLength, ReporterCPR) VALUES (?, ?, ?, ?)");
            ps.setString(1, title);
            ps.setDate(2, dateShot);
            ps.setInt(3, duration);
            ps.setString(4, reporterCPR);
            ps.executeUpdate();

          } catch (SQLException e) {
            System.out.println(e);
        }

    }

    public void insertJournalist(String CPR, String FirstName, String LastName, String Address, String Civic, String City, String ZIP, String Country) {
        try {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO Journalist (CPR, FirstName, LastName, Address, Civic, City, ZIP, Country) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            ps.setString(1, CPR);
            ps.setString(2, FirstName);
            ps.setString(3, LastName);
            ps.setString(4, Address);
            ps.setString(5, Civic);
            ps.setString(6, City);
            ps.setString(7, ZIP);
            ps.setString(8, Country);
            ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }

    }

    public void closeConn(){
        try {
            conn.close();
            st.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }



}


