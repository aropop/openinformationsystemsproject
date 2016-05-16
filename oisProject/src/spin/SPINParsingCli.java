package spin;

import org.topbraid.spin.arq.ARQ2SPIN;
import org.topbraid.spin.arq.ARQFactory;
import org.topbraid.spin.model.Ask;
import org.topbraid.spin.model.Construct;
import org.topbraid.spin.model.Select;
import org.topbraid.spin.system.SPINModuleRegistry;

import org.apache.jena.query.Query;
import org.apache.jena.rdf.model.Model;
import org.apache.jena.rdf.model.ModelFactory;
import org.apache.jena.util.FileUtils;
import org.apache.jena.vocabulary.RDF;

import java.io.FileInputStream;
import java.io.IOException;

import org.apache.commons.io.IOUtils;


/**
 * Converts between textual SPARQL representation and SPIN RDF model.
 * 
 * @author Holger Knublauch (created example)
 * @author Arno De Witte (added commandline functionalities)
 */
public class SPINParsingCli {

	public static void main(String[] args) {
		
		// Register system functions (such as sp:gt (>))
		SPINModuleRegistry.get().init();
		
		// Create an empty OntModel importing SP
		Model model = ModelFactory.createDefaultModel();
		model.setNsPrefix("rdf", RDF.getURI());
		model.setNsPrefix("ex", "http://example.org/demo#");
		model.setNsPrefix("rdfs", "http://www.w3.org/2000/01/rdf-schema#");
		model.setNsPrefix("spin", "http://spinrdf.org/spin#");
		model.setNsPrefix("ont", "http://www.semanticweb.org/joliendeclerck/ontologies/2016/3/OIS-food-ontology/");
		
		String filename;
		String outputType;
		String type;
		if(args.length <= 2) {
			showHelp();
			return;
		} else {
			filename = args[0];
			outputType = args[1];
			type = args[2];
		}
		
		try {
			FileInputStream inputStream = new FileInputStream(filename);
		    String query = IOUtils.toString(inputStream);
		    
		    Query arqQuery = ARQFactory.get().createQuery(model, query);
		    ARQ2SPIN arq2SPIN = new ARQ2SPIN(model);
		    if(type.equals("select")) {
		    	Select spinQuery = (Select) arq2SPIN.createQuery(arqQuery, null); // Has to be done, does some background magic on the model
		    } else if(type.equals("construct")) {
		    	Construct spinQuery = (Construct) arq2SPIN.createQuery(arqQuery, null); // Has to be done, does some background magic on the model
		    } else {
		    	Ask spinQuery = (Ask) arq2SPIN.createQuery(arqQuery, null); // Has to be done, does some background magic on the model
		    }
		    if(outputType.equals("RDF")) { 
		    	model.write(System.out, FileUtils.langXML);		 
		    } else {
		    	model.write(System.out, "TURTLE");
		    }
		    
		    inputStream.close();
		    return;
		    
		} catch (IOException e) {
			e.printStackTrace();
			showHelp();
		} 
	}
	
	private static void showHelp() {
		System.out.println("Usage: spinparser <sparql query file> <output type> <type>\nOutput types: 'RDF', 'TTL'\nType is the type of quer eg select");
	}
}