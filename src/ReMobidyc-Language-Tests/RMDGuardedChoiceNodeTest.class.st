Class {
	#name : 'RMDGuardedChoiceNodeTest',
	#superclass : 'RMDSyntaxNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'tests' }
RMDGuardedChoiceNodeTest >> testCopyReplace [
	| node replacement |
	node := parser guardedChoice end parse: 'a if x = y, b'.
	replacement := Dictionary new
		at: (self expression: 'b') put: (self expression: 'x');
		at: (self expression: 'x') put: (self expression: 'z');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser guardedChoice end parse: 'a if z = y, x')
]

{ #category : 'tests' }
RMDGuardedChoiceNodeTest >> testPrintOn [

	| node copy |
	node := parser guardedChoice end parse: '1 if x > y, 2 if x > z, 3'.
	copy := parser guardedChoice end parse: node printString.
	self assert: copy equals: node
]
