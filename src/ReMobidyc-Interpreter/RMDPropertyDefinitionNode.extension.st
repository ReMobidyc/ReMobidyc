Extension { #name : #RMDPropertyDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDPropertyDefinitionNode >> evalIn: aRMDInterpreter [
	^ variable
		assign: (definitionBody evalIn: aRMDInterpreter)
		in: aRMDInterpreter
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDPropertyDefinitionNode >> typecheckIn: aRMDInterpreter [
	| variableType bodyType |
	variableType := variable typecheckIn: aRMDInterpreter.
	bodyType := definitionBody typecheckIn: aRMDInterpreter.
	variableType = bodyType
		ifFalse: [ ^ RMDTypeError on: self with: bodyType ]
]
