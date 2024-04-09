Extension { #name : #RMDRandomNode }

{ #category : #'*ReMobidyc-Spec2' }
RMDRandomNode >> asPrettyPrintNode [

	^ RMDPrettyPrintNode
		  directive: self distributionName
		  node: self parameter1Expression asPrettyPrintNode
		  suffix: self parameterName
		  node: self parameter2Expression asPrettyPrintNode
]
