Extension { #name : #RMDAreaDirectiveNode }

{ #category : #'*ReMobidyc-Spec2' }
RMDAreaDirectiveNode >> asPrettyPrintNode [

	^ RMDPrettyPrintNode directive: self printString
]
