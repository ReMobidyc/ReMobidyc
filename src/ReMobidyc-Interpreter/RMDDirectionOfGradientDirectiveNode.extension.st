Extension { #name : #RMDDirectionOfGradientDirectiveNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDDirectionOfGradientDirectiveNode >> evalIn: aRMDInterpreter [

	| attribute here west east south north vector |
	patchAttributeVariable isPlaceholderNode ifTrue: [ 
		^ RMDUnresolvedPlaceholderError signal: patchAttributeVariable ].
	attribute := patchAttributeVariable identifier.
	here := aRMDInterpreter heres: attribute.
	east := aRMDInterpreter easts: attribute ifAbsent: [ here ].
	west := aRMDInterpreter wests: attribute ifAbsent: [ here ].
	south := aRMDInterpreter souths: attribute ifAbsent: [ here ].
	north := aRMDInterpreter norths: attribute ifAbsent: [ here ].
	vector := east - west @ (north - south).
	(east <= here and: [ 
		 west <= here and: [ south <= here and: [ north <= here ] ] ]) 
		ifTrue: [ 
			| x y patchX patchY |
			x := aRMDInterpreter my: 'x'.
			y := aRMDInterpreter my: 'y'.
			patchX := aRMDInterpreter patchLength
			          * ((aRMDInterpreter patchX: x) floor + 0.5).
			patchY := aRMDInterpreter patchLength
			          * ((aRMDInterpreter patchY: y) floor + 0.5).
			vector := patchX - x @ (patchY - y) ].
	^ vector theta ifNanOrInfinite: [ RMDNotComputableError signal: self ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDDirectionOfGradientDirectiveNode >> typecheckIn: aRMDInterpreter [

	patchAttributeVariable isPlaceholderNode ifTrue: [ 
		^ RMDUnresolvedPlaceholderError signal: patchAttributeVariable ].
	self
		typecheck: patchAttributeVariable
		with: RMDType any
		in: aRMDInterpreter.
	^ RMDType rad
]
