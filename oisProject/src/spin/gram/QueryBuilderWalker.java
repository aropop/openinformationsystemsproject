package spin.gram;

import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.tree.ErrorNode;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.TerminalNode;
import org.apache.jena.rdf.model.Model;

import spin.Demonstration;
import spin.gram.OISParser.ConstraintContext;
import spin.gram.OISParser.ExprContext;
import spin.gram.OISParser.IngredientContext;
import spin.gram.OISParser.NutritionContext;
import spin.gram.OISParser.OpContext;
import spin.gram.OISParser.OperatorContext;
import spin.gram.OISParser.ProgContext;
public class QueryBuilderWalker implements OISListener {
	
	private Model model;
	
	
	public QueryBuilderWalker (Model m) {
		super();
		this.model = m;
	}
	
	@Override
	public void enterEveryRule(ParserRuleContext arg0) {

	}

	@Override
	public void exitEveryRule(ParserRuleContext arg0) {
		
	}

	@Override
	public void visitErrorNode(ErrorNode arg0) {
	
	}

	@Override
	public void visitTerminal(TerminalNode arg0) {
	
	}

	@Override
	public void enterProg(ProgContext ctx) {
	
	}

	@Override
	public void exitProg(ProgContext ctx) {
		
	}

	@Override
	public void enterExpr(ExprContext ctx) {

	}

	@Override
	public void exitExpr(ExprContext ctx) {
		//System.out.println("test");
		if(ctx.getChildCount() == 2) {
			ParseTree pt = ctx.getChild(0);
			String level;
			if(pt.toStringTree().equals("HARD")) {
				level = "Error";
			} else {
				level = "Warning";
			}
			pt = ctx.getChild(1);
			if(pt.getChildCount() == 2) {
				String ingredient = pt.getChild(1).getChild(0).toStringTree();
				ingredient = ingredient.substring(1, ingredient.length() -1);
				//System.out.println(ingredient);
				Demonstration.addConstraintIngreToModel(model, ingredient, level);
			} else {
				//System.out.println(pt.getChild(2).toStringTree());
				String nutrient = pt.getChild(0).getChild(0).toStringTree();
				nutrient = nutrient.substring(1, nutrient.length() -1);
				String operator = pt.getChild(1).getChild(0).toStringTree();
				int val = Integer.parseInt(pt.getChild(2).toStringTree());
				Demonstration.addConstraintNutToModel(model, level, nutrient, val);
			}
		}
		
		

	}

	@Override
	public void enterConstraint(ConstraintContext ctx) {

	}

	@Override
	public void exitConstraint(ConstraintContext ctx) {	

	}

	@Override
	public void enterIngredient(IngredientContext ctx) {
	}

	@Override
	public void exitIngredient(IngredientContext ctx) {
	}

	@Override
	public void enterOperator(OperatorContext ctx) {

	}

	@Override
	public void exitOperator(OperatorContext ctx) {

	}

	@Override
	public void enterOp(OpContext ctx) {
		
	}

	@Override
	public void exitOp(OpContext ctx) {
		
	}


	@Override
	public void enterNutrition(NutritionContext ctx) {
		
	}

	@Override
	public void exitNutrition(NutritionContext ctx) {
		
	}

}
