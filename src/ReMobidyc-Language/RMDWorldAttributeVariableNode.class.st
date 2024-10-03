Class {
	#name : 'RMDWorldAttributeVariableNode',
	#superclass : 'RMDAttributeVariableNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'accessing' }
RMDWorldAttributeVariableNode >> agent [

	^ #world
]

{ #category : 'testing' }
RMDWorldAttributeVariableNode >> isWorldAttributeVariableNode [

	^ true
]

{ #category : 'accessing' }
RMDWorldAttributeVariableNode >> prefix [

	^ 'world''s'
]
