Extension { #name : #String }

{ #category : #'*ReMobidyc-Language' }
String >> asRMDActionDefinition [
	| node |
	node := RMDGrammar new actionDefinition end parse: self.
	^ node isPetit2Failure
		ifTrue: [ RMDParseError signalPP2Failure: node ]
		ifFalse: [ node ]
]

{ #category : #'*ReMobidyc-Language' }
String >> asRMDAnimatDefinition [
	| node |
	node := RMDGrammar new animatDefinition end parse: self.
	^ node isPetit2Failure
		ifTrue: [ RMDParseError signalPP2Failure: node ]
		ifFalse: [ node ]
]

{ #category : #'*ReMobidyc-Language' }
String >> asRMDExpression [
	^ self
		asRMDExpressionDo: [ :node | node ]
		ifError: [ :failure | RMDParseError signalPP2Failure: failure ]
]

{ #category : #'*ReMobidyc-Language' }
String >> asRMDExpressionDo: aBlock [
	^ self asRMDExpressionDo: aBlock ifError: [  ]
]

{ #category : #'*ReMobidyc-Language' }
String >> asRMDExpressionDo: aBlock ifError: errorBlock [
	| node |
	node := RMDGrammar new expression end parse: self.
	^ (node isPetit2Failure
		ifTrue: [ errorBlock ]
		ifFalse: [ aBlock ]) cull: node
]

{ #category : #'*ReMobidyc-Language' }
String >> asRMDSimulationDefinition [
	| node |
	node := RMDGrammar new simulationDefinition end parse: self.
	^ node isPetit2Failure
		ifTrue: [ RMDParseError signalPP2Failure: node ]
		ifFalse: [ node ]
]

{ #category : #'*ReMobidyc-Language' }
String >> asRMDTaskDefinition [
	| node |
	node := RMDGrammar new taskDefinition end parse: self.
	^ node isPetit2Failure
		ifTrue: [ RMDParseError signalPP2Failure: node ]
		ifFalse: [ node ]
]

{ #category : #'*ReMobidyc-Language' }
String >> asRMDUnit [
	^ self
		ifEmpty: [ RMDUnit noDimension ]
		ifNotEmpty: [ | node |
			node := RMDGrammar new unit end parse: self.
			node isPetit2Failure
				ifTrue: [ RMDParseError signalPP2Failure: node ]
				ifFalse: [ node ] ]
]
