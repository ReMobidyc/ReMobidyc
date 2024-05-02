Extension { #name : 'RMDDeltaTimeDirectiveNode' }

{ #category : '*ReMobidyc-Spec2' }
RMDDeltaTimeDirectiveNode >> asPrettyPrintNode [

	^ RMDPrettyPrintNode directive: self printString
]
