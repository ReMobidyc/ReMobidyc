Class {
	#name : #RMDUniformDistributionTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDUniformDistributionTest >> testCopyReplace [
	| node replacement |
	node := parser expression end
		parse: 'uniform 100 [kcal] to 200 [kcal]'.
	replacement := Dictionary new
		at: (self expression: '100 [kcal]')
			put: (self expression: '110 [kcal]');
		at: (self expression: '200 [kcal]')
			put: (self expression: '220 [kcal]');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser expression end parse: 'uniform 110 [kcal] to 220 [kcal]')
]

{ #category : #tests }
RMDUniformDistributionTest >> testPrintOn [

	| node copy |
	node := parser expression end parse: 'uniform 0 to 1'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node
]
