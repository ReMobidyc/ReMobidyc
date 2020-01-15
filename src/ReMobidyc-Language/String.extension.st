Extension { #name : #String }

{ #category : #'*ReMobidyc-Language' }
String >> asRMDUnit [
	^ RMDGrammar new unit parse: self
]
