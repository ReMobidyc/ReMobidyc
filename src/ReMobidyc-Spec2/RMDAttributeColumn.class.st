Class {
	#name : #RMDAttributeColumn,
	#superclass : #RMDTabularColumn,
	#instVars : [
		'attribute'
	],
	#category : #'ReMobidyc-Spec2-Tabulars'
}

{ #category : #'instance creation' }
RMDAttributeColumn class >> attribute: aRMDAttributeDeclarationNode [

	^ self new
		  attribute: aRMDAttributeDeclarationNode;
		  yourself
]

{ #category : #accessing }
RMDAttributeColumn >> attribute [

	^ attribute
]

{ #category : #accessing }
RMDAttributeColumn >> attribute: aRMDAttributeDeclarationNode [

	attribute := aRMDAttributeDeclarationNode.
	title := attribute identifier , ' [' , attribute unit printString
	         , ']'
]

{ #category : #enumerating }
RMDAttributeColumn >> ifOnChartDo: aBlock [
	^ aBlock cull: self
]

{ #category : #accessing }
RMDAttributeColumn >> value: aRow [

	^ aRow
		  at: attribute identifier
		  ifPresent: [ :value | attribute unit fromSI: value ]
		  ifAbsent: [ '' ]
]
