Extension { #name : 'RMDIndividualsInRadiusDirectiveNode' }

{ #category : '*ReMobidyc-Spec2' }
RMDIndividualsInRadiusDirectiveNode >> asPrettyPrintNode [

	^ RMDPrettyPrintNode
		  directive: self directiveName
		  agent: self animatName
		  keyword: 'in'
		  expression: self radius asPrettyPrintNode
		  keyword: self locationName
]
