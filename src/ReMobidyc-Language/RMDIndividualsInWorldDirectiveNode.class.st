Class {
	#name : #RMDIndividualsInWorldDirectiveNode,
	#superclass : #RMDSimulationDirectiveNode,
	#instVars : [
		'animatName'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDIndividualsInWorldDirectiveNode class >> animatName: aString [

	^ self new
		  animatName: aString;
		  yourself
]

{ #category : #comparing }
RMDIndividualsInWorldDirectiveNode >> = anObject [

	^ self class = anObject class and: [ 
		  animatName = anObject animatName ]
]

{ #category : #accessing }
RMDIndividualsInWorldDirectiveNode >> animatName [

	^ animatName
]

{ #category : #accessing }
RMDIndividualsInWorldDirectiveNode >> animatName: aString [

	animatName := aString
]

{ #category : #enumerating }
RMDIndividualsInWorldDirectiveNode >> childrenDo: aBlock [

	
]

{ #category : #comparing }
RMDIndividualsInWorldDirectiveNode >> hash [

	^ self class hash bitXor: animatName hash
]

{ #category : #copying }
RMDIndividualsInWorldDirectiveNode >> postCopy [

	
]
