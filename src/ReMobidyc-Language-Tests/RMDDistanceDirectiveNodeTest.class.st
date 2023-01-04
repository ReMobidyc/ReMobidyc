Class {
	#name : #RMDDistanceDirectiveNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDDistanceDirectiveNodeTest >> testCopyReplace [
	| node replacement |
	node := parser expression end parse: 'distance target'.
	replacement := Dictionary new
		at: (self expression: 'distance target')
			put: (self expression: '10 [mm]');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser expression end parse: '10 [mm]')
]

{ #category : #tests }
RMDDistanceDirectiveNodeTest >> testPrintOn [

	| node copy |
	node := parser expression end parse: 'distance target'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node.
	node := parser expression end parse:
		        '(distance target) + (distance another)'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node
]
