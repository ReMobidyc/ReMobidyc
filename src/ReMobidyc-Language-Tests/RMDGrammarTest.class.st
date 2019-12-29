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
		equals: (RMDVariableNode symbol: 'x').
	apply := grammar apply parse: 'max(x, y)'.
	self assert: apply isApplyNode.
	self assert: apply function equals: 'max'.
	self assert: apply arguments size equals: 2.
	self
		assert: apply arguments first
		equals: (RMDVariableNode symbol: 'x').
	self
		assert: apply arguments second
		equals: (RMDVariableNode symbol: 'y').
	apply := grammar apply parse: 'max3(x, y, z)'.
	self assert: apply isApplyNode.
	self assert: apply function equals: 'max3'.
	self assert: apply arguments size equals: 3.
	self
		assert: apply arguments first
		equals: (RMDVariableNode symbol: 'x').
	self
		assert: apply arguments second
		equals: (RMDVariableNode symbol: 'y').
	self
		assert: apply arguments third
		equals: (RMDVariableNode symbol: 'z')
]

{ #category : #tests }
RMDGrammarTest >> testDelta [
	| modifiedVariable |
	modifiedVariable := grammar delta parse: 'delta x'.
	self deny: modifiedVariable isPetit2Failure.
	self assert: modifiedVariable isDeltaNode.
	self assert: modifiedVariable symbol equals: 'x'.
	modifiedVariable := grammar delta parse: 'Δ vx'.
	self deny: modifiedVariable isPetit2Failure.
	self assert: modifiedVariable isDeltaNode.
	self assert: modifiedVariable symbol equals: 'vx'.
	modifiedVariable := grammar delta parse: 'delta   変数'.
	self deny: modifiedVariable isPetit2Failure.
	self assert: modifiedVariable isDeltaNode.
	self assert: modifiedVariable symbol equals: '変数'.
	modifiedVariable := grammar delta parse: ' x'.
	self assert: modifiedVariable isPetit2Failure
]

{ #category : #tests }
RMDGrammarTest >> testDifferential [
	| modifiedVariable |
	modifiedVariable := grammar differential parse: 'd/dt x'.
	self deny: modifiedVariable isPetit2Failure.
	self assert: modifiedVariable isDifferentialNode.
	self assert: modifiedVariable symbol equals: 'x'.
	modifiedVariable := grammar differential parse: 'd/dt vx'.
	self deny: modifiedVariable isPetit2Failure.
	self assert: modifiedVariable isDifferentialNode.
	self assert: modifiedVariable symbol equals: 'vx'.
	modifiedVariable := grammar differential parse: 'd/dt   変数'.
	self deny: modifiedVariable isPetit2Failure.
	self assert: modifiedVariable isDifferentialNode.
	self assert: modifiedVariable symbol equals: '変数'.
	modifiedVariable := grammar differential parse: ' x'.
	self assert: modifiedVariable isPetit2Failure
]

{ #category : #tests }
RMDGrammarTest >> testDifferential2 [
	| modifiedVariable |
	modifiedVariable := grammar differential2 parse: 'd2/dt2 x'.
	self deny: modifiedVariable isPetit2Failure.
	self assert: modifiedVariable isDifferential2Node.
	self assert: modifiedVariable symbol equals: 'x'.
	modifiedVariable := grammar differential2 parse: 'd^2/dt^2 vx'.
	self deny: modifiedVariable isPetit2Failure.
	self assert: modifiedVariable isDifferential2Node.
	self assert: modifiedVariable symbol equals: 'vx'.
	modifiedVariable := grammar differential2 parse: 'd2/dt2   変数'.
	self deny: modifiedVariable isPetit2Failure.
	self assert: modifiedVariable isDifferential2Node.
	self assert: modifiedVariable symbol equals: '変数'.
	modifiedVariable := grammar differential2 parse: ' x'.
	self assert: modifiedVariable isPetit2Failure
]

{ #category : #tests }
RMDGrammarTest >> testExpr1 [
	| expr1 |
	expr1 := grammar expr1 parse: 'x'.
	self assert: expr1 isVariableNode.
	self assert: expr1 symbol equals: 'x'.
	expr1 := grammar expr1 parse: 'old x'.
	self assert: expr1 isOldNode.
	self assert: expr1 symbol equals: 'x'.
	expr1 := grammar expr1 parse: 'delta x'.
	self assert: expr1 isDeltaNode.
	self assert: expr1 symbol equals: 'x'.
	expr1 := grammar expr1 parse: 'd/dt x'.
	self assert: expr1 isDifferentialNode.
	self assert: expr1 symbol equals: 'x'.
	expr1 := grammar expr1 parse: 'd2/dt2 x'.
	self assert: expr1 isDifferential2Node.
	self assert: expr1 symbol equals: 'x'.
	expr1 := grammar expr1 parse: 'f(x)'.
	self assert: expr1 isApplyNode.
	self assert: expr1 function equals: 'f'.
	self assert: expr1 arguments equals: {(RMDVariableNode symbol: 'x')}
]

{ #category : #tests }
RMDGrammarTest >> testExpr2 [
	| expr2 |
	expr2 := grammar expr2 parse: 'x'.
	self assert: expr2 isVariableNode.
	self assert: expr2 symbol equals: 'x'.
	expr2 := grammar expr2 parse: 'x^y^z'.
	self assert: expr2 isPowerNode.
	self assert: expr2 expression1 isVariableNode.
	self assert: expr2 expression1 symbol equals: 'x'.
	self assert: expr2 expression2 isPowerNode.
	self assert: expr2 expression2 expression1 isVariableNode.
	self assert: expr2 expression2 expression1 symbol equals: 'y'.
	self assert: expr2 expression2 expression2 isVariableNode.
	self assert: expr2 expression2 expression2 symbol equals: 'z'
]

{ #category : #tests }
RMDGrammarTest >> testExpr3 [
	| expr3 |
	expr3 := grammar expr3 parse: 'x'.
	self assert: expr3 isVariableNode.
	self assert: expr3 symbol equals: 'x'.
	expr3 := grammar expr3 parse: 'x * y * z'.
	self assert: expr3 isProductNode.
	self assert: expr3 expression1 isProductNode.
	self assert: expr3 expression1 expression1 symbol equals: 'x'.
	self assert: expr3 expression1 expression2 symbol equals: 'y'.
	self assert: expr3 expression2 symbol equals: 'z'.
	expr3 := grammar expr3 parse: 'd/dt x * delta y * old z'.
	self assert: expr3 isProductNode.
	self assert: expr3 expression1 isProductNode.
	self assert: expr3 expression1 expression1 isDifferentialNode.
	self assert: expr3 expression1 expression1 symbol equals: 'x'.
	self assert: expr3 expression1 expression2 isDeltaNode.
	self assert: expr3 expression1 expression2 symbol equals: 'y'.
	self assert: expr3 expression2 isOldNode.
	self assert: expr3 expression2 symbol equals: 'z'.
	expr3 := grammar expr3 end parse: 'x * y^z'.
	self assert: expr3 isProductNode.
	self assert: expr3 expression1 isVariableNode.
	self assert: expr3 expression1 symbol equals: 'x'.
	self assert: expr3 expression2 isPowerNode.
	self assert: expr3 expression2 expression1 isVariableNode.
	self assert: expr3 expression2 expression1 symbol equals: 'y'.
	self assert: expr3 expression2 expression2 isVariableNode.
	self assert: expr3 expression2 expression2 symbol equals: 'z'
]

{ #category : #tests }
RMDGrammarTest >> testExpr4 [
	| expr4 |
	expr4 := grammar expr4 parse: 'x / y'.
	self assert: expr4 isFractionNode.
	self assert: expr4 expression1 symbol equals: 'x'.
	self assert: expr4 expression2 symbol equals: 'y'.
	expr4 := grammar expr4 parse: 'x * y / z'.
	self assert: expr4 isFractionNode.
	self assert: expr4 expression1 isProductNode.
	self assert: expr4 expression2 symbol equals: 'z'.
	expr4 := grammar expr4 parse: 'x / y * z'.
	self assert: expr4 isFractionNode.
	self assert: expr4 expression1 symbol equals: 'x'.
	self assert: expr4 expression2 isProductNode
]

{ #category : #tests }
RMDGrammarTest >> testExpr5 [
	| expr5 |
	expr5 := grammar expr5 parse: 'x + y - z'.
	self assert: expr5 isSubtractionNode.
	self assert: expr5 expression1 isAdditionNode.
	self assert: expr5 expression1 expression1 symbol equals: 'x'.
	self assert: expr5 expression1 expression2 symbol equals: 'y'.
	self assert: expr5 expression2 symbol equals: 'z'.
	expr5 := grammar expr5 parse: 'x - y + z'.
	self assert: expr5 isAdditionNode.
	self assert: expr5 expression1 isSubtractionNode.
	self assert: expr5 expression1 expression1 symbol equals: 'x'.
	self assert: expr5 expression1 expression2 symbol equals: 'y'.
	self assert: expr5 expression2 symbol equals: 'z'.
	expr5 := grammar expr5 parse: 'x * y + z'.
	self assert: expr5 isAdditionNode.
	self assert: expr5 expression1 isProductNode.
	self assert: expr5 expression1 expression1 symbol equals: 'x'.
	self assert: expr5 expression1 expression2 symbol equals: 'y'.
	self assert: expr5 expression2 symbol equals: 'z'.
	expr5 := grammar expr5 parse: 'x + y * z'.
	self assert: expr5 isAdditionNode.
	self assert: expr5 expression1 symbol equals: 'x'.
	self assert: expr5 expression2 isProductNode.
	self assert: expr5 expression2 expression1 symbol equals: 'y'.
	self assert: expr5 expression2 expression2 symbol equals: 'z'
]

{ #category : #tests }
RMDGrammarTest >> testFunction [
	| function |
	function := grammar function parse: 'max('.
	self assert: function equals: 'max'.
	function := grammar function parse: 'max ('.
	self assert: function equals: 'max'.
	function := grammar function parse: 'max3('.
	self assert: function equals: 'max3'
]

{ #category : #tests }
RMDGrammarTest >> testLiteral [
	| literal |
	literal := grammar literal parse: '3.14'.
	self assert: literal literal equals: '3.14'.
	self assert: literal numeric closeTo: 3.14.
	literal := grammar literal parse: '-3.14'.
	self assert: literal literal equals: '-3.14'.
	self assert: literal numeric closeTo: -3.14.
	literal := grammar literal parse: '3'.
	self assert: literal literal equals: '3'.
	self assert: literal numeric closeTo: 3
]

{ #category : #tests }
RMDGrammarTest >> testOld [
	| modifiedVariable |
	modifiedVariable := grammar old parse: 'old x'.
	self deny: modifiedVariable isPetit2Failure.
	self assert: modifiedVariable isOldNode.
	self assert: modifiedVariable symbol equals: 'x'.
	modifiedVariable := grammar old parse: 'old      vx'.
	self deny: modifiedVariable isPetit2Failure.
	self assert: modifiedVariable isOldNode.
	self assert: modifiedVariable symbol equals: 'vx'.
	modifiedVariable := grammar old parse: 'old 変数'.
	self deny: modifiedVariable isPetit2Failure.
	self assert: modifiedVariable isOldNode.
	self assert: modifiedVariable symbol equals: '変数'.
	modifiedVariable := grammar old parse: ' x'.
	self assert: modifiedVariable isPetit2Failure
]

{ #category : #tests }
RMDGrammarTest >> testVariable [
	| variable |
	variable := grammar variable parse: 'x'.
	self deny: variable isPetit2Failure.
	self assert: variable isVariableNode.
	self assert: variable symbol equals: 'x'.
	variable := grammar variable parse: 'vx'.
	self deny: variable isPetit2Failure.
	self assert: variable isVariableNode.
	self assert: variable symbol equals: 'vx'.
	variable := grammar variable parse: '変数'.
	self deny: variable isPetit2Failure.
	self assert: variable isVariableNode.
	self assert: variable symbol equals: '変数'.
	variable := grammar variable parse: ' x'.
	self assert: variable isPetit2Failure
]
