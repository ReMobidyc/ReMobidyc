Extension { #name : 'RMDFractionNode' }

{ #category : '*ReMobidyc-Spec2' }
RMDFractionNode >> asPrettyPrintNode [

	^ self expression1 asPrettyPrintNode
	  / self expression2 asPrettyPrintNode
]
