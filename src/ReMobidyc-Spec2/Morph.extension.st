Extension { #name : 'Morph' }

{ #category : '*ReMobidyc-Spec2' }
Morph >> currentWorld [

	^ self world ifNil: [ super currentWorld ]
]
