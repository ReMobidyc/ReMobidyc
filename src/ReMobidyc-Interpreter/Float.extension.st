Extension { #name : #Float }

{ #category : #'*ReMobidyc-Interpreter' }
Float >> ifNanOrInfinite: aBlock [

	self isFinite ifFalse: [ ^ aBlock cull: self ].
	self isNaN ifTrue: [ ^ aBlock cull: self ]
]
