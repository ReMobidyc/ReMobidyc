Extension { #name : #String }

{ #category : #'*ReMobidyc-Language' }
String >> asRMDActionDefinition [

	| node |
	node := RMDGrammar current actionDefinition end parse: self.
	^ node isPetit2Failure
		  ifTrue: [ RMDSyntaxError signal: node ]
		  ifFalse: [ node ]
]

{ #category : #'*ReMobidyc-Language' }
String >> asRMDAnimatDefinition [

	| node |
	node := RMDGrammar current animatDefinition end parse: self.
	^ node isPetit2Failure
		  ifTrue: [ RMDSyntaxError signal: node ]
		  ifFalse: [ node ]
]

{ #category : #'*ReMobidyc-Language' }
String >> asRMDExpression [

	^ self
		  asRMDExpressionDo: [ :node | node ]
		  ifError: [ :failure | RMDSyntaxError signal: failure ]
]

{ #category : #'*ReMobidyc-Language' }
String >> asRMDExpressionDo: aBlock [
	^ self asRMDExpressionDo: aBlock ifError: [  ]
]

{ #category : #'*ReMobidyc-Language' }
String >> asRMDExpressionDo: aBlock ifError: errorBlock [
	| node |
	node := RMDGrammar current expression end parse: self.
	^ (node isPetit2Failure
		ifTrue: [ errorBlock ]
		ifFalse: [ aBlock ]) cull: node
]

{ #category : #'*ReMobidyc-Language' }
String >> asRMDExpressionOrNil [

	^ self asRMDExpressionDo: [ :node | node ] ifError: [  ]
]

{ #category : #'*ReMobidyc-Language' }
String >> asRMDSimulationDefinition [

	| node |
	node := RMDGrammar current simulationDefinition end parse: self.
	^ node isPetit2Failure
		  ifTrue: [ RMDSyntaxError signal: node ]
		  ifFalse: [ node ]
]

{ #category : #'*ReMobidyc-Language' }
String >> asRMDTaskDefinition [

	| node |
	node := RMDGrammar current taskDefinition end parse: self.
	^ node isPetit2Failure
		  ifTrue: [ RMDSyntaxError signal: node ]
		  ifFalse: [ node ]
]

{ #category : #'*ReMobidyc-Language' }
String >> asRMDUnit [

	^ self ifEmpty: [ RMDUnit noDimension ] ifNotEmpty: [ 
		  | node |
		  node := RMDGrammar current unit end parse: self.
		  node isPetit2Failure
			  ifTrue: [ RMDSyntaxError signal: node ]
			  ifFalse: [ node ] ]
]

{ #category : #'*ReMobidyc-Language' }
String >> asRMDUnitOrNoDimension [

	| node |
	node := RMDGrammar current unit end parse: self.
	^ node isPetit2Failure
		  ifTrue: [ RMDUnit noDimension ]
		  ifFalse: [ node ]
]

{ #category : #'*ReMobidyc-Language' }
String >> asRMDWorldDefinition [

	| node |
	node := RMDGrammar current worldDefinition end parse: self trim.
	^ node isPetit2Failure
		  ifTrue: [ RMDSyntaxError signal: node ]
		  ifFalse: [ node ]
]
