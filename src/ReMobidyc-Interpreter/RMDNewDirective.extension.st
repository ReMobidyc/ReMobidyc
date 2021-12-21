Extension { #name : #RMDNewDirective }

{ #category : #'*ReMobidyc-Interpreter' }
RMDNewDirective >> evalIn: aRMDInterpreter [

	aRMDInterpreter newIndividual: animatIdentifier
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDNewDirective >> typecheckIn: aRMDInterpreter [

	animatIdentifier ifNil: [ 
		^ (RMDUnresolvedReferenceError on: self) signal ].
	aRMDInterpreter newIndividual: animatIdentifier
]
