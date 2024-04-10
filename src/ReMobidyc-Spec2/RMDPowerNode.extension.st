Extension { #name : #RMDPowerNode }

{ #category : #'*ReMobidyc-Spec2' }
RMDPowerNode >> asPrettyPrintNode [

	| node |
	node := self expression asPrettyPrintNode.
	self precedence < expression precedence ifTrue: [
		node := node enclosedByParenthesis ].
	^ node ** self order
]
