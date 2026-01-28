Extension { #name : 'PP2Node' }

{ #category : '*ReMobidyc-Language' }
PP2Node >> onlySeparatedBy: aParser [
	^ (self separatedBy: aParser)
		==> [ :array | (1 to: array size by: 2) collect: [ :i | array at: i ] ]
]

{ #category : '*ReMobidyc-Language' }
PP2Node >> onlyStrictlySeparatedBy: aParser [

	^ (self separatedBy: aParser) ==> [ :array |
		  array size > 1
			  ifTrue: [ (1 to: array size by: 2) collect: [ :i | array at: i ] ]
			  ifFalse: [
					  PP2Failure message:
						  'More than two members should be separated by tokens' ] ]
]
