Class {
	#name : #RMDUnresolvedAttributeDefinitionError,
	#superclass : #RMDUnresolvedReferenceError,
	#instVars : [
		'identifier'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'instance creation' }
RMDUnresolvedAttributeDefinitionError class >> on: aRMDSyntaxNode identifier: aString [

	^ self new
		  node: aRMDSyntaxNode;
		  identifier: aString;
		  yourself
]

{ #category : #'instance creation' }
RMDUnresolvedAttributeDefinitionError class >> signal: aRMDSyntaxNode identifier: aString [

	^ (self on: aRMDSyntaxNode identifier: aString) signal
]

{ #category : #private }
RMDUnresolvedAttributeDefinitionError >> composeMessageText [

	^ 'Unresolved attribute: ' , identifier
]

{ #category : #accessing }
RMDUnresolvedAttributeDefinitionError >> identifier [

	^ identifier
]

{ #category : #accessing }
RMDUnresolvedAttributeDefinitionError >> identifier: aString [

	identifier := aString
]
