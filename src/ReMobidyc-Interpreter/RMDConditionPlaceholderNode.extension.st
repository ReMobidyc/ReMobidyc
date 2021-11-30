Extension { #name : #RMDConditionPlaceholderNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDConditionPlaceholderNode >> evalIn: aRMDInterpreter [

	^ (RMDUnresolvedReferenceError on: self) signal
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDConditionPlaceholderNode >> typecheckIn: aRMDInterpreter [

	^ (RMDUnresolvedReferenceError on: self) signal
]
