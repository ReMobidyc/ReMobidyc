Class {
	#name : #RMDSimulationDirectiveNode,
	#superclass : #RMDDirectiveNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDSimulationDirectiveNode class >> isAbstract [

	^ true
]

{ #category : #comparing }
RMDSimulationDirectiveNode >> = anObject [

	^ self class = anObject class
]

{ #category : #enumerating }
RMDSimulationDirectiveNode >> childrenDo: aBlock [
]

{ #category : #comparing }
RMDSimulationDirectiveNode >> hash [

	^ self class hash
]

{ #category : #testing }
RMDSimulationDirectiveNode >> isSimulationDirectiveNode [
	^ true
]

{ #category : #copying }
RMDSimulationDirectiveNode >> postCopy [
	
]

{ #category : #rewriting }
RMDSimulationDirectiveNode >> replaceChildren: aDictionary [
]
