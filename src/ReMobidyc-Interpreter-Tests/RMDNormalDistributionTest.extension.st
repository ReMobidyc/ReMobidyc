Extension { #name : 'RMDNormalDistributionTest' }

{ #category : '*ReMobidyc-Interpreter-Tests' }
RMDNormalDistributionTest >> testEvalIn [

	| node cm m values |
	node := parser normalDistribution parse: 'normal 10[m] sigma 2[cm]'.
	cm := 'cm' asRMDUnit.
	m := 'm' asRMDUnit.
	self assert: node isNormalDistributionNode.
	values := ((1 to: 1000) collect: [ :i | node evalIn: interpreter ])
		          asSortedCollection
]
