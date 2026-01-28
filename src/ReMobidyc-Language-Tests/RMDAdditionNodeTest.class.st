Class {
	#name : 'RMDAdditionNodeTest',
	#superclass : 'RMDSyntaxNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'tests' }
RMDAdditionNodeTest >> testCopyReplace [
	| node replacement |
	node := parser expression end parse: 'a + target''s b'.
	replacement := Dictionary new
		at: (self expression: 'a') put: (self expression: '10 [kcal]');
		at: (self expression: 'target''s b')
			put: (self expression: '20 [kcal]');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser expression end parse: '10 [kcal] + 20 [kcal]')
]

{ #category : 'tests' }
RMDAdditionNodeTest >> testPrintOn [

	| node copy |
	node := parser expression end parse: 'x + y'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node
]
