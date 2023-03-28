import java.io.IOException;
import java.util.List;
import java.sql.Date;

public class LoaderExample {

	public static void main(String[] args) {
		Insert connection = new Insert();
		connection.openConn();
		//connection.insertFootage("Test1", Date.valueOf("2004-05-14"), 123, "1234567891");
		connection.insertJournalist("1234567812", "Matthias", "Kobbernagel", "MinAdresse", "27", "Glostrup", "2600", "DK");
		connection.closeConn();

		FootagesAndReportersLoader loader = new FootagesAndReportersLoader();
		try {
			System.out.println("loading from "+ "uploads.csv");
			List<FootageAndReporter> footagesAndReporters = loader.loadFootagesAndReporters("uploads.csv");
			for(FootageAndReporter footageAndReporter : footagesAndReporters) {
				System.out.println("\tFootage: " + footageAndReporter.getFootage());
				System.out.println("\tReporter: " + footageAndReporter.getReporter());
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}


