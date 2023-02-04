Class {
	#name : #RMDVariabilityPresenter,
	#superclass : #RMDSyntaxNodePresenter,
	#instVars : [
		'seedOrMultiplicityDropList',
		'naturalNumberField',
		'metaParameterSequencePresenters'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #layouting }
RMDVariabilityPresenter >> defaultLayout [

	| newLayout |
	newLayout := SpBoxLayout newVertical
		             add: (SpBoxLayout newHorizontal
				              add: seedOrMultiplicityDropList width: 200;
				              add: naturalNumberField width: 200)
		             expand: false
		             fill: false
		             padding: 10;
		             add: 'meta-parameters' expand: false.
	metaParameterSequencePresenters do: [ :presenter | 
		newLayout
			add: (SpBoxLayout newHorizontal
					 add: '     ' expand: false;
					 add: presenter)
			expand: false
			fill: false
			padding: 4 ].
	^ newLayout
]

{ #category : #initialization }
RMDVariabilityPresenter >> initializePresenters [

	super initializePresenters.
	seedOrMultiplicityDropList := self newDropList
		                              disable;
		                              items: #( seed multiplicity );
		                              display: [ :symbol | 
			                              symbol = #seed
				                              ifTrue: [ 'reproduce random' ]
				                              ifFalse: [ 'multiple runs' ] ];
		                              whenSelectedItemChangedDo: [ 
			                              self seedOrMultiplicityChanged ];
		                              yourself.
	naturalNumberField := self newNumberInput
		                      disable;
		                      beInteger;
		                      number: 1;
		                      whenNumberChangedDo: [ 
			                      self naturalNumberChanged ];
		                      yourself.
	metaParameterSequencePresenters := #(  )
]

{ #category : #updating }
RMDVariabilityPresenter >> naturalNumberChanged [

	seedOrMultiplicityDropList selectedItem = #seed
		ifTrue: [ 
			node randomSeed:
				(naturalNumberField number ifNil: [ 1 ] ifNotNil: [ :n | 
					 n = 0
						 ifTrue: [ 1 ]
						 ifFalse: [ n abs \\ RMDFishmanMooreRandomGenerator modulo ] ]) ]
		ifFalse: [ node multiplicity: naturalNumberField number ]
]

{ #category : #updating }
RMDVariabilityPresenter >> nodeChanged [

	node
		ifNotNil: [ 
			simulationModel ifNotNil: #updateMetaParameters.
			seedOrMultiplicityDropList
				enable;
				selectItem: (node randomSeed isNil
						 ifTrue: [ #multiplicity ]
						 ifFalse: [ #seed ]).
			naturalNumberField
				enable;
				number: (node randomSeed ifNil: [ node multiplicity ]).
			metaParameterSequencePresenters := node metaParameterSequences 
				                                   collect: #asPresenter ]
		ifNil: [ 
			seedOrMultiplicityDropList disable.
			naturalNumberField
				number: 1;
				disable.
			metaParameterSequencePresenters := #(  ) ].
	self layout: self defaultLayout
]

{ #category : #accessing }
RMDVariabilityPresenter >> preferredHeight [

	^ metaParameterSequencePresenters
		  inject: 2
		  into: [ :sum :presenter | sum + presenter preferredHeight ]
]

{ #category : #updating }
RMDVariabilityPresenter >> seedOrMultiplicityChanged [

	naturalNumberField number:
		(seedOrMultiplicityDropList selectedItem = #seed
			 ifTrue: [ 
				 node multiplicity: 1.
				 node randomSeed ifNil: [ 1 ] ifNotNil: [ :n | 
					 n = 0
						 ifTrue: [ 1 ]
						 ifFalse: [ n abs \\ RMDFishmanMooreRandomGenerator modulo ] ] ]
			 ifFalse: [ 
				 node randomSeed: nil.
				 node multiplicity ])
]
