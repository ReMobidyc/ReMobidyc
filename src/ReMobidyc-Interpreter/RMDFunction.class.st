Class {
	#name : #RMDFunction,
	#superclass : #Object,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'typical instances' }
RMDFunction class >> abs [
	^ RMDAbsFunction new
]

{ #category : #'instance creation' }
RMDFunction class >> at: aString [
	aString = 'abs'
		ifTrue: [ ^ self abs ].
	aString = 'cos'
		ifTrue: [ ^ self cos ].
	aString = 'max'
		ifTrue: [ ^ self max ].
	aString = 'mean'
		ifTrue: [ ^ self mean ].
	aString = 'min'
		ifTrue: [ ^ self min ].
	aString = 'sin'
		ifTrue: [ ^ self sin ].
	aString = 'sum'
		ifTrue: [ ^ self sum ]
]

{ #category : #'typical instances' }
RMDFunction class >> cos [
	^ RMDCosFunction new
]

{ #category : #'typical instances' }
RMDFunction class >> max [
	^ RMDMaxFunction new
]

{ #category : #'typical instances' }
RMDFunction class >> mean [
	^ RMDMeanFunction new
]

{ #category : #'typical instances' }
RMDFunction class >> min [
	^ RMDMinFunction new
]

{ #category : #'typical instances' }
RMDFunction class >> sin [
	^ RMDSinFunction new
]

{ #category : #'typical instances' }
RMDFunction class >> sum [
	^ RMDSumFunction new
]

{ #category : #'type checking' }
RMDFunction >> inferTypeWithArguments: anArrayOfRMDExpression [
	^ self subclassResponsibility
]

{ #category : #private }
RMDFunction >> numArgsError [
	^ RMDNumArgsError signal
]

{ #category : #accessing }
RMDFunction >> value: aNumber [
	^ self numArgsError
]

{ #category : #accessing }
RMDFunction >> value: aNumber1 value: aNumber2 [
	^ self numArgsError
]

{ #category : #accessing }
RMDFunction >> value: aNumber1 value: aNumber2 value: aNumber3 [
	^ self numArgsError
]

{ #category : #accessing }
RMDFunction >> value: aNumber1 value: aNumber2 value: aNumber3 value: aNumber4 [
	^ self numArgsError
]
