Extension { #name : #RMDAttributeVariableNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAttributeVariableNode >> addressIn: aRMDInterpreter [

	^ (self agentAddressIn: aRMDInterpreter)
	  + (self offsetIn: aRMDInterpreter)
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAttributeVariableNode >> agentAddressIn: aRMDInterpreter [

	^ self subclassResponsibility
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAttributeVariableNode >> agentDefinitionIn: aRMDInterpreter [

	^ self subclassResponsibility
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAttributeVariableNode >> evalIn: aRMDInterpreter [

	| address |
	address := self addressIn: aRMDInterpreter.
	^ aRMDInterpreter
		  read: address
		  ifAbsent: [ RMDAddressError signal: self address: address ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAttributeVariableNode >> offsetIn: aRMDInterpreter [

	^ offset ifNil: [ 
		  offset := (self agentDefinitionIn: aRMDInterpreter)
			            offsetAt: identifier
			            ifAbsent: [ ^ RMDUndefinedAttributeError signal: self ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAttributeVariableNode >> typecheckIn: aRMDInterpreter [

	^ type := aRMDInterpreter
		          typeOfVariable: identifier
		          agent: self agent
		          ifAbsent: [ RMDUndefinedAttributeError signal: self ]
]
