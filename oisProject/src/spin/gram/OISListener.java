package spin.gram; // Generated from OIS.g4 by ANTLR 4.5.3
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link OISParser}.
 */
public interface OISListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link OISParser#prog}.
	 * @param ctx the parse tree
	 */
	void enterProg(OISParser.ProgContext ctx);
	/**
	 * Exit a parse tree produced by {@link OISParser#prog}.
	 * @param ctx the parse tree
	 */
	void exitProg(OISParser.ProgContext ctx);
	/**
	 * Enter a parse tree produced by {@link OISParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterExpr(OISParser.ExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link OISParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitExpr(OISParser.ExprContext ctx);
	/**
	 * Enter a parse tree produced by {@link OISParser#op}.
	 * @param ctx the parse tree
	 */
	void enterOp(OISParser.OpContext ctx);
	/**
	 * Exit a parse tree produced by {@link OISParser#op}.
	 * @param ctx the parse tree
	 */
	void exitOp(OISParser.OpContext ctx);
	/**
	 * Enter a parse tree produced by {@link OISParser#constraint}.
	 * @param ctx the parse tree
	 */
	void enterConstraint(OISParser.ConstraintContext ctx);
	/**
	 * Exit a parse tree produced by {@link OISParser#constraint}.
	 * @param ctx the parse tree
	 */
	void exitConstraint(OISParser.ConstraintContext ctx);
	/**
	 * Enter a parse tree produced by {@link OISParser#ingredient}.
	 * @param ctx the parse tree
	 */
	void enterIngredient(OISParser.IngredientContext ctx);
	/**
	 * Exit a parse tree produced by {@link OISParser#ingredient}.
	 * @param ctx the parse tree
	 */
	void exitIngredient(OISParser.IngredientContext ctx);
	/**
	 * Enter a parse tree produced by {@link OISParser#nutrition}.
	 * @param ctx the parse tree
	 */
	void enterNutrition(OISParser.NutritionContext ctx);
	/**
	 * Exit a parse tree produced by {@link OISParser#nutrition}.
	 * @param ctx the parse tree
	 */
	void exitNutrition(OISParser.NutritionContext ctx);
	/**
	 * Enter a parse tree produced by {@link OISParser#operator}.
	 * @param ctx the parse tree
	 */
	void enterOperator(OISParser.OperatorContext ctx);
	/**
	 * Exit a parse tree produced by {@link OISParser#operator}.
	 * @param ctx the parse tree
	 */
	void exitOperator(OISParser.OperatorContext ctx);
}