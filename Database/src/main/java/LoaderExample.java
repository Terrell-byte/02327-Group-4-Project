import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.sql.Date;

public class LoaderExample {

	public static void main(String[] args) {


		FootagesAndReportersLoader loader = new FootagesAndReportersLoader();
		try {
			System.out.println("loading from "+ "uploads.csv");
			List<FootageAndReporter> footagesAndReporters = loader.loadFootagesAndReporters("uploads.csv");

			for(FootageAndReporter footageAndReporter : footagesAndReporters) {

				System.out.println("\tFootage: " + footageAndReporter.getFootage());
				System.out.println("\tReporter: " + footageAndReporter.getReporter());
			}
			for (int i = 0; i < footagesAndReporters.size(); i++)
			{
				Insert connection = new Insert();
				connection.openConn();
				connection.insertFootage(Collections.singletonList((footagesAndReporters.get(i))));
				connection.insertJournalist(Collections.singletonList(footagesAndReporters.get(i)));
				connection.closeConn();
			}

		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}


