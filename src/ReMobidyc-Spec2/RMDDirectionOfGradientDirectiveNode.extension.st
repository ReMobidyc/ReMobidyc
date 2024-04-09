Extension { #name : #RMDDirectionOfGradientDirectiveNode }

{ #category : #'*ReMobidyc-Spec2' }
RMDDirectionOfGradientDirectiveNode >> asPrettyPrintNode [

	^ RMDPrettyPrintNode
		  directive: 'direction neighbor''s'
		  attribute: self patchAttributeVariable identifier
]
