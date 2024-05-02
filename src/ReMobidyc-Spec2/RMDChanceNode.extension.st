Extension { #name : 'RMDChanceNode' }

{ #category : '*ReMobidyc-Spec2' }
RMDChanceNode >> asPrettyPrintNode [

	| probNode chanceNode |
	probNode := self probability asPrettyPrintNode.
	chanceNode := RMDPrettyPrintText keyword: 'chance'.
	probNode , chanceNode.
	^ RMDPrettyPrintNode with: probNode with: chanceNode
]
