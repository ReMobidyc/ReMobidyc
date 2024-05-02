Extension { #name : 'RMDBinaryOperatorApplicationNode' }

{ #category : '*ReMobidyc-Spec2' }
RMDBinaryOperatorApplicationNode >> asPrettyPrintNode [

	| node1 node2 |
	node1 := self expression1 asPrettyPrintNode.
	self precedence < self expression1 precedence ifTrue: [
		node1 := node1 enclosedByParenthesis ].
	node2 := self expression2 asPrettyPrintNode.
	self precedence < self expression2 precedence ifTrue: [
		node2 := node2 enclosedByParenthesis ].
	^ RMDPrettyPrintNode
		  binaryOperator: self prettyOperator
		  arguments: {
				  node1.
				  node2 }
]

{ #category : '*ReMobidyc-Spec2' }
RMDBinaryOperatorApplicationNode >> prettyOperator [

	^ self operator
]
