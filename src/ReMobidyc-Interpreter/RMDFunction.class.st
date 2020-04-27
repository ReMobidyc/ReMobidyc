Class {
	#name : #RMDFunction,
	#superclass : #Object,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'typical instances' }
RMDFunction class >> abs [
	^ self block: [ :x | x abs ]
]

{ #category : #'typical instances' }
RMDFunction class >> block: aBlock [
	^ RMDBlockFunction block: aBlock
]

{ #category : #'typical instances' }
RMDFunction class >> cos [
	^ self block: [ :theta | theta cos ]
]

{ #category : #'typical instances' }
RMDFunction class >> exp [
	^ self block: [ :base :order | base ** order ]
]

{ #category : #'typical instances' }
RMDFunction class >> ln [
	^ self block: [ :x | x ln ]
]

{ #category : #'typical instances' }
RMDFunction class >> log [
	^ self block: [ :base :x | x ln / base ln ]
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
	^ self block: [ :theta | theta sin ]
]

{ #category : #'typical instances' }
RMDFunction class >> squareRoot [
	^ self block: [ :x | x sqrt ]
]

{ #category : #'typical instances' }
RMDFunction class >> sum [
	^ RMDSumFunction new
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
