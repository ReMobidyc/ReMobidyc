Class {
	#name : 'RMDSimulationDirectiveNode',
	#superclass : 'RMDDirectiveNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'testing' }
RMDSimulationDirectiveNode class >> isAbstract [

	^ self = RMDSimulationDirectiveNode
]

{ #category : 'comparing' }
RMDSimulationDirectiveNode >> = anObject [

	^ self class = anObject class
]

{ #category : 'enumerating' }
RMDSimulationDirectiveNode >> childrenDo: aBlock [
]

{ #category : 'comparing' }
RMDSimulationDirectiveNode >> hash [

	^ self class hash
]

{ #category : 'testing' }
RMDSimulationDirectiveNode >> isSimulationDirectiveNode [
	^ true
]

{ #category : 'copying' }
RMDSimulationDirectiveNode >> postCopy [
	
]

{ #category : 'rewriting' }
RMDSimulationDirectiveNode >> replaceChildren: aDictionary [
]
