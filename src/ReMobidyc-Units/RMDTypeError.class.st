Class {
	#name : #RMDTypeError,
	#superclass : #Error,
	#instVars : [
		'ast',
		'unit'
	],
	#category : #'ReMobidyc-Units'
}

{ #category : #'instance creation' }
RMDTypeError class >> on: aRMDSyntaxNode with: aRMDUnit [
	^ self new
		ast: aRMDSyntaxNode;
		unit: aRMDUnit;
		messageText:
			'Conflicting units ' , aRMDSyntaxNode type printString , ' and '
				, aRMDUnit printString , ' at '
				, aRMDSyntaxNode printString yourself
]

{ #category : #accessing }
RMDTypeError >> ast [
	^ ast
]

{ #category : #accessing }
RMDTypeError >> ast: aRMDSyntaxNode [
	ast := aRMDSyntaxNode
]

{ #category : #accessing }
RMDTypeError >> unit [
	^ unit
]

{ #category : #accessing }
RMDTypeError >> unit: aRMDUnit [
	unit := aRMDUnit
]
