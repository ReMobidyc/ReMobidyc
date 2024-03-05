Class {
	#name : #RMDTraceNode,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'node',
		'value'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDTraceNode class >> on: aRMDSyntaxNode [

	^ self new
		  node: aRMDSyntaxNode;
		  yourself
]

{ #category : #comparing }
RMDTraceNode >> = anObject [

	^ anObject = node
]

{ #category : #enumerating }
RMDTraceNode >> childrenDo: aBlock [

	aBlock value: node
]

{ #category : #enumerating }
RMDTraceNode >> childrenTransform: aBlock [

	node := aBlock value: node
]

{ #category : #comparing }
RMDTraceNode >> hash [

	^ node hash
]

{ #category : #private }
RMDTraceNode >> insertTrace [

	
]

{ #category : #accessing }
RMDTraceNode >> node [

	^ node
]

{ #category : #accessing }
RMDTraceNode >> node: aRMDSyntaxNode [

	node := aRMDSyntaxNode
]

{ #category : #private }
RMDTraceNode >> pealTrace [

	^ node
]

{ #category : #copying }
RMDTraceNode >> postCopy [

	node := node copy
]

{ #category : #accessing }
RMDTraceNode >> precedence [

	^ node precedence
]

{ #category : #printing }
RMDTraceNode >> printOn: aStream [

	value
		ifNotNil: [
			type
				ifNotNil: [
					(type originalUnit fromSI: value) printOn: aStream.
					aStream nextPut: $[.
					type originalUnit printOn: aStream.
					aStream nextPut: $] ]
				ifNil: [ value printOn: aStream ] ]
		ifNil: [ node printOn: aStream ]
]

{ #category : #printing }
RMDTraceNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	value
		ifNotNil: [
			type
				ifNotNil: [
					(type originalUnit fromSI: value) printOn: aStream.
					aStream nextPut: $[.
					type originalUnit printOn: aStream.
					aStream nextPut: $] ]
				ifNil: [ value printOn: aStream ] ]
		ifNil: [
			node
				printOn: aStream
				ifIncludedIn: aCollectionOfRMDSyntaxNode
				addSectionTo: aCollection ]
]

{ #category : #private }
RMDTraceNode >> removeTrace [

	^ node removeTrace
]

{ #category : #rewriting }
RMDTraceNode >> replaceChildren: aDictionary [

	node replaceChildren: aDictionary
]

{ #category : #accessing }
RMDTraceNode >> value [

	^ value
]
