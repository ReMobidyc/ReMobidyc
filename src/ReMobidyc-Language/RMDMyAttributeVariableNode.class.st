Class {
	#name : 'RMDMyAttributeVariableNode',
	#superclass : 'RMDAttributeVariableNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'accessing' }
RMDMyAttributeVariableNode >> agent [
	^ nil
]

{ #category : 'testing' }
RMDMyAttributeVariableNode >> isMyAttributeVariableNode [

	^ true
]

{ #category : 'accessing' }
RMDMyAttributeVariableNode >> prefix [

	^ 'my'
]
