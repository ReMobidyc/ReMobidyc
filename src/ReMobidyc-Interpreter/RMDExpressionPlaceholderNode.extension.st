Extension { #name : #RMDExpressionPlaceholderNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDExpressionPlaceholderNode >> evalIn: aRMDInterpreter [

	^ (RMDUnresolvedReferenceError on: self) signal
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDExpressionPlaceholderNode >> typecheckIn: aRMDInterpreter [

	^ (RMDUnresolvedReferenceError on: self) signal
]
