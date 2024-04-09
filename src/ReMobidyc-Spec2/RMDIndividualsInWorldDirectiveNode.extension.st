Extension { #name : #RMDIndividualsInWorldDirectiveNode }

{ #category : #'*ReMobidyc-Spec2' }
RMDIndividualsInWorldDirectiveNode >> asPrettyPrintNode [

	^ RMDPrettyPrintNode
		  directive: self directiveName
		  agent: self animatName
		  keyword: self locationName
]
