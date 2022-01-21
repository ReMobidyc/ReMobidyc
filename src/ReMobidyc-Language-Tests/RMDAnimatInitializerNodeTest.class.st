Class {
	#name : #RMDAnimatInitializerNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDAnimatInitializerNodeTest >> testCopyReplace [
	| node replacement |
	node := parser animatInitializer end
		parse:
			'10 Goat with
blood_sugar = uniform 1000 [kcal] to 2000 [kcal]'.
	replacement := Dictionary new
		at: (self expression: '1000 [kcal]')
			put: (self expression: '1500 [kcal]');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals:
			(parser animatInitializer end
				parse:
					'10 Goat with
blood_sugar = uniform 1500 [kcal] to 2000 [kcal]')
]

{ #category : #tests }
RMDAnimatInitializerNodeTest >> testPrintOn [

	| node copy |
	node := parser animatInitializer end parse: '10 A with
		x = 1
		y = 2'.
	copy := parser animatInitializer end parse: node printString.
	self assert: copy equals: node.
	node := parser animatInitializer end parse: '10 A'.
	copy := parser animatInitializer end parse: node printString.
	self assert: copy equals: node
]
