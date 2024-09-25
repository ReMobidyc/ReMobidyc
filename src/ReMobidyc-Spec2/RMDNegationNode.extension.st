Extension { #name : 'RMDNegationNode' }

{ #category : '*ReMobidyc-Spec2' }
RMDNegationNode >> asPrettyPrintNode [

	| conditionNode negationNode |
	conditionNode := self condition asPrettyPrintNode.
	negationNode := RMDPrettyPrintText operator:
		                (String with: (Character codePoint: 16rac)).
	negationNode , conditionNode.
	^ RMDPrettyPrintNode with: conditionNode with: negationNode
]
