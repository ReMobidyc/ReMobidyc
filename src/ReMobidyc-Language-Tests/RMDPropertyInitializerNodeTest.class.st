Class {
	#name : #RMDPropertyInitializerNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDPropertyInitializerNodeTest >> testCopyReplace [
	| node replacement |
	node := parser attributeInitializer end
		parse:
			'temperature = 30 [DegreeC]'.
	replacement := Dictionary new
		at: 'temperature' put: 'temp';
		at: (parser expression end parse: '30 [DegreeC]')
			put: (parser expression end parse: '100 [F]');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals:
			(parser attributeInitializer end
				parse:
					'temp = 100 [DegreeF]')
]

{ #category : #tests }
RMDPropertyInitializerNodeTest >> testPrintOn [

	| node copy |
	node := parser attributeInitializer end parse: 'x = y'.
	copy := parser attributeInitializer end parse: node printString.
	self assert: copy equals: node
]
