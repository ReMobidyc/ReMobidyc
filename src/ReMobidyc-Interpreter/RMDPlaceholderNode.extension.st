Extension { #name : #RMDPlaceholderNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDPlaceholderNode >> evalIn: aRMDInterpreter [

	^ RMDUnresolvedPlaceholderError signal: self
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDPlaceholderNode >> typecheckIn: aRMDInterpreter [

	^ RMDUnresolvedPlaceholderError signal: self
]
