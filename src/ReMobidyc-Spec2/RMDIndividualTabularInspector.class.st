Class {
	#name : #RMDIndividualTabularInspector,
	#superclass : #RMDTabularInspector,
	#traits : 'TRMDIndividualObservatory',
	#classTraits : 'TRMDIndividualObservatory classTrait',
	#instVars : [
		'agent',
		'currentAgent',
		'currentAnimat'
	],
	#category : #'ReMobidyc-Spec2-Inspectors'
}

{ #category : #accessing }
RMDIndividualTabularInspector >> agent [

	^ agent
]

{ #category : #accessing }
RMDIndividualTabularInspector >> agent: anInteger [

	agent := anInteger.
	self updateCurrentAgentAndAnimat
]

{ #category : #private }
RMDIndividualTabularInspector >> createItem [

	| item |
	currentAgent ifNil: [ ^ nil ].
	item := Dictionary new.
	item at: nil put: interpreter memory time.
	item at: 'Stage' put: currentAnimat.
	item at: 'ID' put: currentAgent.
	(interpreter simulationModel
		 animatDefinitionAt: currentAnimat
		 ifAbsent: [ nil ]) ifNotNil: [ :animatDef | 
		interpreter
			withObserverContextWithSubject: currentAgent
			definition: animatDef
			do: [ 
				animatDef allAttributeDeclarations do: [ :attDecl | 
					(interpreter my: attDecl identifier) ifNotNil: [ :val | 
						item
							at: attDecl printString
							put: ((attDecl unit fromSI: val) printShowingDecimalPlaces: 2) ] ] ] ].
	^ item
]

{ #category : #private }
RMDIndividualTabularInspector >> createTable [

	^ super createTable
		  addColumn: (SpStringTableColumn
				   title: 'T'
				   evaluated: [ :item | item at: nil ifAbsent: [ '' ] ]);
		  addColumn: (SpStringTableColumn
				   title: 'Stage'
				   evaluated: [ :item | item at: 'Stage' ifAbsent: [ '' ] ]);
		  addColumn: (SpStringTableColumn
				   title: 'ID'
				   evaluated: [ :item | item at: 'ID' ifAbsent: [ '' ] ]);
		  items: (SortedCollection sortBlock: [ :less :more | 
					   (less at: nil) <= (more at: nil) ]);
		  yourself
]

{ #category : #accessing }
RMDIndividualTabularInspector >> currentAnimat [
	^ currentAnimat
]

{ #category : #accessing }
RMDIndividualTabularInspector >> interpreter: aRMDInterpreter [

	super interpreter: aRMDInterpreter.
	self updateCurrentAgentAndAnimat
]

{ #category : #private }
RMDIndividualTabularInspector >> updateCurrentAgentAndAnimat [

	currentAgent ifNil: [ currentAgent := agent ].
	currentAnimat ifNil: [ 
		interpreter ifNotNil: [ 
			currentAnimat := interpreter memory
				                 animatOfIndividual: currentAgent
				                 ifAbsent: [ nil ].
			self updateTableColumns ] ].
	currentAgent ifNotNil: [ 
		interpreter ifNotNil: [ 
			(interpreter memory
				 animatOfIndividual: currentAgent
				 ifAbsent: [ nil ]) ifNil: [ 
				interpreter memory
					findCurrentOf: agent
					ifPresent: [ :individual :animat | 
						currentAgent := individual.
						currentAnimat := animat.
						self updateTableColumns ]
					ifAbsent: [ 
						currentAgent := nil.
						currentAnimat := nil ] ] ] ]
]

{ #category : #private }
RMDIndividualTabularInspector >> updateObservation [

	self updateCurrentAgentAndAnimat.
	super updateObservation.
	self updateTitle
]

{ #category : #private }
RMDIndividualTabularInspector >> updateTable [

	table ifNil: [ ^ self ].
	interpreter ifNil: [ ^ self ].
	(table items contains: [ :item | 
		 (item at: nil ifAbsent: [ nil ]) = interpreter memory time ]) 
		ifTrue: [ ^ self ].
	self createItem ifNotNil: [ :item | table items add: item ].
	table items: table items
]

{ #category : #private }
RMDIndividualTabularInspector >> updateTableColumns [

	interpreter ifNotNil: [ 
		table ifNotNil: [ 
			currentAnimat ifNotNil: [ 
				(interpreter simulationModel
					 animatDefinitionAt: currentAnimat
					 ifAbsent: [ nil ]) ifNotNil: [ :animatDef | 
					animatDef allAttributeDeclarations do: [ :attDecl | 
						| declString |
						declString := attDecl printString.
						(table columns contains: [ :column | column title = declString ]) 
							ifFalse: [ 
								table addColumn:
									(SpStringTableColumn title: declString evaluated: [ :item | 
										 (item at: declString ifAbsent: [ nil ])
											 ifNil: [ '' ]
											 ifNotNil: [ :val | 
												 val isNumber
													 ifTrue: [ val printShowingDecimalPlaces: 2 ]
													 ifFalse: [ val asString ] ] ]) ] ] ] ] ] ]
]

{ #category : #private }
RMDIndividualTabularInspector >> updateTitle [

	self withWindowDo: [ :window | 
		window title: 'Individual #' , agent printString
			, (currentAnimat ifNil: [ '' ] ifNotNil: [ 
					 ' (now ' , currentAnimat asString , ' #'
					 , currentAgent printString , ')' ]) ]
]
