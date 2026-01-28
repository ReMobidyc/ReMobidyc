Extension { #name : 'TestCase' }

{ #category : '*ReMobidyc-Language-Tests' }
TestCase >> assert: anObject with: aBlock [

	aBlock value: anObject
]
