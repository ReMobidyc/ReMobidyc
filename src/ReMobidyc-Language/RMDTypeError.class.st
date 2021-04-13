Class {
	#name : #RMDTypeError,
	#superclass : #Exception,
	#instVars : [
		'ast',
		'unit'
	],
	#category : #'ReMobidyc-Language-Type'
}

{ #category : #'instance creation' }
RMDTypeError class >> on: aRMDSyntaxNode with: aRMDUnit [
	^ self new
		ast: aRMDSyntaxNode;
		unit: aRMDUnit;
		messageText: aRMDSyntaxNode printString , ' [' , aRMDUnit printString , ']';
		yourself
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
RMDTypeError >> defaultAction [
	^ UnhandledError signalForException: self
]

{ #category : #accessing }
RMDTypeError >> unit [
	^ unit
]

{ #category : #accessing }
RMDTypeError >> unit: aRMDUnit [
	unit := aRMDUnit
]
