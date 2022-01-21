Class {
	#name : #RMDPropertyInitializerNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDPropertyInitializerNodeTest >> testCopyReplace [
	| node replacement |
	node := parser propertyInitializer end
		parse:
			'temperature = 30 [C]'.
	replacement := Dictionary new
		at: 'temperature' put: 'temp';
		at: (parser expression end parse: '30 [C]')
			put: (parser expression end parse: '100 [F]');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals:
			(parser propertyInitializer end
				parse:
					'temp = 100 [F]')
]

{ #category : #tests }
RMDPropertyInitializerNodeTest >> testPrintOn [

	| node copy |
	node := parser propertyInitializer end parse: 'x = y'.
	copy := parser propertyInitializer end parse: node printString.
	self assert: copy equals: node
]
