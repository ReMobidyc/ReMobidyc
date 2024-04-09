Extension { #name : #RMDIndividualsInPatchDirectiveNode }

{ #category : #'*ReMobidyc-Spec2' }
RMDIndividualsInPatchDirectiveNode >> asPrettyPrintNode [

	^ RMDPrettyPrintNode
		  directive: self directiveName
		  agent: self animatName
		  keyword: self locationName
]
