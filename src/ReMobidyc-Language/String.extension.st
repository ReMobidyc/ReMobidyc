Extension { #name : #String }

{ #category : #'*ReMobidyc-Language' }
String >> asRMDAnimatDefinition [
	^ RMDGrammar new animatDefinition parse: self
]

{ #category : #'*ReMobidyc-Language' }
String >> asRMDExpression [
	^ RMDGrammar new expression parse: self
]

{ #category : #'*ReMobidyc-Language' }
String >> asRMDScript [
	^ RMDGrammar new script parse: self
]

{ #category : #'*ReMobidyc-Language' }
String >> asRMDUnit [
	^ RMDGrammar new unit parse: self
]
