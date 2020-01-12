Class {
	#name : #RMDGrammarTest,
	#superclass : #TestCase,
	#instVars : [
		'grammar'
	],
	#category : #'ReMobidyc-Language-Tests'
}

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
		equals: (RMDVariableNode identifier: 'x').
	apply := grammar apply parse: 'max(x, y)'.
	self assert: apply isApplyNode.
	self assert: apply function equals: 'max'.
	self assert: apply arguments size equals: 2.
	self
		assert: apply arguments first
		equals: (RMDVariableNode identifier: 'x').
	self
		assert: apply arguments second
		equals: (RMDVariableNode identifier: 'y').
	apply := grammar apply parse: 'max3(x, y, z)'.
	self assert: apply isApplyNode.
	self assert: apply function equals: 'max3'.
	self assert: apply arguments size equals: 3.
	self
		assert: apply arguments first
		equals: (RMDVariableNode identifier: 'x').
	self
		assert: apply arguments second
		equals: (RMDVariableNode identifier: 'y').
	self
		assert: apply arguments third
		equals: (RMDVariableNode identifier: 'z')
]

{ #category : #tests }
RMDGrammarTest >> testDeltaVariable [
	| variable |
	variable := grammar deltaVariable parse: 'delta foo'.
	self deny: variable isPetit2Failure.
	self assert: variable isDeltaVariableNode.
	self assert: variable agent isNil.
	self assert: variable identifier equals: 'foo'.
	variable := grammar deltaVariable parse: 'delta Foo'.
	self assert: variable isPetit2Failure.
	variable := grammar deltaVariable parse: 'Δfoo'.
	self deny: variable isPetit2Failure.
	self assert: variable isDeltaVariableNode.
	self assert: variable agent isNil.
	self assert: variable identifier equals: 'foo'.
	variable := grammar deltaVariable parse: 'Foo''s delta bar'.
	self deny: variable isPetit2Failure.
	self assert: variable isDeltaVariableNode.
	self assert: variable agent equals: 'Foo'.
	self assert: variable identifier equals: 'bar'.
	variable := grammar deltaVariable parse: 'Foo''s Δbar'.
	self deny: variable isPetit2Failure.
	self assert: variable isDeltaVariableNode.
	self assert: variable agent equals: 'Foo'.
	self assert: variable identifier equals: 'bar'
]

{ #category : #tests }
RMDGrammarTest >> testDifferential2Variable [
	| variable |
	variable := grammar differential2Variable parse: 'd2/dt2 x'.
	self deny: variable isPetit2Failure.
	self assert: variable isDifferential2VariableNode.
	self assert: variable identifier equals: 'x'.
	variable := grammar differential2Variable parse: 'd2/dt2 X'.
	self assert: variable isPetit2Failure.
	variable := grammar differential2Variable parse: 'd^2/dt^2 vx'.
	self deny: variable isPetit2Failure.
	self assert: variable isDifferential2VariableNode.
	self assert: variable identifier equals: 'vx'.
	variable := grammar differential2Variable parse: 'd2/dt2   sugar'.
	self deny: variable isPetit2Failure.
	self assert: variable isDifferential2VariableNode.
	self assert: variable identifier equals: 'sugar'.
	variable := grammar differential2Variable parse: ' x'.
	self assert: variable isPetit2Failure
]

{ #category : #tests }
RMDGrammarTest >> testDifferentialVariable [
	| variable |
	variable := grammar differentialVariable parse: 'd/dt foo'.
	self deny: variable isPetit2Failure.
	self assert: variable isDifferentialVariableNode.
	self assert: variable agent isNil.
	self assert: variable identifier equals: 'foo'.
	variable := grammar differentialVariable parse: 'd/dt X'.
	self assert: variable isPetit2Failure.
	variable := grammar differentialVariable parse: 'Foo''s d/dt bar'.
	self deny: variable isPetit2Failure.
	self assert: variable isDifferentialVariableNode.
	self assert: variable agent equals: 'Foo'.
	self assert: variable identifier equals: 'bar'
]

{ #category : #tests }
RMDGrammarTest >> testExpr1 [
	| expr1 |
	expr1 := grammar expr1 parse: 'x'.
	self assert: expr1 isVariableNode.
	self assert: expr1 identifier equals: 'x'.
	expr1 := grammar expr1 parse: 'delta x'.
	self assert: expr1 isDeltaVariableNode.
	self assert: expr1 identifier equals: 'x'.
	expr1 := grammar expr1 parse: 'd/dt x'.
	self assert: expr1 isDifferentialVariableNode.
	self assert: expr1 identifier equals: 'x'.
	expr1 := grammar expr1 parse: 'd2/dt2 x'.
	self assert: expr1 isDifferential2VariableNode.
	self assert: expr1 identifier equals: 'x'.
	expr1 := grammar expr1 parse: 'f(x)'.
	self assert: expr1 isApplyNode.
	self assert: expr1 function equals: 'f'.
	self assert: expr1 arguments equals: {(RMDVariableNode identifier: 'x')}.
	expr1 := grammar expr1 parse: '1[m]'.
	self assert: expr1 isLiteralNode.
	self assert: expr1 numeric closeTo: 1.
	expr1 := grammar expr1 parse: '1'.
	self assert: expr1 isPetit2Failure
]

{ #category : #tests }
RMDGrammarTest >> testExpr2 [
	| expr2 |
	expr2 := grammar expr2 parse: 'x'.
	self assert: expr2 isVariableNode.
	self assert: expr2 identifier equals: 'x'.
	expr2 := grammar expr2 parse: 'x^(y^z)'.
	self assert: expr2 isPowerNode.
	self assert: expr2 expression1 isVariableNode.
	self assert: expr2 expression1 identifier equals: 'x'.
	self assert: expr2 expression2 isPowerNode.
	self assert: expr2 expression2 expression1 isVariableNode.
	self assert: expr2 expression2 expression1 identifier equals: 'y'.
	self assert: expr2 expression2 expression2 isVariableNode.
	self assert: expr2 expression2 expression2 identifier equals: 'z'
]

{ #category : #tests }
RMDGrammarTest >> testExpr3 [
	| expr3 |
	expr3 := grammar expr3 parse: 'x'.
	self assert: expr3 isVariableNode.
	self assert: expr3 identifier equals: 'x'.
	expr3 := grammar expr3 parse: 'x * y * z'.
	self assert: expr3 isProductNode.
	self assert: expr3 expression1 isProductNode.
	self assert: expr3 expression1 expression1 identifier equals: 'x'.
	self assert: expr3 expression1 expression2 identifier equals: 'y'.
	self assert: expr3 expression2 identifier equals: 'z'.
	expr3 := grammar expr3 parse: 'd/dt x * delta y * z'.
	self assert: expr3 isProductNode.
	self assert: expr3 expression1 isProductNode.
	self assert: expr3 expression1 expression1 isDifferentialVariableNode.
	self assert: expr3 expression1 expression1 identifier equals: 'x'.
	self assert: expr3 expression1 expression2 isDeltaVariableNode.
	self assert: expr3 expression1 expression2 identifier equals: 'y'.
	self assert: expr3 expression2 identifier equals: 'z'.
	expr3 := grammar expr3 end parse: 'x * y^z'.
	self assert: expr3 isProductNode.
	self assert: expr3 expression1 isVariableNode.
	self assert: expr3 expression1 identifier equals: 'x'.
	self assert: expr3 expression2 isPowerNode.
	self assert: expr3 expression2 expression1 isVariableNode.
	self assert: expr3 expression2 expression1 identifier equals: 'y'.
	self assert: expr3 expression2 expression2 isVariableNode.
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
RMDGrammarTest >> testLiteral [
	| literal |
	literal := grammar literal parse: '3.14[]'.
	self assert: literal literal equals: '3.14'.
	self assert: literal type equals: (grammar type parse: '[]').
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
	definition := grammar propertyDefinition parse: 'x'' = 1[m]'.
	self assert: definition isPropertyDefinitionNode.
	self
		assert: definition variable
		equals: (grammar variable parse: 'x').
	self
		assert: definition definitionBody
		equals: (grammar literal parse: '1[m]').
	definition := grammar propertyDefinition parse: 'delta x'' = 1[m]'.
	self assert: definition isPropertyDefinitionNode.
	self
		assert: definition variable
		equals: (grammar deltaVariable parse: 'delta x').
	self
		assert: definition definitionBody
		equals: (grammar literal parse: '1[m]')
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
		equals: (grammar variable parse: 'x').
	self
		assert: definition definitionBody
		equals: (grammar literal parse: '1[m]')
]

{ #category : #tests }
RMDGrammarTest >> testVariable [
	| variable |
	variable := grammar variable parse: 'foo'.
	self deny: variable isPetit2Failure.
	self assert: variable isVariableNode.
	self assert: variable identifier equals: 'foo'.
	self assert: variable agent isNil.
	variable := grammar variable parse: 'Foo'.
	self assert: variable isPetit2Failure.
	variable := grammar variable parse: 'Foo''s bar'.
	self deny: variable isPetit2Failure.
	self assert: variable isVariableNode.
	self assert: variable agent equals: 'Foo'.
	self assert: variable identifier equals: 'bar'
]
