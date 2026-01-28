Class {
	#name : 'RMDUtilityVariableNodeTest',
	#superclass : 'RMDSyntaxNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'tests' }
RMDUtilityVariableNodeTest >> testCopyReplace [
	| node replacement |
	node := parser utilityVariable end parse: 'x'.
	replacement := Dictionary new
		at: 'x' put: 'y';
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser utilityVariable end parse: 'y')
]

{ #category : 'tests' }
RMDUtilityVariableNodeTest >> testPrintOn [

	| node copy |
	node := parser expression end parse: 'x'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node
]
