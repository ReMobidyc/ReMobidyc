Extension { #name : #Number }

{ #category : #'*ReMobidyc-Interpreter' }
Number >> =~= aNumber [

	^ self = aNumber or: [
		  (self - aNumber) abs < (self abs + aNumber abs * 1.0e-10) ]
]

{ #category : #'*ReMobidyc-Interpreter' }
Number >> ifNanOrInfinite: aBlock [

	
]
