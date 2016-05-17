package spin;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import org.apache.commons.io.IOUtils;
import org.apache.jena.graph.Graph;
import org.apache.jena.graph.compose.MultiUnion;
import org.apache.jena.ontology.OntModel;
import org.apache.jena.ontology.OntModelSpec;
import org.apache.jena.query.Query;
import org.apache.jena.query.QueryExecution;
import org.apache.jena.query.QueryExecutionFactory;
import org.apache.jena.query.QueryFactory;
import org.apache.jena.query.QuerySolution;
import org.apache.jena.query.ResultSet;
import org.apache.jena.rdf.model.Model;
import org.apache.jena.rdf.model.ModelFactory;
import org.apache.jena.rdf.model.Property;
import org.apache.jena.rdf.model.Resource;
import org.apache.jena.rdf.model.ResourceFactory;
import org.apache.jena.vocabulary.RDF;
import org.topbraid.spin.constraints.ConstraintViolation;
import org.topbraid.spin.constraints.SPINConstraints;
import org.topbraid.spin.system.SPINLabels;
import org.topbraid.spin.system.SPINModuleRegistry;
import org.topbraid.spin.util.JenaUtil;
import org.topbraid.spin.vocabulary.SP;
import org.topbraid.spin.vocabulary.SPIN;
import org.topbraid.spin.vocabulary.SPL;

import spin.gram.OISLexer;
import spin.gram.OISParser;
import spin.gram.OISParser.ProgContext;
import spin.gram.QueryBuilderWalker;

public class Demonstration {
	
	public static final String nsO = "http://www.semanticweb.org/joliendeclerck/ontologies/2016/3/OIS-food-ontology/";
	public static final String nsS = "http://spinrdf.org/spin#";

	public static void main(String[] args) {
		String spindir;
		String constraintsfilename;
		if(args.length <= 1) {
			showHelp();
			return;
		} else {
			spindir = args[0].replaceAll(" ", "%20");
			constraintsfilename = args[1];
		}
		
		
		try {
			// Read constraint file
			FileInputStream inputStream = new FileInputStream(constraintsfilename);
		    String constraints = IOUtils.toString(inputStream);
		    
		    // Init Antlr streams and tokens
		    ANTLRInputStream input = new ANTLRInputStream(constraints);
		    OISLexer oislexer = new OISLexer(input);
		    CommonTokenStream tokens = new CommonTokenStream( oislexer );
		  
		    // Init Antlr parser
		    OISParser parser = new OISParser(tokens);
		    ProgContext context = parser.prog();
		 
		    
		    // Init Semantic models
		    Model baseModel = ModelFactory.createDefaultModel();
			baseModel.read("file://"+spindir+"/FoodOntology.ttl"); 
			Model tstModel = ModelFactory.createDefaultModel();
			tstModel.read("file://"+spindir+"groep1data.ttl"); 
			OntModel ontModel = JenaUtil.createOntologyModel(OntModelSpec.OWL_MEM,baseModel);
			Model tempModel = ModelFactory.createDefaultModel();
			tempModel.read("file://"+spindir+"template.ttl"); 
			
			// Walk through constraints file and build constraints
			QueryBuilderWalker extractor = new QueryBuilderWalker(tempModel);
			ParseTreeWalker.DEFAULT.walk(extractor, context);
			
			//Debug
			//tempModel.write(System.out, "turtle");
			
			// Create united model
			MultiUnion union = new MultiUnion(new Graph[] {
					ontModel.getGraph(),
					tempModel.getGraph(),
					tstModel.getGraph(),
					SPL.getModel().getGraph(),
					SPIN.getModel().getGraph(),
					SP.getModel().getGraph()
			});
			Model unionModel = ModelFactory.createModelForGraph(union);

			// Register possible spin functions
			SPINModuleRegistry.get().registerAll(unionModel, null);
			
			// Check all constraints
			List<ConstraintViolation> cvs = SPINConstraints.check(unionModel, null);
			List<ConstraintViolation> hards = new ArrayList<ConstraintViolation>();
			Map<String, ConstraintViolation> softs = new HashMap<String, ConstraintViolation>();
			List<String> filters = new ArrayList<String>();
			for(ConstraintViolation cv : cvs) {
				if(cv.getLevel().toString().equals("http://spinrdf.org/spin#Error")) {
					filters.add(SPINLabels.get().getLabel(cv.getRoot()));
					hards.add(cv);
				} else {
					softs.put(cv.getRoot().toString(), cv);
				}
				//System.out.println(" - at " + SPINLabels.get().getLabel(cv.getRoot()) + ": " + cv.getMessage()+" &: "+ cv.getLevel().toString());
			}
		    
			//			
			Query query = QueryFactory.create(getSelectQueryString(filters));
			QueryExecution qexec = QueryExecutionFactory.create(query, unionModel);
			ResultSet results = qexec.execSelect();
			String outputString = "";
			while ( results.hasNext() ) {
		        final QuerySolution qs = results.next();
		        String recipe = qs.getResource("recipe").toString();
		        if(softs.containsKey(recipe)) {
		        	// Put soft constraint violating recipes at the end
		        	outputString = outputString + qs.getLiteral("recipeName").toString() + " but has soft constraint -> ";
		        	outputString = outputString + softs.get(recipe).getMessage() + "\n";
		        } else {
		        	outputString = qs.getLiteral("recipeName").toString() + "\n" + outputString;		        	
		        }
			}
		    
			outputString = "Got recipies:\n" + outputString;
			if(hards.size() > 0) {
				outputString = outputString + "\nFiltered following recipes (hard constraints):\n";
				for(ConstraintViolation cv : hards) {
					outputString = outputString + cv.getRoot().toString() + " because of " + cv.getMessage() + "\n";
				}
			}
			System.out.println(outputString);
			
			qexec.close();
		    inputStream.close();
		    return;
		    
		} catch (IOException e) {
			e.printStackTrace();
			showHelp();
		} 

	}
	
