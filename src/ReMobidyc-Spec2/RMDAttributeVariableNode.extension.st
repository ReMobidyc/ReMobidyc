Extension { #name : #RMDAttributeVariableNode }

{ #category : #'*ReMobidyc-Spec2' }
RMDAttributeVariableNode >> asPrettyPrintNode [

	^ RMDPrettyPrintNode agent: self prefix attribute: self identifier
]
