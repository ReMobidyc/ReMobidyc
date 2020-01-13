Class {
	#name : #RMDGuardedChoiceNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDGuardedChoiceNodeTest >> testEvalIn [
	| expr |
	expr := parser guardedChoice parse: '1 if 2 = 3, 4 if 5 = 5, 6'.
	self assert: (expr evalIn: interpreter) closeTo: 4.
	expr := parser guardedChoice parse: '1 if 2 = 3, 4 if 5 = 6, 7'.
	self assert: (expr evalIn: interpreter) closeTo: 7
]
