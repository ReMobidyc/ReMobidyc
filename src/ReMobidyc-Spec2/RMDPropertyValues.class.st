Class {
	#name : #RMDPropertyValues,
	#superclass : #Object,
	#instVars : [
		'propertyDeclarations',
		'ids',
		'values',
		'stats'
	],
	#category : #'ReMobidyc-Spec2-Utilities'
}

{ #category : #'instance creation' }
RMDPropertyValues class >> fromInterpreter: aRMDInterpreter animat: aRMDSpeciesDefinitionNode [
	| propertyDeclarations propertyValues ids individualIndex propertyStats |
	propertyDeclarations := aRMDSpeciesDefinitionNode
		allPropertyDeclarations.
	ids := Array
		new: (aRMDInterpreter numberOfIndivisualsOf: aRMDSpeciesDefinitionNode).
	propertyValues := (1 to: propertyDeclarations size)
		collect: [ :i | Array new: ids size ].
	individualIndex := 1.
	aRMDInterpreter
		individualsOf: aRMDSpeciesDefinitionNode
		do: [ :id | 
			ids at: individualIndex put: id.
			aRMDInterpreter
				withObserverContextWithSubject: id
				species: aRMDSpeciesDefinitionNode
				do: [ aRMDSpeciesDefinitionNode allPropertyDeclarations
						doWithIndex: [ :propertyDef :propertyIndex | 
							(propertyValues at: propertyIndex)
								at: individualIndex
								put:
									(propertyDef unit
										fromSI:
											(aRMDInterpreter
												readVariable: propertyDef identifier
												agent: nil
												ifAbsent: [ nil ])) ] ].
			individualIndex := individualIndex + 1 ].
	propertyStats := propertyValues
		collect: [ :values | 
			| stats |
			stats := Dictionary new.
			values
				ifNotEmpty: [ | size mean |
					stats at: #min put: values min.
					stats at: #max put: values max.
					stats at: #mean put: (mean := values average).
					size := values size.
					stats
						at: #sd
						put:
							(values
								inject: 0.0
								into: [ :sd :value | (value - mean) squared / size + sd ])
								sqrt ].
			stats ].
	^ self new
		setPropertyDeclarations: propertyDeclarations
			ids: ids
			values: propertyValues
			stats: propertyStats;
		yourself
]

{ #category : #accessing }
RMDPropertyValues >> ids [
	^ ids
]

{ #category : #enumerating }
RMDPropertyValues >> idsWithIndexDo: aBlock [
	ids withIndexDo: aBlock
]

{ #category : #accessing }
RMDPropertyValues >> numberOfProperties [
	^ propertyDeclarations size
]

{ #category : #accessing }
RMDPropertyValues >> numberOfValues [
	^ values first size
]

{ #category : #enumerating }
RMDPropertyValues >> propertiesDo: aBlock [
	1 to: propertyDeclarations size do: [ :index | 
		aBlock
			value: (propertyDeclarations at: index)
			value: (values at: index)
			value: (stats at: index) ]
]

{ #category : #accessing }
RMDPropertyValues >> property: anIntegerOrRMDPropertyDeclaration at: anIntegerOrSymbol ifAbsent: errorBlock [
	^ anIntegerOrRMDPropertyDeclaration = #id
		ifTrue: [ ids at: anIntegerOrSymbol ]
		ifFalse: [ ((anIntegerOrSymbol isInteger
				ifTrue: [ values ]
				ifFalse: [ stats ])
				at:
					(anIntegerOrRMDPropertyDeclaration isInteger
						ifTrue: [ anIntegerOrRMDPropertyDeclaration ]
						ifFalse: [ propertyDeclarations
								indexOf: anIntegerOrRMDPropertyDeclaration
								ifAbsent: [ ^ errorBlock value ] ])
				ifAbsent: [ ^ errorBlock value ])
				at: anIntegerOrSymbol
				ifAbsent: errorBlock ]
]

{ #category : #private }
RMDPropertyValues >> setPropertyDeclarations: anArrayOfRMDPropertyDefinition ids: anArrayOfInteger values: anArrayOfArrayOfFloat stats: anArrayOfDictionary [
	propertyDeclarations := anArrayOfRMDPropertyDefinition.
	ids := anArrayOfInteger.
	values := anArrayOfArrayOfFloat.
	stats := anArrayOfDictionary
]

{ #category : #accessing }
RMDPropertyValues >> valuesAt: anIntegerOrRMDPropertyDeclaration ifAbsent: errorBlock [
	^ values
		at:
			(anIntegerOrRMDPropertyDeclaration isInteger
				ifTrue: [ anIntegerOrRMDPropertyDeclaration ]
				ifFalse: [ propertyDeclarations
						indexOf: anIntegerOrRMDPropertyDeclaration
						ifAbsent: [ ^ errorBlock value ] ])
		ifAbsent: errorBlock
]
