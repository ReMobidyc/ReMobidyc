Extension { #name : #RMDUniformDistributionTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDUniformDistributionTest >> testEvalIn [
	| node cm m values |
	node := parser uniformDistribution parse: 'uniform -10[cm] to 2[m]'.
	cm := 'cm' asRMDUnit.
	m := 'm' asRMDUnit.
	self assert: node isUniformDistributionNode.
	values := ((1 to: 1000) collect: [ :i | node evalIn: interpreter ])
		asSortedCollection.
	self assert: (values first between: (cm toSI: -10) and: 0.0).
	self assert: (values last between: 1.0 and: (m toSI: 2))
]
