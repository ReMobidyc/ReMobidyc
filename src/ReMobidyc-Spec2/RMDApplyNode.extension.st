Extension { #name : 'RMDApplyNode' }

{ #category : '*ReMobidyc-Spec2' }
RMDApplyNode >> asPrettyPrintNode [

	^ function = 'power'
		  ifTrue: [
			  | node |
			  node := arguments first asPrettyPrintNode.
			  self precedence < arguments first precedence ifTrue: [
				  node := node enclosedByParenthesis ].
			  node ** arguments second asPrettyPrintNode ]
		  ifFalse: [
			  RMDPrettyPrintNode
				  function: self function
				  arguments: (self arguments collect: #asPrettyPrintNode) ]
]
