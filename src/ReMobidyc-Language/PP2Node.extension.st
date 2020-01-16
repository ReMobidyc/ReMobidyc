Extension { #name : #PP2Node }

{ #category : #'*ReMobidyc-Language' }
PP2Node >> onlySeparatedBy: aParser [
	^ (self separatedBy: aParser)
		==> [ :array | (1 to: array size by: 2) collect: [ :i | array at: i ] ]
]
