Extension { #name : #RMDScriptNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDScriptNode >> evalIn: aRMDInterpreter [
	propertyDefinitions do: [ :def | def evalIn: aRMDInterpreter ]
]
