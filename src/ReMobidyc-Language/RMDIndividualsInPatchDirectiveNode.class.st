Class {
	#name : 'RMDIndividualsInPatchDirectiveNode',
	#superclass : 'RMDPatchDirectiveNode',
	#instVars : [
		'animatName'
	],
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'instance creation' }
RMDIndividualsInPatchDirectiveNode class >> animatName: aString [

	^ self new
		  animatName: aString;
		  yourself
]

{ #category : 'testing' }
RMDIndividualsInPatchDirectiveNode class >> isAbstract [

	^ self == RMDIndividualsInPatchDirectiveNode
]

{ #category : 'comparing' }
RMDIndividualsInPatchDirectiveNode >> = anObject [

	^ self class = anObject class and: [ 
		  animatName = anObject animatName ]
]

{ #category : 'accessing' }
RMDIndividualsInPatchDirectiveNode >> animatName [

	^ animatName
]

{ #category : 'accessing' }
RMDIndividualsInPatchDirectiveNode >> animatName: aString [

	animatName := aString
]

{ #category : 'converting' }
RMDIndividualsInPatchDirectiveNode >> asPresenter [

	^ RMDIndividualsInLocationDirectivePresenter on: self
]

{ #category : 'enumerating' }
RMDIndividualsInPatchDirectiveNode >> childrenDo: aBlock [

	
]

{ #category : 'accessing' }
RMDIndividualsInPatchDirectiveNode >> directiveName [

	^ self subclassResponsibility
]

{ #category : 'comparing' }
RMDIndividualsInPatchDirectiveNode >> hash [

	^ self class hash bitXor: animatName hash
]

{ #category : 'accessing' }
RMDIndividualsInPatchDirectiveNode >> locationName [

	^ 'here'
]

{ #category : 'copying' }
RMDIndividualsInPatchDirectiveNode >> postCopy [

	
]
