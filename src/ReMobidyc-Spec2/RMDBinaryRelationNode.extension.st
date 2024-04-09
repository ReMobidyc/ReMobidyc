Extension { #name : #RMDBinaryRelationNode }

{ #category : #'*ReMobidyc-Spec2' }
RMDBinaryRelationNode >> asPrettyPrintNode [

	^ RMDPrettyPrintNode
		  binaryOperator: self operator
		  arguments: (expressions collect: #asPrettyPrintNode)
]

{ #category : #'*ReMobidyc-Spec2' }
RMDBinaryRelationNode >> prettyOperator [

	^ self operator
]
