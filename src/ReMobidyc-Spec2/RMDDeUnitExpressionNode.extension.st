Extension { #name : #RMDDeUnitExpressionNode }

{ #category : #'*ReMobidyc-Spec2' }
RMDDeUnitExpressionNode >> asPrettyPrintNode [

	| unitNode expressionNode |
	unitNode := RMDPrettyPrintText unit:
		            '(' , self unit printString , ')'.
	expressionNode := self expression asPrettyPrintNode
		                  enclosedByParenthesis.
	unitNode , expressionNode.
	^ RMDPrettyPrintNode with: unitNode with: expressionNode
]
