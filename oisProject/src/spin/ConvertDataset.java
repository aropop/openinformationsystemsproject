package spin;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;

import org.apache.jena.rdf.model.Model;
import org.apache.jena.rdf.model.ModelFactory;

public class ConvertDataset {

	public static void main(String[] args) {
		Model tstModel = ModelFactory.createDefaultModel();
		tstModel.read("file:///home/arno/workspace/Open information systems/groep1data.nt");
			File file = new File("/home/arno/workspace/Open information systems/groep1data.ttl");
			FileOutputStream fop;
			try {
				fop = new FileOutputStream(file);
				tstModel.write(fop, "Turtle");
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}

}