	public static void addConstraintNutToModel(Model m, String level, String nutrient, int value) {
		Resource food = m.createResource(nsO + "Recipe");
		Property constraint = ResourceFactory.createProperty(nsS + "constraint");
		Resource rc = m.createResource();
		rc.addProperty(RDF.type, m.getResource(nsO+"templateNut"));
		rc.addProperty(m.getProperty(nsO+"parNutrient"), nutrient);
		rc.addProperty(m.getProperty(nsO+"parValue"), m.createTypedLiteral(value));
		rc.addProperty(m.getProperty(nsO+"parWarn"), m.getResource(nsS+level));
		food.addProperty(constraint, rc);
	}
	
	public static void addConstraintIngreToModel(Model m, String ingredient, String level) {
		Resource food = m.createResource(nsO + "Recipe");
		Property constraint = ResourceFactory.createProperty(nsS + "constraint");
		Resource rc = m.createResource();
		rc.addProperty(RDF.type, m.getResource(nsO+"templateIngre"));
		rc.addProperty(m.getProperty(nsO+"parIngredient"), ingredient);
		rc.addProperty(m.getProperty(nsO+"parWarn"), m.getResource(nsS+level));
		food.addProperty(constraint, rc);
	}
	
	private static String getSelectQueryString(List<String> filters) {
		String queryString = "PREFIX ont: <http://www.semanticweb.org/joliendeclerck/ontologies/2016/3/OIS-food-ontology/>" +
				"PREFIX spin: <http://spinrdf.org/spin#>" +
				"PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>" +
				"SELECT ?recipeName ?recipe " +
				"WHERE { " +
				"        ?recipe a ont:Recipe ; " +
				"           ont:resultsIn ?food ." +
				"        ?food ont:hasFoodName ?recipeName ." +
				"        %%DIFF%%" +
				"}";
		String replace = "FILTER(";
		for(String filter : filters) {
			replace = replace + " ?recipe != " + filter + " &&";
		}
		if(filters.size() == 0) {
			queryString = queryString.replace("%%DIFF%%", "");
		} else {
			replace = replace.substring(0, replace.length() - 2);
			replace = replace + ")";
			queryString = queryString.replace("%%DIFF%%", replace);
		}
		return queryString;
	}
	
	private static void showHelp() {
		System.out.println("Usage: demonstration <file dir> <constratints file>\nFile dir should containt template.ttl and FoodOntology.ttl");
	}

}
