Class {
	#name : #RMDIndividualsInPatchDirectiveNode,
	#superclass : #RMDPatchDirectiveNode,
	#instVars : [
		'animatName'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDIndividualsInPatchDirectiveNode class >> animatName: aString [

	^ self new
		  animatName: aString;
		  yourself
]

{ #category : #comparing }
RMDIndividualsInPatchDirectiveNode >> = anObject [

	^ self class = anObject class and: [ 
		  animatName = anObject animatName ]
]

{ #category : #accessing }
RMDIndividualsInPatchDirectiveNode >> animatName [

	^ animatName
]

{ #category : #accessing }
RMDIndividualsInPatchDirectiveNode >> animatName: aString [

	animatName := aString
]

{ #category : #enumerating }
RMDIndividualsInPatchDirectiveNode >> childrenDo: aBlock [

	
]

{ #category : #comparing }
RMDIndividualsInPatchDirectiveNode >> hash [

	^ self class hash bitXor: animatName hash
]

{ #category : #copying }
RMDIndividualsInPatchDirectiveNode >> postCopy [

	
]
