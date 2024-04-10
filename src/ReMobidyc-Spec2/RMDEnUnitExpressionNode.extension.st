Extension { #name : #RMDEnUnitExpressionNode }

{ #category : #'*ReMobidyc-Spec2' }
RMDEnUnitExpressionNode >> asPrettyPrintNode [

	| unitNode expressionNode |
	unitNode := RMDPrettyPrintText unit:
		            '[' , self unit printString , ']'.
	expressionNode := self expression asPrettyPrintNode
		                  enclosedByParenthesis.
	expressionNode , unitNode.
	^ RMDPrettyPrintNode with: expressionNode with: unitNode
]
