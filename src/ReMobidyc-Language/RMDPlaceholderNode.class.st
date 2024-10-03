Class {
	#name : 'RMDPlaceholderNode',
	#superclass : 'RMDSyntaxNode',
	#instVars : [
		'identifier'
	],
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'instance creation' }
RMDPlaceholderNode class >> identifier: aString [

	^ self new
		  identifier: aString;
		  yourself
]

{ #category : 'comparing' }
RMDPlaceholderNode >> = anObject [

	^ self class = anObject class and: [ 
		  identifier = anObject identifier ]
]

{ #category : 'accessing' }
RMDPlaceholderNode >> agent [
	^ #the
]

{ #category : 'converting' }
RMDPlaceholderNode >> asPrettyPrintNode [

	^ RMDPrettyPrintNode agent: 'the' attribute: self identifier
]

{ #category : 'enumerating' }
RMDPlaceholderNode >> childrenDo: aBlock [

	
]

{ #category : 'enumerating' }
RMDPlaceholderNode >> childrenTransform: aBlock [

	
]

{ #category : 'comparing' }
RMDPlaceholderNode >> hash [

	^ self class hash bitXor: identifier hash
]

{ #category : 'accessing' }
RMDPlaceholderNode >> identifier [

	^ identifier
]

{ #category : 'accessing' }
RMDPlaceholderNode >> identifier: aString [

	identifier := aString
]

{ #category : 'testing' }
RMDPlaceholderNode >> isConditionPlaceholderIn: aRMDActionDefinitionNode [

	^ aRMDActionDefinitionNode hasConditionPlaceholder: self
]

{ #category : 'testing' }
RMDPlaceholderNode >> isPlaceholderNode [

	^ true
]

{ #category : 'copying' }
RMDPlaceholderNode >> postCopy [

	
]

{ #category : 'accessing' }
RMDPlaceholderNode >> precedence [
	^ 1
]

{ #category : 'accessing' }
RMDPlaceholderNode >> prefix [
	^ 'the'
]

{ #category : 'printing' }
RMDPlaceholderNode >> printOn: aStream [

	aStream
		nextPutAll: self prefix;
		space;
		nextPutAll: identifier
]

{ #category : 'printing' }
RMDPlaceholderNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: self prefix;
		space;
		nextPutAll: identifier.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : 'rewriting' }
RMDPlaceholderNode >> replaceChildren: aDictionary [

	aDictionary
		at: identifier
		ifPresent: [ :node | identifier := node copy ]
]
