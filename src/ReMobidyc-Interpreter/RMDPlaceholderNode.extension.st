Extension { #name : #RMDPlaceholderNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDPlaceholderNode >> evalIn: aRMDInterpreter [

	^ (RMDUnresolvedReferenceError on: self) signal
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDPlaceholderNode >> typecheckIn: aRMDInterpreter [

	^ (RMDUnresolvedReferenceError on: self) signal
]
