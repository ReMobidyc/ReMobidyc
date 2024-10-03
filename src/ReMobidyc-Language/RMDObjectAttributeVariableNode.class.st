Class {
	#name : 'RMDObjectAttributeVariableNode',
	#superclass : 'RMDAttributeVariableNode',
	#instVars : [
		'agent'
	],
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'instance creation' }
RMDObjectAttributeVariableNode class >> identifier: aString agent: anotherString [

	^ (self identifier: aString)
		  agent: anotherString;
		  yourself
]

{ #category : 'comparing' }
RMDObjectAttributeVariableNode >> = anObject [
	^ super = anObject and: [ self agent = anObject agent ]
]

{ #category : 'accessing' }
RMDObjectAttributeVariableNode >> agent [
	^ agent
]

{ #category : 'accessing' }
RMDObjectAttributeVariableNode >> agent: aString [
	agent := aString
]

{ #category : 'comparing' }
RMDObjectAttributeVariableNode >> hash [
	^ super hash bitXor: agent hash
]

{ #category : 'accessing' }
RMDObjectAttributeVariableNode >> prefix [

	^ agent , '''s '
]

{ #category : 'rewriting' }
RMDObjectAttributeVariableNode >> renameAnimat: aString to: anotherString [

	agent = aString uncapitalized ifTrue: [ 
		agent := anotherString uncapitalized ].
	super renameAnimat: aString to: anotherString
]

{ #category : 'rewriting' }
RMDObjectAttributeVariableNode >> replaceChildren: aDictionary [
	super replaceChildren: aDictionary.
	aDictionary at: agent ifPresent: [ :node | agent := node copy ]
]
