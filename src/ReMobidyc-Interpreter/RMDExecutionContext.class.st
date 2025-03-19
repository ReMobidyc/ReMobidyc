Class {
	#name : 'RMDExecutionContext',
	#superclass : 'RMDContext',
	#instVars : [
		'subject',
		'subjectDefinition'
	],
	#category : 'ReMobidyc-Interpreter-Contexts',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Contexts'
}

{ #category : 'instance creation' }
RMDExecutionContext class >> subject: anInteger definition: aRMDAgentDefinitionNode [
	^ self new
		subject: anInteger definition: aRMDAgentDefinitionNode;
		yourself
]

{ #category : 'accessing' }
RMDExecutionContext >> subject [
	^ subject
]

{ #category : 'accessing' }
RMDExecutionContext >> subject: anInteger definition: aRMDAgentDefinitionNode [

	subject := anInteger.
	subjectDefinition := aRMDAgentDefinitionNode
]

{ #category : 'accessing' }
RMDExecutionContext >> subjectDefinition [
	^ subjectDefinition
]
