Class {
	#name : #RMDWorldInitializerNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDWorldInitializerNodeTest >> testCopyReplace [
	| node replacement |
	node := parser worldInitializer end
		parse:
			'World with
	temperature = 30 [DegreeC]'.
	replacement := Dictionary new
		at: 'temperature' put: 'temp';
		at: (parser expression end parse: '30 [DegreeC]')
			put: (parser expression end parse: '100 [F]');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals:
			(parser worldInitializer end
				parse:
					'World with
	temp = 100 [F]')
]

{ #category : #tests }
RMDWorldInitializerNodeTest >> testPrintOn [

	| node copy |
	node := parser worldInitializer end parse: 'World with
		x = 1
		y = 2'.
	copy := parser worldInitializer end parse: node printString.
	self assert: copy equals: node.
	node := parser worldInitializer end parse: 'World'.
	copy := parser worldInitializer end parse: node printString.
	self assert: copy equals: node
]
