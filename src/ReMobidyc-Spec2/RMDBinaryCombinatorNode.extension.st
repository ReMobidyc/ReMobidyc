Extension { #name : #RMDBinaryCombinatorNode }

{ #category : #'*ReMobidyc-Spec2' }
RMDBinaryCombinatorNode >> asPrettyPrintNode [

	^ RMDPrettyPrintNode
		  binaryOperator: self prettyOperator
		  arguments: (conditions collect: [ :condition |
				   | node |
				   node := condition asPrettyPrintNode.
				   self precedence <= condition precedence ifTrue: [
					   node := node enclosedByParenthesis ].
				   node ])
]

{ #category : #'*ReMobidyc-Spec2' }
RMDBinaryCombinatorNode >> prettyOperator [

	^ self operator
]
