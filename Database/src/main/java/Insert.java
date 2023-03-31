import java.sql.*;
import java.util.List;

public class Insert {

    private Connection conn;
    private Statement st;

    void openConn() {
        String userName = "root";
        String password = "rootpassword";
        String url = "jdbc:mysql://localhost:3306/gruppe4";

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

    public void insertFootage(List<FootageAndReporter> footageAndReporterList) {
        try {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO Footage (Title, DateShot, DurationLength, ReporterCPR) VALUES (?, ?, ?, ?)");
            for (FootageAndReporter footage : footageAndReporterList) {
                ps.setString(1, footage.getFootage().getTitle());
                ps.setObject(2, footage.getFootage().getDate());
                ps.setInt(3, footage.getFootage().getDuration());
                ps.setInt(4, footage.getReporter().getCPR());

            }
            ps.executeUpdate();
          } catch (SQLException e) {
            System.out.println(e);
        }

    }

    public void insertJournalist(List<FootageAndReporter> footageAndReporterList) {
        try {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO Journalist (CPR, FirstName, LastName, Address, Civic, City, ZIP) VALUES (?, ?, ?, ?, ?, ?, ?)");
            for (FootageAndReporter reporter : footageAndReporterList)
            {
                ps.setInt(1, reporter.getReporter().getCPR());
                ps.setString(2, reporter.getReporter().getFirstName());
                ps.setString(3, reporter.getReporter().getLastName());
                ps.setString(4, reporter.getReporter().getStreetName());
                ps.setInt(5, reporter.getReporter().getCivicNumber());
                ps.setString(6, reporter.getReporter().getCountry());
                ps.setInt(7, reporter.getReporter().getZIPCode());
                ps.executeUpdate();
            }

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


