Extension { #name : #RMDTraceNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDTraceNode >> evalIn: aRMDInterpreter [

	^ value := node evalIn: aRMDInterpreter
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDTraceNode >> typecheckIn: aRMDInterpreter [

	^ type := node typecheckIn: aRMDInterpreter
]
