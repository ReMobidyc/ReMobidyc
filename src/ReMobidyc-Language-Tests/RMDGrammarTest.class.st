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
RMDGrammarTest >> testDeltaVariable [
	| variable |
	variable := grammar deltaVariable parse: 'my delta foo'.
	self deny: variable isPetit2Failure.
	self assert: variable isDeltaVariableNode.
	self assert: variable agent isNil.
	self assert: variable identifier equals: 'foo'.
	variable := grammar deltaVariable parse: 'my delta Foo'.
	self assert: variable isPetit2Failure.
	variable := grammar deltaVariable parse: 'my Δfoo'.
	self deny: variable isPetit2Failure.
	self assert: variable isDeltaVariableNode.
	self assert: variable agent isNil.
	self assert: variable identifier equals: 'foo'.
	variable := grammar deltaVariable parse: 'foo''s delta bar'.
	self deny: variable isPetit2Failure.
	self assert: variable isDeltaVariableNode.
	self assert: variable agent equals: 'foo'.
	self assert: variable identifier equals: 'bar'.
	variable := grammar deltaVariable parse: 'foo''s Δbar'.
	self deny: variable isPetit2Failure.
	self assert: variable isDeltaVariableNode.
	self assert: variable agent equals: 'foo'.
	self assert: variable identifier equals: 'bar'
]

