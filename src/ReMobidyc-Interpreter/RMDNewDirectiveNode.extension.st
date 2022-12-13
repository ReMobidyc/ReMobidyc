Extension { #name : #RMDNewDirectiveNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDNewDirectiveNode >> evalIn: aRMDInterpreter [

	animatIdentifier ifNil: [ 
		^ (RMDUnresolvedReferenceError on: self) signal ].

	aRMDInterpreter newIndividual: animatIdentifier quantity: (quantity
			 ifNil: [ 1 ]
			 ifNotNil: [ (quantity evalIn: aRMDInterpreter) floor ])
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDNewDirectiveNode >> typecheckIn: aRMDInterpreter [

	animatIdentifier ifNil: [ 
		^ (RMDUnresolvedReferenceError on: self) signal ].
	quantity ifNotNil: [ 
		[ 
		(quantity typecheckIn: aRMDInterpreter) unify:
			RMDUnitType noDimension ]
			on: RMDTypeUnificationError
			do: [ :ex | ex resignalAs: (RMDTypeError on: self with: ex type1) ] ].
	aRMDInterpreter newIndividual: animatIdentifier
]
