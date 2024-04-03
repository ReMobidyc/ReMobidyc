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

{ #category : #testing }
RMDIndividualsInWorldDirectiveNode class >> isAbstract [

	^ self == RMDIndividualsInWorldDirectiveNode
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

{ #category : #converting }
RMDIndividualsInWorldDirectiveNode >> asPresenter [

	^ RMDIndividualsInLocationDirectivePresenter on: self
]

{ #category : #enumerating }
RMDIndividualsInWorldDirectiveNode >> childrenDo: aBlock [

	
]

{ #category : #accessing }
RMDIndividualsInWorldDirectiveNode >> directiveName [

	^ self subclassResponsibility
]

{ #category : #comparing }
RMDIndividualsInWorldDirectiveNode >> hash [

	^ self class hash bitXor: animatName hash
]

{ #category : #accessing }
RMDIndividualsInWorldDirectiveNode >> locationName [

	^ 'in world'
]

{ #category : #copying }
RMDIndividualsInWorldDirectiveNode >> postCopy [

	
]
