import java.io.IOException;
import java.util.List;

public class LoaderExample {

	public static void main(String[] args) {
		//Insert connection = new Insert();
		//connection.insert();

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


