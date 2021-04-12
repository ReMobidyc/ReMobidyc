Extension { #name : #RMDBinaryRelationNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDBinaryRelationNode >> typecheckIn: aRMDInterpreter [
	| type |
	type := nil.
	expressions
		do: [ :expression | 
			| t |
			t := expression typecheckIn: aRMDInterpreter.
			t
				ifNil: [ ^ (RMDTypeError on: self with: t) signal ]
				ifNotNil: [ type
						ifNil: [ type := t ]
						ifNotNil: [ type = t
								ifFalse: [ ^ (RMDTypeError on: self with: t) signal ] ] ] ].
	^ type
]
