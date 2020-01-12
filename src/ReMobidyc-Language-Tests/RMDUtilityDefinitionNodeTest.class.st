Class {
	#name : #RMDUtilityDefinitionNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDUtilityDefinitionNodeTest >> testEvalIn [
	| expr |
	expr := parser utilityDefinition parse: 'foo = 1 + 2'.
	self assert: (interpreter readUtility: 'foo' ifAbsent: [nil]) isNil.
	self assert: (expr evalIn: interpreter) closeTo: 3.
	self assert: (interpreter readUtility: 'foo' ifAbsent: [nil]) closeTo: 3
]
