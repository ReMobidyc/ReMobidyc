Extension { #name : #RMDVariablePlaceholderNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDVariablePlaceholderNode >> evalIn: aRMDInterpreter [

	^ (RMDUnresolvedReferenceError on: self) signal
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDVariablePlaceholderNode >> typecheckIn: aRMDInterpreter [

	^ (RMDUnresolvedReferenceError on: self) signal
]
