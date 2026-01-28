Class {
	#name : 'RMDNormalDistributionTest',
	#superclass : 'RMDSyntaxNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'tests' }
RMDNormalDistributionTest >> testCopyReplace [
	| node replacement |
	node := parser expression end
		parse: 'normal 100 [kcal] sigma 200 [kcal]'.
	replacement := Dictionary new
		at: (self expression: '100 [kcal]')
			put: (self expression: '110 [kcal]');
		at: (self expression: '200 [kcal]')
			put: (self expression: '220 [kcal]');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser expression end parse: 'normal 110 [kcal] sigma 220 [kcal]')
]

{ #category : 'tests' }
RMDNormalDistributionTest >> testPrintOn [

	| node copy |
	node := parser expression end parse: 'normal 0 sigma 1'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node
]
