Extension { #name : #RMDDirectionOfGradientDirectiveNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDDirectionOfGradientDirectiveNode >> evalIn: aRMDInterpreter [

	| attribute here west east south north vector |
	patchAttributeVariable isPlaceholderNode ifTrue: [ 
		^ RMDUnresolvedPlaceholderError signal: patchAttributeVariable ].
	attribute := patchAttributeVariable identifier.
	here := aRMDInterpreter
		        readVariable: attribute
		        agent: 'here'
		        ifAbsent: [ 0 ].
	east := aRMDInterpreter
		        readVariable: attribute
		        agent: 'east'
		        ifAbsent: [ here ].
	west := aRMDInterpreter
		        readVariable: attribute
		        agent: 'west'
		        ifAbsent: [ here ].
	south := aRMDInterpreter
		         readVariable: attribute
		         agent: 'south'
		         ifAbsent: [ here ].
	north := aRMDInterpreter
		         readVariable: attribute
		         agent: 'north'
		         ifAbsent: [ here ].
	vector := east - west @ (north - south).
	(east <= here and: [ 
		 west <= here and: [ south <= here and: [ north <= here ] ] ]) 
		ifTrue: [ 
			| x y patchX patchY |
			x := aRMDInterpreter readVariable: 'x' agent: nil ifAbsent: [ 0.0 ].
			y := aRMDInterpreter readVariable: 'y' agent: nil ifAbsent: [ 0.0 ].
			patchX := aRMDInterpreter patchLength
			          * ((aRMDInterpreter patchX: x) floor + 0.5).
			patchY := aRMDInterpreter patchLength
			          * ((aRMDInterpreter patchY: y) floor + 0.5).
			vector := patchX - x @ (patchY - y) ].
	^ vector theta
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