{ #category : #tests }
RMDGrammarTest >> testDifferential2Variable [
	| variable |
	variable := grammar differential2Variable parse: 'my d2/dt2 x'.
	self deny: variable isPetit2Failure.
	self assert: variable isDifferential2VariableNode.
	self assert: variable identifier equals: 'x'.
	variable := grammar differential2Variable parse: 'my d2/dt2 X'.
	self assert: variable isPetit2Failure.
	variable := grammar differential2Variable parse: 'my d^2/dt^2 vx'.
	self deny: variable isPetit2Failure.
	self assert: variable isDifferential2VariableNode.
	self assert: variable identifier equals: 'vx'.
	variable := grammar differential2Variable parse: 'my d2/dt2   sugar'.
	self deny: variable isPetit2Failure.
	self assert: variable isDifferential2VariableNode.
	self assert: variable identifier equals: 'sugar'.
	variable := grammar differential2Variable parse: ' x'.
	self assert: variable isPetit2Failure
]

{ #category : #tests }
RMDGrammarTest >> testDifferentialVariable [
	| variable |
	variable := grammar differentialVariable parse: 'my d/dt foo'.
	self deny: variable isPetit2Failure.
	self assert: variable isDifferentialVariableNode.
	self assert: variable agent isNil.
	self assert: variable identifier equals: 'foo'.
	variable := grammar differentialVariable parse: 'my d/dt X'.
	self assert: variable isPetit2Failure.
	variable := grammar differentialVariable parse: 'foo''s d/dt bar'.
	self deny: variable isPetit2Failure.
	self assert: variable isDifferentialVariableNode.
	self assert: variable agent equals: 'foo'.
	self assert: variable identifier equals: 'bar'
]

{ #category : #tests }
RMDGrammarTest >> testExpr1 [
	| expr1 |
	expr1 := grammar expr1 parse: 'x'.
	self assert: expr1 isUtilityVariableNode.
	self assert: expr1 identifier equals: 'x'.
	expr1 := grammar expr1 parse: 'my x'.
	self assert: expr1 isVariableNode.
	self assert: expr1 identifier equals: 'x'.
	self assert: expr1 agent equals: nil.
	expr1 := grammar expr1 parse: 'my delta x'.
	self assert: expr1 isDeltaVariableNode.
	self assert: expr1 identifier equals: 'x'.
	self assert: expr1 agent equals: nil.
	expr1 := grammar expr1 parse: 'foo''s d/dt x'.
	self assert: expr1 isDifferentialVariableNode.
	self assert: expr1 identifier equals: 'x'.
	self assert: expr1 agent equals: 'foo'.
	expr1 := grammar expr1 parse: 'foo''s d2/dt2 x'.
	self assert: expr1 isDifferential2VariableNode.
	self assert: expr1 identifier equals: 'x'.
	self assert: expr1 agent equals: 'foo'.
	expr1 := grammar expr1 parse: 'f(x)'.
	self assert: expr1 isApplyNode.
	self assert: expr1 function equals: 'f'.
	self
		assert: expr1 arguments
		equals: {(RMDUtilityVariableNode identifier: 'x')}.
	expr1 := grammar expr1 parse: '1[m]'.
	self assert: expr1 isLiteralNode.
	self assert: expr1 numeric closeTo: 1.
	expr1 := grammar expr1 parse: '1'.
	self assert: expr1 isLiteralNode.
	self assert: expr1 numeric closeTo: 1.
	self assert: expr1 type hasDimension not
]

{ #category : #tests }
RMDGrammarTest >> testExpr2 [
	| expr2 |
	expr2 := grammar expr2 parse: 'x'.
	self assert: expr2 isUtilityVariableNode.
	self assert: expr2 identifier equals: 'x'.
	expr2 := grammar expr2 parse: 'x^(y^z)'.
	self assert: expr2 isPowerNode.
	self assert: expr2 expression1 isUtilityVariableNode.
	self assert: expr2 expression1 identifier equals: 'x'.
	self assert: expr2 expression2 isPowerNode.
	self assert: expr2 expression2 expression1 isUtilityVariableNode.
	self assert: expr2 expression2 expression1 identifier equals: 'y'.
	self assert: expr2 expression2 expression2 isUtilityVariableNode.
	self assert: expr2 expression2 expression2 identifier equals: 'z'
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
	expr3 := grammar expr3 parse: 'my d/dt x * foo''s delta y * z'.
	self assert: expr3 isProductNode.
	self assert: expr3 expression1 isProductNode.
	self assert: expr3 expression1 expression1 isDifferentialVariableNode.
	self assert: expr3 expression1 expression1 identifier equals: 'x'.
	self assert: expr3 expression1 expression2 isDeltaVariableNode.
	self assert: expr3 expression1 expression2 identifier equals: 'y'.
	self assert: expr3 expression2 identifier equals: 'z'.
	expr3 := grammar expr3 end parse: 'x * y^z'.
	self assert: expr3 isProductNode.
	self assert: expr3 expression1 isUtilityVariableNode.
	self assert: expr3 expression1 identifier equals: 'x'.
	self assert: expr3 expression2 isPowerNode.
	self assert: expr3 expression2 expression1 isUtilityVariableNode.
	self assert: expr3 expression2 expression1 identifier equals: 'y'.
	self assert: expr3 expression2 expression2 isUtilityVariableNode.
	self assert: expr3 expression2 expression2 identifier equals: 'z'
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
RMDGrammarTest >> testLiteral [
	| literal |
	literal := grammar literal parse: '3.14[]'.
	self assert: literal literal equals: '3.14'.
	self assert: literal type equals: RMDUnit noDimension.
	self assert: literal numeric closeTo: 3.14.
	literal := grammar literal parse: '3.14'.
	self assert: literal literal equals: '3.14'.
	self assert: literal type equals: RMDUnit noDimension.
	self assert: literal numeric closeTo: 3.14.
	literal := grammar literal parse: '-3.14[]'.
	self assert: literal literal equals: '-3.14'.
	self assert: literal type equals: (grammar type parse: '[]').
	self assert: literal numeric closeTo: -3.14.
	literal := grammar literal parse: '3[m]'.
	self assert: literal literal equals: '3'.
	self assert: literal type equals: (grammar type parse: '[m]').
	self assert: literal numeric closeTo: 3
]

{ #category : #tests }
RMDGrammarTest >> testPropertyDefinition [
	| definition |
	definition := grammar propertyDefinition parse: 'my x'' = 1[m]'.
	self assert: definition isPropertyDefinitionNode.
	self
		assert: definition variable
		equals: (grammar variable parse: 'my x').
	self
		assert: definition definitionBody
		equals: (grammar literal parse: '1[m]').
	definition := grammar propertyDefinition
		parse: 'foo''s delta x'' = 1[m]'.
	self assert: definition isPropertyDefinitionNode.
	self
		assert: definition variable
		equals: (grammar deltaVariable parse: 'foo''s delta x').
	self
		assert: definition definitionBody
		equals: (grammar literal parse: '1[m]').
	definition := grammar propertyDefinition
		parse:
			'my x'' =		1 if x = 2,
							2 if x = 3,
							3'.
	self deny: definition isPetit2Failure.
	self assert: definition isPropertyDefinitionNode.
	self assert: definition definitionBody isGuardedChoiceNode.
	self
		assert: definition definitionBody
		equals: (grammar guardedChoice end parse: '1 if x = 2, 2 if x = 3, 3')
]

{ #category : #tests }
RMDGrammarTest >> testScript [
	| script |
	script := grammar script
		parse:
			'to walk is
	presume my energy > 0
	my delta x'' = sin(my heading) * walking_distance
	my delta cost'' = 3.2 [ kcal / km ] * walking_distance
where
	walking_speed = 10[km/h] if my energy > 1000[kcal],
	                4[km/h]
	walking_distance = walking_speed * world''s delta time.'.
	self assert: script isScriptNode.
	self assert: script identifier equals: 'walk'.
	self assert: script object equals: nil.
	self
		assert: script guard
		equals: (grammar condition parse: 'my energy > 0').
	self assert: script propertyDefinitions size equals: 2.
	self assert: script utilityDefinitions size equals: 2.
	script := grammar script
		parse:
			'to chase target is
	my delta heading'' = direction target - my heading.'.
	self assert: script isScriptNode.
	self assert: script identifier equals: 'chase'.
	self assert: script object equals: 'target'.
	self assert: script guard equals: true.
	self assert: script propertyDefinitions size equals: 1.
	self assert: script utilityDefinitions size equals: 0
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
	variable := grammar variable parse: 'Foo'.
	self assert: variable isPetit2Failure
]

{ #category : #tests }
RMDGrammarTest >> testVariable [
	| variable |
	variable := grammar variable parse: 'my foo'.
	self deny: variable isPetit2Failure.
	self assert: variable isVariableNode.
	self assert: variable identifier equals: 'foo'.
	self assert: variable agent isNil.
	variable := grammar variable parse: 'foo'.
	self assert: variable isPetit2Failure.
	variable := grammar variable parse: 'foo''s bar'.
	self deny: variable isPetit2Failure.
	self assert: variable isVariableNode.
	self assert: variable agent equals: 'foo'.
	self assert: variable identifier equals: 'bar'
]
