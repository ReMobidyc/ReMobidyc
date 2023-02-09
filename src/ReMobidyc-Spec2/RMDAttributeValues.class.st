Class {
	#name : #RMDAttributeValues,
	#superclass : #Object,
	#instVars : [
		'ids',
		'values',
		'stats',
		'attributeDeclarations'
	],
	#category : #'ReMobidyc-Spec2-Utilities'
}

{ #category : #'instance creation' }
RMDAttributeValues class >> fromInterpreter: aRMDInterpreter animat: aRMDAgentDefinitionNode [

	| attributeDeclarations attributeValues ids individualIndex attributeStats |
	attributeDeclarations := aRMDAgentDefinitionNode
		                         allAttributeDeclarations.
	ids := Array new:
		       (aRMDInterpreter numberOfIndividualsOf:
			        aRMDAgentDefinitionNode).
	attributeValues := (1 to: attributeDeclarations size) collect: [ :i | 
		                   Array new: ids size ].
	individualIndex := 1.
	aRMDInterpreter individualsOf: aRMDAgentDefinitionNode do: [ :id | 
		ids at: individualIndex put: id.
		aRMDInterpreter
			withObserverContextWithSubject: id
			definition: aRMDAgentDefinitionNode
			do: [ 
				aRMDAgentDefinitionNode allAttributeDeclarations doWithIndex: [ 
					:attributeDef 
					:attributeIndex | 
					(attributeValues at: attributeIndex)
						at: individualIndex
						put: (attributeDef unit fromSI:
								 (aRMDInterpreter my: attributeDef identifier)) ] ].
		individualIndex := individualIndex + 1 ].
	attributeStats := attributeValues collect: [ :values | 
		                  | stats |
		                  stats := Dictionary new.
		                  values ifNotEmpty: [ 
			                  | total size mean |
			                  total := values sum.
			                  size := values size.
			                  stats at: #total put: total.
			                  stats at: #min put: values min.

			                  stats at: #max put: values max.
			                  stats
				                  at: #mean
				                  put: (mean := total asFloat / size asFloat).
			                  stats at: #sd put: (values
					                   inject: 0.0
					                   into: [ :sd :value | 
					                   (value - mean) squared / size + sd ]) sqrt.
			                  (values reject: #isZero) ifNotEmpty: [ :nonZeros | 
				                  stats
					                  at: #'min*' put: nonZeros min;
					                  at: #'max*' put: nonZeros max;
					                  at: #'mean*' put: total / nonZeros size ] ].
		                  stats ].
	^ self new
		  setAttributeDeclarations: attributeDeclarations
		  ids: ids
		  values: attributeValues
		  stats: attributeStats;
		  yourself
]

{ #category : #accessing }
RMDAttributeValues >> attribute: anIntegerOrRMDPropertyDeclaration at: anIntegerOrSymbol ifAbsent: errorBlock [
	^ anIntegerOrRMDPropertyDeclaration = #id
		ifTrue: [ ids at: anIntegerOrSymbol ]
		ifFalse: [ ((anIntegerOrSymbol isInteger
				ifTrue: [ values ]
				ifFalse: [ stats ])
				at:
					(anIntegerOrRMDPropertyDeclaration isInteger
						ifTrue: [ anIntegerOrRMDPropertyDeclaration ]
						ifFalse: [ attributeDeclarations
								indexOf: anIntegerOrRMDPropertyDeclaration
								ifAbsent: [ ^ errorBlock value ] ])
				ifAbsent: [ ^ errorBlock value ])
				at: anIntegerOrSymbol
				ifAbsent: errorBlock ]
]

{ #category : #enumerating }
RMDAttributeValues >> attributesDo: aBlock [
	1 to: attributeDeclarations size do: [ :index | 
		aBlock
			value: (attributeDeclarations at: index)
			value: (values at: index)
			value: (stats at: index) ]
]

{ #category : #accessing }
RMDAttributeValues >> ids [
	^ ids
]

{ #category : #enumerating }
RMDAttributeValues >> idsWithIndexDo: aBlock [
	ids withIndexDo: aBlock
]

{ #category : #accessing }
RMDAttributeValues >> numberOfAttributes [
	^ attributeDeclarations size
]

{ #category : #accessing }
RMDAttributeValues >> numberOfValues [
	^ values first size
]

{ #category : #private }
RMDAttributeValues >> setAttributeDeclarations: anArrayOfRMDAttributeDefinition ids: anArrayOfInteger values: anArrayOfArrayOfFloat stats: anArrayOfDictionary [
	attributeDeclarations := anArrayOfRMDAttributeDefinition.
	ids := anArrayOfInteger.
	values := anArrayOfArrayOfFloat.
	stats := anArrayOfDictionary
]

{ #category : #accessing }
RMDAttributeValues >> valuesAt: anIntegerOrRMDAttributeDeclaration ifAbsent: errorBlock [
	^ values
		at:
			(anIntegerOrRMDAttributeDeclaration isInteger
				ifTrue: [ anIntegerOrRMDAttributeDeclaration ]
				ifFalse: [ attributeDeclarations
						indexOf: anIntegerOrRMDAttributeDeclaration
						ifAbsent: [ ^ errorBlock value ] ])
		ifAbsent: errorBlock
]
