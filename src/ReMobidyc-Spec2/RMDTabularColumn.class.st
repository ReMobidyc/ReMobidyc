Class {
	#name : #RMDTabularColumn,
	#superclass : #SpStringTableColumn,
	#category : #'ReMobidyc-Spec2-Tabulars'
}

{ #category : #testing }
RMDTabularColumn class >> isAbstract [

	^ self == RMDTabularColumn
]

{ #category : #initialization }
RMDTabularColumn >> defaultEvaluation [

	^ [ :row | self value: row ]
]

{ #category : #controlling }
RMDTabularColumn >> ifOnChartDo: aBlock [

	^ self subclassResponsibility
]

{ #category : #initialization }
RMDTabularColumn >> initialize [

	super initialize.
	evaluation := self defaultEvaluation
]

{ #category : #printing }
RMDTabularColumn >> printNat: anInteger [

	^ anInteger
		  ifNotNil: [ 
			  anInteger > 0
				  ifTrue: [ 
					  | nat str |
					  nat := anInteger.
					  str := ',' join: (Array streamContents: [ :stream | 
							          [ nat > 0 ] whileTrue: [ 
								          | n |
								          n := nat % 1000.
								          stream nextPut: (n < 100
										           ifTrue: [ 
											           n < 10
												           ifTrue: [ '00' , n printString ]
												           ifFalse: [ '0' , n printString ] ]
										           ifFalse: [ n printString ]).
								          nat := nat // 1000 ] ]) reversed.
					  [ str first = $0 ] whileTrue: [ str := str allButFirst ].
					  str ]
				  ifFalse: [ '0' ] ]
		  ifNil: [ '' ]
]

{ #category : #accessing }
RMDTabularColumn >> value: aRow [

	^ self subclassResponsibility
]
