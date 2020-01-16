Extension { #name : #RMDScriptNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDScriptNode >> evalIn: aRMDInterpreter [
	(guard evalIn: aRMDInterpreter)
		ifTrue: [ propertyDefinitions do: [ :def | def evalIn: aRMDInterpreter ] ]
]
