Extension { #name : #RMDApplyNode }

{ #category : #'*ReMobidyc-Spec2' }
RMDApplyNode >> asPrettyPrintNode [

	^ RMDPrettyPrintNode
		  function: self function
		  arguments: (self arguments collect: #asPrettyPrintNode)
]
