Class {
	#name : #RMDGrammarTest,
	#superclass : #TestCase,
	#instVars : [
		'grammar'
	],
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDGrammarTest >> equalityTest [
	| condition |
	condition := grammar binaryRelation parse: '1 = 2 = 3'.
	self deny: condition isPetit2Failure.
	self assert: condition isEqualityNode.
	self assert: condition expressions size equals: 3.
	self
		assert: condition expressions first
		equals: (grammar expression parse: '1').
	self
		assert: condition expressions second
		equals: (grammar expression parse: '2').
	self
		assert: condition expressions third
		equals: (grammar expression parse: '3')
]

{ #category : #tests }
RMDGrammarTest >> greaterOrEqualTest [
	| condition |
	condition := grammar binaryRelation parse: '1 >= 2 >= 3'.
	self deny: condition isPetit2Failure.
	self assert: condition isGreaterOrEqualNode.
	self assert: condition expressions size equals: 3.
	self
		assert: condition expressions first
		equals: (grammar expression parse: '1').
	self
		assert: condition expressions second
		equals: (grammar expression parse: '2').
	self
		assert: condition expressions third
		equals: (grammar expression parse: '3')
]

{ #category : #tests }
RMDGrammarTest >> greaterThanTest [
	| condition |
	condition := grammar binaryRelation parse: '1 > 2 > 3'.
	self deny: condition isPetit2Failure.
	self assert: condition isGreaterThanNode.
	self assert: condition expressions size equals: 3.
	self
		assert: condition expressions first
		equals: (grammar expression parse: '1').
	self
		assert: condition expressions second
		equals: (grammar expression parse: '2').
	self
		assert: condition expressions third
		equals: (grammar expression parse: '3')
]

{ #category : #tests }
RMDGrammarTest >> lessOrEqualTest [
	| condition |
	condition := grammar binaryRelation parse: '1 <= 2 <= 3'.
	self deny: condition isPetit2Failure.
	self assert: condition isLessOrEqualNode.
	self assert: condition expressions size equals: 3.
	self
		assert: condition expressions first
		equals: (grammar expression parse: '1').
	self
		assert: condition expressions second
		equals: (grammar expression parse: '2').
	self
		assert: condition expressions third
		equals: (grammar expression parse: '3')
]

{ #category : #tests }
RMDGrammarTest >> lessThanTest [
	| condition |
	condition := grammar binaryRelation parse: '1 < 2 < 3'.
	self deny: condition isPetit2Failure.
	self assert: condition isLessThanNode.
	self assert: condition expressions size equals: 3.
	self
		assert: condition expressions first
		equals: (grammar expression parse: '1').
	self
		assert: condition expressions second
		equals: (grammar expression parse: '2').
	self
		assert: condition expressions third
		equals: (grammar expression parse: '3')
]

{ #category : #tests }
RMDGrammarTest >> notEqualTest [
	| condition |
	condition := grammar binaryRelation parse: '1 /= 2'.
	self deny: condition isPetit2Failure.
	self assert: condition isNotEqualNode.
	self assert: condition expressions size equals: 2.
	self
		assert: condition expressions first
		equals: (grammar expression parse: '1').
	self
		assert: condition expressions second
		equals: (grammar expression parse: '2').
	condition := grammar binaryRelation parse: '1 /= 2 /= 3'.
	self assert: condition isPetit2Failure
]

{ #category : #running }
RMDGrammarTest >> setUp [
	grammar := RMDGrammar new
]

{ #category : #tests }
RMDGrammarTest >> testActionDefinition [
	| node |
	node := grammar actionDefinition
		parse:
			'to walk is
	when my energy > 0
	my delta x'' = sin(my heading) * walking_distance
	my delta cost'' = 3.2 [ kcal / km ] * walking_distance
where
	walking_speed = 10[km/h] if my energy > 1000[kcal],
	                4[km/h]
	walking_distance = walking_speed * delta time.'.
	self assert: node isActionDefinitionNode.
	self assert: node identifier equals: 'walk'.
	self assert: node object equals: nil.
	self
		assert: node guard
		equals: (grammar condition parse: 'my energy > 0').
	self assert: node attributeDefinitions size equals: 2.
	self assert: node utilityDefinitions size equals: 2.
	node := grammar actionDefinition
		parse:
			'to chase Target is
	my delta heading'' = direction target - my heading.'.
	self assert: node isActionDefinitionNode.
	self assert: node identifier equals: 'chase'.
	self assert: node object equals: 'Target'.
	self assert: node guard isNil.
	self assert: node attributeDefinitions size equals: 1.
	self assert: node utilityDefinitions size equals: 0.
	node := grammar actionDefinition
		parse:
			'to sturve is
	when my energy < 1000 [kcal]
	with die
	world''s delta population'' = -1.'.
	self assert: node isActionDefinitionNode.
	self assert: node identifier equals: 'sturve'.
	self assert: node object isNil.
	self assert: node guard notNil.
	self assert: node lifeDirectives size equals: 1.
	self assert: node lifeDirectives first isDieDirectiveNode.
	self assert: node attributeDefinitions size equals: 1.
	self assert: node utilityDefinitions size equals: 0
]

{ #category : #tests }
RMDGrammarTest >> testActionsFile [

	| node |
	node := grammar actionsFile parse: 'to walk is
	when my energy > 0
	my delta x'' = sin(my heading) * walking_distance
	my delta cost'' = 3.2 [ kcal / km ] * walking_distance
where
	walking_speed = 10[km/h] if my energy > 1000[kcal],
	                4[km/h]
	walking_distance = walking_speed * delta time.
to starve is
	when my energy < 1000 [kcal]
	with die
	world''s delta population'' = -1.'.
	self assert: node isActionsFileNode.
	self assert: node actions size equals: 2.
	self assert: node actions first identifier equals: 'walk'.
	self assert: node actions second identifier equals: 'starve'
]

{ #category : #tests }
RMDGrammarTest >> testAgensFile [

	| node |
	node := grammar agentsFile parse: 'World.
Patch with
    sugar [kcal].
Ant is Animat with
    blood_sugar [kcal].
'.
	self assert: node isAgentsFileNode.
	self assert: node agents size equals: 3.
	self assert: node agents first isWorldDefinitionNode.
	self assert: node agents second isPatchDefinitionNode.
	self assert: node agents third isAnimatDefinitionNode.
	self assert: node agents third identifier equals: 'Ant'
]

{ #category : #tests }
RMDGrammarTest >> testAgentDirective [
	| node |
	node := grammar agentDirective parse: 'distance foo'.
	self assert: node isAgentDirectiveNode.
	self assert: node directive equals: 'distance'.
	self assert: node agentIdentifier equals: 'foo'.
	node := grammar agentDirective parse: 'direction foo'.
	self assert: node isAgentDirectiveNode.
	self assert: node directive equals: 'direction'.
	self assert: node agentIdentifier equals: 'foo'.
	node := grammar agentDirective parse: 'direction neighbor''s foo'.
	self assert: node isPatchDirectiveNode.
	self assert: node directive equals: 'direction'.
	self assert: node patchAttributeVariable agent equals: 'here'.
	self assert: node patchAttributeVariable identifier equals: 'foo'.
	node := grammar agentDirective parse: 'foo bar'.
	self assert: node isPetit2Failure
]

{ #category : #tests }
RMDGrammarTest >> testAnimatDefinition [
	| node |
	node := grammar animatDefinition parse: 'Foo is Animat.'.
	self assert: node isAnimatDefinitionNode.
	self assert: node identifier equals: 'Foo'.
	self assert: node attributeDeclarations isEmpty.
	node := grammar animatDefinition
		parse:
			'
Goat is Animat with
	sugar [kcal].' trim.
	self assert: node isAnimatDefinitionNode.
	self assert: node identifier equals: 'Goat'.
	self assert: node attributeDeclarations size equals: 1.
	self
		assert: node attributeDeclarations first identifier
		equals: 'sugar'.
	self
		assert: node attributeDeclarations first unit
		equals: (RMDUnit at: 'kcal').
	node := grammar animatDefinition
		parse:
			'
BabyGoat is Goat with
	sugar [kcal]
	age [day].' trim.
	self assert: node isAnimatDefinitionNode.
	self assert: node identifier equals: 'BabyGoat'.
	self assert: node species equals: 'Goat'.
	self assert: node attributeDeclarations size equals: 2.
	self
		assert: node attributeDeclarations first identifier
		equals: 'sugar'.
	self
		assert: node attributeDeclarations first unit
		equals: (RMDUnit at: 'kcal').
	self
		assert: node attributeDeclarations second identifier
		equals: 'age'.
	self
		assert: node attributeDeclarations second unit
		equals: (RMDUnit at: 'day')
]

{ #category : #tests }
RMDGrammarTest >> testAnimatDotRenderer [

	| renderer |
	renderer := grammar animatDotRenderer end parse:
		            '    Goat -> 10 pixels yellow dot.'.
	self deny: renderer isPetit2Failure.
	self assert: renderer color equals: Color yellow.
	self assert: renderer diameter equals: 10 @ 10.
	self assert: renderer animat equals: 'Goat'.
	renderer := grammar animatDotRenderer end parse:
		            '    Wolf -> 12@13 pixels #FF0000 dot.'.
	self deny: renderer isPetit2Failure.
	self assert: renderer color equals: Color red.
	self assert: renderer diameter equals: 12 @ 13.
	self assert: renderer animat equals: 'Wolf'
]

{ #category : #tests }
RMDGrammarTest >> testAnimatInitializer [
	| node |
	node := grammar animatInitializer parse: '100 Goat'.
	self assert: node isAnimatInitializerNode.
	self assert: node population equals: 100.
	self assert: node animat equals: 'Goat'.
	self assert: node attributeInitializers size equals: 0.
	node := grammar animatInitializer
		parse:
			'5 Wolf with
		energy = 1000[kcal]
		speed = 50 [km/h]'.
	self assert: node isAnimatInitializerNode.
	self assert: node population equals: 5.
	self assert: node animat equals: 'Wolf'.
	self assert: node attributeInitializers size equals: 2
]

{ #category : #tests }
RMDGrammarTest >> testApply [
	| apply |
	apply := grammar apply parse: 'abs(x)'.
	self assert: apply isApplyNode.
	self assert: apply function equals: 'abs'.
	self assert: apply arguments size equals: 1.
	self
		assert: apply arguments first
		equals: (RMDUtilityVariableNode identifier: 'x').
	apply := grammar apply parse: 'max(x, y)'.
	self assert: apply isApplyNode.
	self assert: apply function equals: 'max'.
	self assert: apply arguments size equals: 2.
	self
		assert: apply arguments first
		equals: (RMDUtilityVariableNode identifier: 'x').
	self
		assert: apply arguments second
		equals: (RMDUtilityVariableNode identifier: 'y').
	apply := grammar apply parse: 'max3(x, y, z)'.
	self assert: apply isApplyNode.
	self assert: apply function equals: 'max3'.
	self assert: apply arguments size equals: 3.
	self
		assert: apply arguments first
		equals: (RMDUtilityVariableNode identifier: 'x').
	self
		assert: apply arguments second
		equals: (RMDUtilityVariableNode identifier: 'y').
	self
		assert: apply arguments third
		equals: (RMDUtilityVariableNode identifier: 'z')
]

{ #category : #tests }
RMDGrammarTest >> testAssignableDeltaAttributeVariable [

	| variable |
	variable := grammar assignableDeltaAttributeVariable parse:
		            'my delta foo'.
	self deny: variable isPetit2Failure.
	self assert: variable isAssignableDeltaVariableNode.
	self assert: variable agent isNil.
	self assert: variable identifier equals: 'foo'.
	variable := grammar assignableDeltaAttributeVariable parse:
		            'my delta Foo'.
	self assert: variable isPetit2Failure.
	variable := grammar assignableDeltaAttributeVariable parse: 'my Δfoo'.
	self deny: variable isPetit2Failure.
	self assert: variable isAssignableDeltaVariableNode.
	self assert: variable agent isNil.
	self assert: variable identifier equals: 'foo'.
	variable := grammar assignableDeltaAttributeVariable parse:
		            'foo''s delta bar'.
	self deny: variable isPetit2Failure.
	self assert: variable isAssignableDeltaVariableNode.
	self assert: variable agent equals: 'foo'.
	self assert: variable identifier equals: 'bar'.
	variable := grammar assignableDeltaAttributeVariable parse:
		            'foo''s Δbar'.
	self deny: variable isPetit2Failure.
	self assert: variable isAssignableDeltaVariableNode.
	self assert: variable agent equals: 'foo'.
	self assert: variable identifier equals: 'bar'.
	variable := grammar assignableDeltaAttributeVariable parse: 'the Δbar'.
	self deny: variable isPetit2Failure.
	self assert: variable isAssignableDeltaVariableNode.
	self assert: variable attributeVariable isPlaceholderNode.
	self assert: variable attributeVariable identifier equals: 'bar'.
	variable := grammar assignableDeltaAttributeVariable parse: 'the delta bar'.
	self deny: variable isPetit2Failure.
	self assert: variable isAssignableDeltaVariableNode.
	self assert: variable attributeVariable isPlaceholderNode.
	self assert: variable attributeVariable identifier equals: 'bar'
]

{ #category : #tests }
RMDGrammarTest >> testAssignableDifferentialAttributeVariable [

	| variable |
	variable := grammar assignableDifferentialAttributeVariable parse:
		            'my d/dt foo'.
	self deny: variable isPetit2Failure.
	self assert: variable isAssignableDifferentialAttributeVariableNode.
	self assert: variable agent isNil.
	self assert: variable identifier equals: 'foo'.
	variable := grammar assignableDifferentialAttributeVariable parse:
		            'my d/dt X'.
	self assert: variable isPetit2Failure.
	variable := grammar assignableDifferentialAttributeVariable parse:
		            'foo''s d/dt bar'.
	self deny: variable isPetit2Failure.
	self assert: variable isAssignableDifferentialAttributeVariableNode.
	self assert: variable agent equals: 'foo'.
	self assert: variable identifier equals: 'bar'.
	variable := grammar assignableDifferentialAttributeVariable parse:
		            'the d/dt bar'.
	self deny: variable isPetit2Failure.
	self assert: variable isAssignableDifferentialAttributeVariableNode.
	self assert: variable attributeVariable isPlaceholderNode.
	self assert: variable attributeVariable identifier equals: 'bar'
]

{ #category : #tests }
RMDGrammarTest >> testAttributeBind [

	| node |
	node := grammar attributeBind parse: 'the energy -> my sugar'.
	self deny: node isPetit2Failure.
	self assert: node isAttributeBindNode.
	self assert: node placeholder isPlaceholderNode.
	self assert: node placeholder identifier equals: 'energy'.
	self
		assert: node replacement
		equals: (grammar expression parse: 'my sugar').
	node := grammar attributeBind parse: 'the energy -> 10 [m]'.
	self deny: node isPetit2Failure.
	self assert: node isAttributeBindNode.
	self assert: node placeholder isPlaceholderNode.
	self assert: node placeholder identifier equals: 'energy'.
	self
		assert: node replacement
		equals: (grammar expression parse: '10 [m]')
]

{ #category : #tests }
RMDGrammarTest >> testAttributeDeclaration [
	| declaration |
	declaration := grammar attributeDeclaration parse: 'x [m]'.
	self assert: declaration isAttributeDeclarationNode.
	self assert: declaration identifier equals: 'x'.
	self assert: declaration unit equals: RMDUnit m
]

{ #category : #tests }
RMDGrammarTest >> testAttributeDefinition [
	| definition |
	definition := grammar attributeDefinition parse: 'my x'' = 1[m]'.
	self assert: definition isAttributeDefinitionNode.
	self
		assert: definition variable
		equals: (grammar assignableAttributeVariable parse: 'my x').
	self
		assert: definition definitionBody
		equals: (grammar literal parse: '1[m]').
	definition := grammar attributeDefinition
		parse: 'foo''s delta x'' = 1[m]'.
	self assert: definition isAttributeDefinitionNode.
	self
		assert: definition variable 
		equals: (grammar assignableDeltaAttributeVariable parse: 'foo''s delta x').
	self
		assert: definition definitionBody
		equals: (grammar literal parse: '1[m]').
	definition := grammar attributeDefinition
		parse: 'foo''s d/dt x'' = 1[m/s]'.
	self assert: definition isAttributeDefinitionNode.
	self
		assert: definition variable
		equals: (grammar assignableDifferentialAttributeVariable parse: 'foo''s d/dt x').
	self
		assert: definition definitionBody
		equals: (grammar literal parse: '1[m/s]').

	definition := grammar attributeDefinition
		parse:
			'my x'' =		1 if x = 2,
							2 if x = 3,
							3'.
	self deny: definition isPetit2Failure.
	self assert: definition isAttributeDefinitionNode.
	self assert: definition definitionBody isGuardedChoiceNode.
	self
		assert: definition definitionBody
		equals: (grammar guardedChoice end parse: '1 if x = 2, 2 if x = 3, 3').
	definition := grammar attributeDefinition
		parse:
			'new x'' =	my x'.
	self deny: definition isPetit2Failure.
	self assert: definition isAttributeDefinitionNode.
	self assert: definition variable attributeVariable isNewAttributeVariableNode.
	self assert: definition definitionBody isAttributeVariableNode .

]

{ #category : #tests }
RMDGrammarTest >> testAttributeInitializer [
	| node |
	node := grammar attributeInitializer
		parse: 'green = uniform 100[kcal] to 1000[kcal]'.
	self assert: node isAttributeInitializerNode.
	self assert: node identifier equals: 'green'.
	self
		assert: node expression
		equals: (grammar expression parse: 'uniform 100[kcal] to 1000[kcal]')
]

{ #category : #tests }
RMDGrammarTest >> testBackgroundColorRenderer [

	| renderer |
	renderer := grammar backgroundColorRenderer end parse:
		            '	World -> yellow.'.
	self deny: renderer isPetit2Failure.
	self assert: renderer color equals: Color yellow.
	renderer := grammar backgroundColorRenderer end parse: '    World -> #000000.'.
	self deny: renderer isPetit2Failure.
	self assert: renderer color equals: Color black
]

{ #category : #tests }
RMDGrammarTest >> testBinaryRelation [
	self
		equalityTest;
		notEqualTest;
		lessThanTest;
		lessOrEqualTest;
		greaterThanTest;
		greaterOrEqualTest.
	self
		assert: (grammar binaryRelation parse: '1 = 2 /= 3') isPetit2Failure;
		assert: (grammar binaryRelation parse: '1 = 2 < 3') isPetit2Failure;
		assert: (grammar binaryRelation parse: '1 < 2 > 3') isPetit2Failure;
		assert: (grammar binaryRelation parse: '1 /= 2 < 3') isPetit2Failure
]

{ #category : #tests }
RMDGrammarTest >> testCastingExpression [

	| node |
	node := grammar expression end parse: 'x [m]'.
	self assert: node isEnUnitExpressionNode.
	self
		assert: node expression
		equals: (grammar expression end parse: 'x').
	self assert: node unit equals: RMDUnit m.
	node := grammar expression end parse: '(m) x'.
	self assert: node isDeUnitExpressionNode.
	self
		assert: node expression
		equals: (grammar expression end parse: 'x').
	self assert: node unit equals: RMDUnit m.
	node := grammar expression end parse: '(m)x[m]'.
	self assert: node isPetit2Failure
]

{ #category : #tests }
RMDGrammarTest >> testColor [

	| color |
	color := grammar color end parse: 'yellow'.
	self deny: color isPetit2Failure.
	self assert: color equals: Color yellow.
	color := grammar color end parse: '#FFFFFF'.
	self deny: color isPetit2Failure.
	self assert: color equals: Color white
]

{ #category : #tests }
RMDGrammarTest >> testCond1 [
	| cond |
	cond := grammar cond1 parse: '1 = 2'.
	self deny: cond isPetit2Failure.
	self assert: cond isEqualityNode.
	cond := grammar cond1 parse: '(1 = 2 and 3 = 4)'.
	self deny: cond isPetit2Failure.
	self assert: cond isConjunctionNode
]

{ #category : #tests }
RMDGrammarTest >> testCond2 [
	| cond |
	cond := grammar cond2 parse: 'not 1 = 2'.
	self deny: cond isPetit2Failure.
	self assert: cond isNegationNode.
	cond := grammar cond2 parse: 'not (1 = 2)'.
	self deny: cond isPetit2Failure.
	self assert: cond isNegationNode.
	cond := grammar cond2 parse: '1 = 2'.
	self deny: cond isPetit2Failure.
	self assert: cond isEqualityNode.

]

{ #category : #tests }
RMDGrammarTest >> testCond3 [
	| cond |
	cond := grammar cond3 parse: '1 = 2 and 3 = 4'.
	self deny: cond isPetit2Failure.
	self assert: cond isConjunctionNode.
	cond := grammar cond3 parse: 'not 1 = 2 and 3 = 4 and 5 = 6'.
	self deny: cond isPetit2Failure.
	self assert: cond isConjunctionNode.
	cond := grammar cond3 parse: 'not (1 = 2 and 3 = 4)'.
	self deny: cond isPetit2Failure.
	self assert: cond isNegationNode.
	cond := grammar cond3 parse: '1 = 2'.
	self deny: cond isPetit2Failure.
	self assert: cond isEqualityNode.
	cond := grammar cond3 parse: '1 = 2 and 3 = 4 or 5 = 6'.
	self assert: cond isPetit2Failure
]

{ #category : #tests }
RMDGrammarTest >> testCondition [
	| cond |
	cond := grammar condition parse: '1 = 2 and 3 = 4'.
	self deny: cond isPetit2Failure.
	self assert: cond isConjunctionNode.
	cond := grammar condition
		parse: 'not 1 = 2 and 3 = 4 and (5 = 6 or 7 = 8)'.
	self deny: cond isPetit2Failure.
	self assert: cond isConjunctionNode.
	self
		assert: cond conditions first
		equals: (grammar condition parse: 'not 1 = 2').
	self
		assert: cond conditions second
		equals: (grammar condition parse: '3 = 4').
	self assert: cond conditions third isDisjunctionNode.
	self
		assert: cond conditions third
		equals: (grammar condition parse: '5 = 6 or 7 = 8').
	self
		assert: cond conditions third conditions first
		equals: (grammar condition parse: '5 = 6').
	self
		assert: cond conditions third conditions second
		equals: (grammar condition parse: '7 = 8')
]

{ #category : #tests }
RMDGrammarTest >> testExpr1 [

	| expr1 |
	expr1 := grammar expr1 parse: 'x'.
	self assert: expr1 isUtilityVariableNode.
	self assert: expr1 identifier equals: 'x'.
	expr1 := grammar expr1 parse: 'my x'.
	self assert: expr1 isAttributeVariableNode.
	self assert: expr1 identifier equals: 'x'.
	self assert: expr1 agent equals: nil.
	expr1 := grammar expr1 parse: '-foo''s x'.
	self assert: expr1 isUnaryMinusNode.
	self assert: expr1 expression isAttributeVariableNode.
	self assert: expr1 expression identifier equals: 'x'.
	self assert: expr1 expression agent equals: 'foo'.
	expr1 := grammar agentDirective parse: 'distance foo'.
	self assert: expr1 isAgentDirectiveNode.
	self assert: expr1 directive equals: 'distance'.
	self assert: expr1 agentIdentifier equals: 'foo'.
	expr1 := grammar uniformDistribution parse: 'uniform -10[cm] to 2[m]'.
	self assert: expr1 isUniformDistributionNode.
	self
		assert: expr1 fromExpression
		equals: (grammar literal parse: '-10cm').
	self
		assert: expr1 toExpression
		equals: (grammar literal parse: '2[cm]').
	expr1 := grammar expr1 parse: 'f(x)'.
	self assert: expr1 isApplyNode.
	self assert: expr1 function equals: 'f'.
	self
		assert: expr1 arguments
		equals: { (RMDUtilityVariableNode identifier: 'x') }.
	expr1 := grammar expr1 parse: '1[m]'.
	self assert: expr1 isLiteralNode.
	self assert: expr1 numeric closeTo: 1.
	expr1 := grammar expr1 parse: '1'.
	self assert: expr1 isLiteralNode.
	self assert: expr1 numeric closeTo: 1.
	self assert: expr1 unit hasDimension not.
	expr1 := grammar expression end parse: 'x [m]'.
	self assert: expr1 isEnUnitExpressionNode.
	self
		assert: expr1 expression
		equals: (grammar expression end parse: 'x').
	self assert: expr1 unit equals: RMDUnit m.
	expr1 := grammar expression end parse: '(m) x'.
	self assert: expr1 isDeUnitExpressionNode.
	self
		assert: expr1 expression
		equals: (grammar expression end parse: 'x').
	self assert: expr1 unit equals: RMDUnit m.
	expr1 := grammar expression end parse: '(m)x[m]'.
	self assert: expr1 isPetit2Failure
]

{ #category : #tests }
RMDGrammarTest >> testExpr2 [
	| expr2 |
	expr2 := grammar expr2 parse: 'x'.
	self assert: expr2 isUtilityVariableNode.
	self assert: expr2 identifier equals: 'x'.
	expr2 := grammar expr2 parse: 'x^2'.
	self assert: expr2 isPowerNode.
	self assert: expr2 expression isUtilityVariableNode.
	self assert: expr2 expression identifier equals: 'x'.
	self assert: expr2 order equals: 2
]

{ #category : #tests }
RMDGrammarTest >> testExpr3 [
	| expr3 |
	expr3 := grammar expr3 parse: 'x'.
	self assert: expr3 isUtilityVariableNode.
	self assert: expr3 identifier equals: 'x'.
	expr3 := grammar expr3 parse: 'x * y * z'.
	self assert: expr3 isProductNode.
	self assert: expr3 expression1 isProductNode.
	self assert: expr3 expression1 expression1 identifier equals: 'x'.
	self assert: expr3 expression1 expression2 identifier equals: 'y'.
	self assert: expr3 expression2 identifier equals: 'z'.
	expr3 := grammar expr3 end parse: 'x * y^2'.
	self assert: expr3 isProductNode.
	self assert: expr3 expression1 isUtilityVariableNode.
	self assert: expr3 expression1 identifier equals: 'x'.
	self assert: expr3 expression2 isPowerNode.
	self assert: expr3 expression2 expression isUtilityVariableNode.
	self assert: expr3 expression2 expression identifier equals: 'y'.
	self assert: expr3 expression2 order equals: 2
]

{ #category : #tests }
RMDGrammarTest >> testExpr4 [
	| expr4 |
	expr4 := grammar expr4 parse: 'x / y'.
	self assert: expr4 isFractionNode.
	self assert: expr4 expression1 identifier equals: 'x'.
	self assert: expr4 expression2 identifier equals: 'y'.
	expr4 := grammar expr4 parse: 'x * y / z'.
	self assert: expr4 isFractionNode.
	self assert: expr4 expression1 isProductNode.
	self assert: expr4 expression2 identifier equals: 'z'.
	expr4 := grammar expr4 parse: 'x / y * z'.
	self assert: expr4 isFractionNode.
	self assert: expr4 expression1 identifier equals: 'x'.
	self assert: expr4 expression2 isProductNode
]

{ #category : #tests }
RMDGrammarTest >> testExpr5 [
	| expr5 |
	expr5 := grammar expr5 parse: 'x + y - z'.
	self assert: expr5 isSubtractionNode.
	self assert: expr5 expression1 isAdditionNode.
	self assert: expr5 expression1 expression1 identifier equals: 'x'.
	self assert: expr5 expression1 expression2 identifier equals: 'y'.
	self assert: expr5 expression2 identifier equals: 'z'.
	expr5 := grammar expr5 parse: 'x - y + z'.
	self assert: expr5 isAdditionNode.
	self assert: expr5 expression1 isSubtractionNode.
	self assert: expr5 expression1 expression1 identifier equals: 'x'.
	self assert: expr5 expression1 expression2 identifier equals: 'y'.
	self assert: expr5 expression2 identifier equals: 'z'.
	expr5 := grammar expr5 parse: 'x * y + z'.
	self assert: expr5 isAdditionNode.
	self assert: expr5 expression1 isProductNode.
	self assert: expr5 expression1 expression1 identifier equals: 'x'.
	self assert: expr5 expression1 expression2 identifier equals: 'y'.
	self assert: expr5 expression2 identifier equals: 'z'.
	expr5 := grammar expr5 parse: 'x + y * z'.
	self assert: expr5 isAdditionNode.
	self assert: expr5 expression1 identifier equals: 'x'.
	self assert: expr5 expression2 isProductNode.
	self assert: expr5 expression2 expression1 identifier equals: 'y'.
	self assert: expr5 expression2 expression2 identifier equals: 'z'
]

{ #category : #tests }
RMDGrammarTest >> testExpression [
	| expr |
	expr := grammar expression parse: 'x + y * z'.
	self deny: expr isPetit2Failure.
	self assert: expr expression1 equals: (grammar expression parse: 'x').
	self
		assert: expr expression2
		equals: (grammar expression parse: 'y * z').
	expr := grammar expression end
		parse: '(1 if x = y, 2 if x = z, 3) + 2'.
	self deny: expr isPetit2Failure.
	self assert: expr isAdditionNode.
	self assert: expr expression1 isGuardedChoiceNode.
	expr := grammar expression end parse: '1 if x = y, 2 if x = z, 3'.
	self assert: expr isPetit2Failure
]

{ #category : #tests }
RMDGrammarTest >> testGammaDistribution [

	| node |
	node := grammar expression parse:
		        'gamma 2.0[] scale 1[]'.
	self assert: node isGammaDistributionNode.
	self
		assert: node shapeExpression
		equals: (grammar expression parse: '2.0[]').
	self
		assert: node scaleExpression
		equals: (grammar expression parse: '1[]')
]

{ #category : #tests }
RMDGrammarTest >> testGuardedChoice [
	| choice |
	choice := grammar guardedChoice parse: '1 if x = 0, 2 if x = 1, 3'.
	self assert: choice isGuardedChoiceNode.
	self assert: choice guardsAndChoices size equals: 3.
	self
		assert: choice guardsAndChoices first key
		equals: (grammar condition parse: 'x = 0').
	self
		assert: choice guardsAndChoices first value
		equals: (grammar expression parse: '1').
	self
		assert: choice guardsAndChoices second key
		equals: (grammar condition parse: 'x = 1').
	self
		assert: choice guardsAndChoices second value
		equals: (grammar expression parse: '2').
	self assert: choice guardsAndChoices third key equals: true.
	self
		assert: choice guardsAndChoices third value
		equals: (grammar expression parse: '3').
	choice := grammar guardedChoice parse: '1 if x = 0, 2 if x = 1, 3'.
	self
		assert: choice
		equals:
			(grammar guardedChoice
				parse:
					'1 if x = 0,
	2 if x = 1,
	3').
	choice := grammar guardedChoice end parse: '1 if x = 0, 2 if x = 1'.
	self assert: choice isPetit2Failure
]

{ #category : #tests }
RMDGrammarTest >> testInt [
	self assert: (grammar int end parse: '0') equals: 0.
	self assert: (grammar int end parse: '1') equals: 1.
	self assert: (grammar int end parse: '2') equals: 2.
	self assert: (grammar int end parse: '321') equals: 321.
	self assert: (grammar int end parse: '-123') equals: -123.
	self assert: (grammar int end parse: '3.14') isPetit2Failure
]

{ #category : #tests }
RMDGrammarTest >> testLiteral [
	| literal |
	literal := grammar literal parse: '3.14[]'.
	self assert: literal literal equals: '3.14'.
	self assert: literal unit equals: RMDUnit noDimension.
	self assert: literal numeric closeTo: 3.14.
	literal := grammar literal parse: '3.14'.
	self assert: literal literal equals: '3.14'.
	self assert: literal unit equals: RMDUnit noDimension.
	self assert: literal numeric closeTo: 3.14.
	literal := grammar literal parse: '-3.14[]'.
	self assert: literal literal equals: '-3.14'.
	self assert: literal unit equals: (grammar type parse: '[]').
	self assert: literal numeric closeTo: -3.14.
	literal := grammar literal parse: '3[m]'.
	self assert: literal literal equals: '3'.
	self assert: literal unit equals: (grammar type parse: '[m]').
	self assert: literal numeric closeTo: 3.
	literal := grammar literal parse: '-pi/2[rad]'.
	self assert: literal literal equals: '-π/2'.
	self assert: literal unit equals: (grammar type parse: '[rad]').
	self assert: literal numeric closeTo: Float pi / -2.0.
	
	
]

{ #category : #tests }
RMDGrammarTest >> testLogLogisticDistribution [

	| node |
	node := grammar expression parse: 'loglogistic 2.0[] shape 1[]'.
	self assert: node isLogLogisticDistributionNode.
	self
		assert: node scaleExpression
		equals: (grammar expression parse: '2.0[]').
	self
		assert: node shapeExpression
		equals: (grammar expression parse: '1[]').
	node := grammar expression parse: 'fisk 2.0[] shape 1[]'.
	self assert: node isLogLogisticDistributionNode.
	self
		assert: node scaleExpression
		equals: (grammar expression parse: '2.0[]').
	self
		assert: node shapeExpression
		equals: (grammar expression parse: '1[]')
]

{ #category : #tests }
RMDGrammarTest >> testNormalDistribution [

	| node |
	node := grammar normalDistribution parse:
		        'normal -10[m]+5[m] sigma 2[cm]'.
	self assert: node isNormalDistributionNode.
	self
		assert: node meanExpression
		equals: (grammar expression parse: '-10[m]+5m').
	self
		assert: node sigmaExpression
		equals: (grammar expression parse: '2[cm]')
]

{ #category : #tests }
RMDGrammarTest >> testPatchColorAlphaRenderer [

	| renderer |
	renderer := grammar patchColorAlphaRenderer end parse:
		            '	Patch -> yellow with alpha proportional to here''s grass between 100 [kcal] and 0[kcal] with 2 pixels black grids.'.
	self deny: renderer isPetit2Failure.
	self assert: renderer color equals: Color yellow.
	self
		assert: renderer expression
		equals: (grammar expression parse: 'here''s grass').
	self
		assert: renderer min
		equals: (grammar literal parse: '100 [kcal]').
	self assert: renderer max equals: (grammar literal parse: '0 [kcal]')
]

{ #category : #tests }
RMDGrammarTest >> testPatchColorBrightnessRenderer [

	| renderer |
	renderer := grammar patchColorBrightnessRenderer end parse:
		            '	Patch -> yellow with brightness proportional to here''s grass between 100 [kcal] and 0[kcal] with 2 pixels black grids.'.
	self deny: renderer isPetit2Failure.
	self assert: renderer color equals: Color yellow.
	self
		assert: renderer expression
		equals: (grammar expression parse: 'here''s grass').
	self
		assert: renderer min
		equals: (grammar literal parse: '100 [kcal]').
	self assert: renderer max equals: (grammar literal parse: '0 [kcal]')
]

{ #category : #tests }
RMDGrammarTest >> testPatchColorMapRenderer [

	| renderer |
	renderer := grammar patchColorMapRenderer end parse:
		            '	Patch -> map here''s grass with
			green if >= 100 [kcal],
			yellow if >= 50 [kcal],
			red
		with 2 pixels black grids.'.
	self deny: renderer isPetit2Failure.
	self assert: renderer color equals: Color red
]

{ #category : #tests }
RMDGrammarTest >> testPatchDefinition [
	| node |
	node := grammar patchDefinition end parse: 'Patch.'.
	self assert: node isPatchDefinitionNode.
	self assert: node attributeDeclarations isEmpty.
	self assert: node equals: RMDPatchDefinitionNode empty.
	node := grammar patchDefinition end
		parse:
			'
Patch with
	sugar [kcal].' trim.
	self assert: node isPatchDefinitionNode.
	self assert: node attributeDeclarations size equals: 1.
	self
		assert: node attributeDeclarations first identifier
		equals: 'sugar'.
	self
		assert: node attributeDeclarations first unit
		equals: RMDUnit kcal
]

{ #category : #tests }
RMDGrammarTest >> testPatchInitializer [
	| node |
	node := grammar patchInitializer parse: '10x20 of 5[m] Patch'.
	self assert: node isPatchInitializerNode.
	self assert: node xDivisions equals: 10.
	self assert: node yDivisions equals: 20.
	self assert: node size literal equals: '5'.
	self assert: node size unit equals: 'm' asRMDUnit.
	self assert: node length closeTo: 5.0.
	self assert: node attributeInitializers isEmpty.
	node := grammar patchInitializer
		parse:
			'15x30 of 4[m^2] Patch with
	green = 10000 [kcal]
	fertility = 12345 [kcal]'.
	self assert: node isPatchInitializerNode.
	self assert: node xDivisions equals: 15.
	self assert: node yDivisions equals: 30.
	self assert: node size literal equals: '4'.
	self assert: node size unit equals: 'm^2' asRMDUnit.
	self assert: node length closeTo: 2.0.
	self assert: node attributeInitializers size equals: 2.
	self
		assert: node attributeInitializers first identifier
		equals: 'green'.
	self
		assert: node attributeInitializers second identifier
		equals: 'fertility'
]

{ #category : #tests }
RMDGrammarTest >> testPlaceholder [

	| exp |
	exp := grammar expression parse: 'the expression'.
	self deny: exp isPetit2Failure.
	self assert: exp isPlaceholderNode.
	exp := grammar expression parse: 'the expression + 1'.
	self deny: exp isPetit2Failure.
	self assert: exp isAdditionNode.
	self
		assert: exp expression1
		equals: (grammar expression parse: 'the expression').
	self assert: exp expression2 equals: (grammar expression parse: '1')
]

{ #category : #tests }
RMDGrammarTest >> testSimulationDefinition [
	| node |
	node := grammar simulationDefinition end
		parse:
			'Simulation with
	during 10 [days] by 1 [day]
	5 x 5 of 10[m] Patch with
	    fertility = uniform 1000[kcal] to 2000[kcal]
	10 Goat with
		x = uniform 0[m] to 50[m]
		y = uniform 20[m] to 30[m].'.
	self assert: node isSimulationDefinitionNode.
	self
		assert: node timeDefinition duration
		equals: (grammar literal parse: '10[day]')
]

{ #category : #tests }
RMDGrammarTest >> testSimulationFile [

	| node |
	node := grammar simulationFile end parse: 'Simulation with
	during 10 [days] by 1 [day]
	5 x 5 of 10[m] Patch with
	    fertility = uniform 1000[kcal] to 2000[kcal]
	10 Goat with
		x = uniform 0[m] to 50[m]
		y = uniform 20[m] to 30[m].'.
	self assert: node isSimulationFileNode.
	self assert: node simulationDefinition isSimulationDefinitionNode.
	self
		assert: node simulationDefinition timeDefinition duration
		equals: (grammar literal parse: '10[day]')
]

{ #category : #tests }
RMDGrammarTest >> testSimulationTimeDefinition [
	| node |
	node := grammar simulationTimeDefinition parse: 'during 100 [days] by 1 [hour]'.
	self assert: node isSimulationTimeDefinitionNode.
	self assert: node duration isLiteralNode.
	self assert: node duration unit equals: 'days' asRMDUnit.
	self assert: node duration literal equals: '100'.
	self assert: node step isLiteralNode.
	self assert: node step unit equals: 'hour' asRMDUnit.
	self assert: node step literal equals: '1'.


]

{ #category : #tests }
RMDGrammarTest >> testTaskDefinition [

	| node |
	node := grammar taskDefinition end parse: '
Goat move namely walk
when my blood_sugar > my hunger
where
	the energy -> sugar
	the speed -> slow_speed.' trim.
	self deny: node isPetit2Failure.
	self assert: node isTaskDefinitionNode.
	self assert: node subjectIdentifier equals: 'Goat'.
	self assert: node actionIdentifier equals: 'walk'.
	self assert: node objectIdentifier isNil.
	self assert: node range isNil.
	self assert: node attributeBinds size = 2.
	node := grammar taskDefinition parse: '
Wolf eat Goat within 1[m]
where
	the energy -> my sugar.' trim.
	self deny: node isPetit2Failure.
	self assert: node isTaskDefinitionNode.
	self assert: node subjectIdentifier equals: 'Wolf'.
	self assert: node actionIdentifier equals: 'eat'.
	self assert: node objectIdentifier equals: 'Goat'.
	self assert: node range equals: (grammar literal parse: '1[m]').
	self assert: node attributeBinds size = 1
]

{ #category : #tests }
RMDGrammarTest >> testTaskDefinitionHeader [
	| node |
	node := RMDGrammar new taskDefinitionHeader parse: 'Wolf eat Goat within 1[m]
when my blood_sugar < my full'.
	self deny: node isPetit2Failure
]

{ #category : #tests }
RMDGrammarTest >> testTasksFile [

	| node |
	node := grammar tasksFile parse: 'Patch grow.
Goat move namely walk
when my blood_sugar > my hunger
where
	the energy -> sugar
	the speed -> slow_speed.'.
	self assert: node isTasksFileNode.
	self assert: node tasks size equals: 2.
	self assert: node tasks first subjectIdentifier equals: 'Patch'.
	self assert: node tasks second verbIdentifier equals: 'move'
]

{ #category : #tests }
RMDGrammarTest >> testType [
	| type |
	type := grammar type parse: '[m]'.
	self deny: type isPetit2Failure.
	self assert: type equals: (RMDUnitSymbol at: 'm').
	type := grammar type parse: '[kg m/s^2]'.
	self deny: type isPetit2Failure.
	self
		assert: type
		equals:
			(RMDUnitSymbol at: 'kg') * (RMDUnitSymbol at: 'm')
				/ ((RMDUnitSymbol at: 's') ** 2).
	type := grammar type parse: '[]'.
	self assert: type equals: RMDUnit noDimension
]

{ #category : #tests }
RMDGrammarTest >> testUniformDistribution [

	| node |
	node := grammar uniformDistribution parse:
		        'uniform -10[cm]+5[m] to 2[m]'.
	self assert: node isUniformDistributionNode.
	self
		assert: node fromExpression
		equals: (grammar expression parse: '-10[cm]+5[m]').
	self
		assert: node toExpression
		equals: (grammar expression parse: '2[cm]')
]

{ #category : #tests }
RMDGrammarTest >> testUnit [
	| unit |
	unit := grammar unit parse: 'm'.
	self deny: unit isPetit2Failure.
	self assert: unit equals: (RMDUnitSymbol at: 'm').
	unit := grammar unit parse: 'kg m/s^2'.
	self deny: unit isPetit2Failure.
	self
		assert: unit
		equals:
			(RMDUnitSymbol at: 'kg') * (RMDUnitSymbol at: 'm')
				/ ((RMDUnitSymbol at: 's') ** 2).
	unit := grammar unit parse: ''.
	self assert: unit isPetit2Failure
]

{ #category : #tests }
RMDGrammarTest >> testUnitFactor [
	| symbol |
	symbol := grammar unitFactor parse: 'm'.
	self deny: symbol isPetit2Failure.
	self assert: symbol equals: (RMDUnitSymbol at: 'm').
	symbol := grammar unitFactor parse: 'm^2'.
	self deny: symbol isPetit2Failure.
	self assert: symbol equals: (RMDUnitSymbol at: 'm') ** 2.
	symbol := grammar unitFactor parse: 's^-2'.
	self deny: symbol isPetit2Failure.
	self assert: symbol equals: (RMDUnitSymbol at: 's') ** -2
]

{ #category : #tests }
RMDGrammarTest >> testUnitSymbol [
	| symbol |
	symbol := grammar unitSymbol parse: 'm'.
	self deny: symbol isPetit2Failure.
	self assert: symbol equals: (RMDUnitSymbol at: 'm').
	symbol := grammar unitSymbol parse: 'kg'.
	self deny: symbol isPetit2Failure.
	self assert: symbol equals: (RMDUnitSymbol at: 'kg')
]

{ #category : #tests }
RMDGrammarTest >> testUnitTerm [
	| symbol |
	symbol := grammar unitTerm parse: 'm'.
	self deny: symbol isPetit2Failure.
	self assert: symbol equals: (RMDUnitSymbol at: 'm').
	symbol := grammar unitTerm parse: 'kg m'.
	self deny: symbol isPetit2Failure.
	self
		assert: symbol
		equals: (RMDUnitSymbol at: 'kg') * (RMDUnitSymbol at: 'm')
]

{ #category : #tests }
RMDGrammarTest >> testUtilityDefinition [
	| definition |
	definition := grammar utilityDefinition parse: 'x = 1[m]'.
	self assert: definition isUtilityDefinitionNode.
	self
		assert: definition variable
		equals: (grammar utilityVariable parse: 'x').
	self
		assert: definition definitionBody
		equals: (grammar literal parse: '1[m]').
	definition := grammar utilityDefinition
		parse:
			'x =	1 if x = 2,
					2 if y = 3,
					3'.
	self assert: definition definitionBody isGuardedChoiceNode
]

{ #category : #tests }
RMDGrammarTest >> testUtilityVariable [
	| variable |
	variable := grammar utilityVariable parse: 'foo'.
	self deny: variable isPetit2Failure.
	self assert: variable isUtilityVariableNode.
	self assert: variable identifier equals: 'foo'.
	variable := grammar utilityVariable parse: 'Foo'.
	self assert: variable isPetit2Failure
]

{ #category : #tests }
RMDGrammarTest >> testVariable [
	| variable |
	variable := grammar attributeVariable parse: 'my foo'.
	self deny: variable isPetit2Failure.
	self assert: variable isAttributeVariableNode.
	self assert: variable identifier equals: 'foo'.
	self assert: variable agent isNil.
	variable := grammar attributeVariable parse: 'foo'.
	self assert: variable isPetit2Failure.
	variable := grammar attributeVariable parse: 'foo''s bar'.
	self deny: variable isPetit2Failure.
	self assert: variable isAttributeVariableNode.
	self assert: variable agent equals: 'foo'.
	self assert: variable identifier equals: 'bar'
]

{ #category : #tests }
RMDGrammarTest >> testVisualizationFile [

	| node |
	node := grammar visualizationFile end parse: 'World -> black.
Patch -> green with alpha proportional to here''s  grass between 0 [kcal] and 100 [kcal]with 2 pixels black grids.
Grasshopper_Adult -> 7@7 pixels yellow dot.
Grasshopper_Egg -> 7@7 pixels cyan dot.
'.
	self assert: node isVisualizationFileNode.
	self assert: node renderers size equals: 4
]

{ #category : #tests }
RMDGrammarTest >> testWorldDefinition [
	| node |
	node := grammar worldDefinition end parse: 'World.'.
	self assert: node isWorldDefinitionNode.
	self assert: node attributeDeclarations isEmpty.
	self assert: node equals: RMDWorldDefinitionNode empty.
	node := grammar worldDefinition end
		parse:
			'
World with
	temperature [DegreeC].' trim.
	self assert: node isWorldDefinitionNode.
	self assert: node attributeDeclarations size equals: 1.
	self
		assert: node attributeDeclarations first identifier
		equals: 'temperature'.
	self assert: node attributeDeclarations first unit equals: RMDUnit celsius
]

{ #category : #tests }
RMDGrammarTest >> testWorldInitializer [
	| node |
	node := grammar worldInitializer parse: 'World with
	temperature = 10 [C]'.
	self assert: node isWorldInitializerNode.
	self assert: node attributeInitializers size equals: 1.
	self assert: node attributeInitializers first identifier equals: 'temperature'.
	self assert: node attributeInitializers first expression equals: (grammar literal parse: '10 [C]')
]
