Class {
	#name : #RMDMetaContextTest,
	#superclass : #TestCase,
	#instVars : [
		'context'
	],
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #running }
RMDMetaContextTest >> setUp [
	context := RMDMetaContext new
]

{ #category : #tests }
RMDMetaContextTest >> testAnyInterpreterRunning [

	| sem1 sem2 i1 i2 none |
	sem1 := Semaphore new.
	sem2 := Semaphore new.
	i1 := [ sem1 wait ] fork.
	i2 := [ sem2 signal ] fork.
	none := Object new.
	sem2 wait.
	Processor yield.
	context instVarNamed: 'processes' put: { 
			i1.
			i2 }.
	self assert: context anyInterpreterRunning.
	sem1 signal.
	Processor yield.
	self deny: context anyInterpreterRunning
]

{ #category : #tests }
RMDMetaContextTest >> testInterpreterAtIfAbsent [

	| i1 i2 |
	i1 := Object new.
	i2 := Object new.
	context instVarNamed: 'interpreters' put: { 
			i1.
			i2 }.
	self assert: (context interpreterAt: 1 ifAbsent: [ nil ]) equals: i1.
	self assert: (context interpreterAt: 2 ifAbsent: [ nil ]) equals: i2.
	self assert: (context interpreterAt: 3 ifAbsent: [ nil ]) equals: nil
]

{ #category : #tests }
RMDMetaContextTest >> testProcessAtIfAbsent [

	| sem1 sem2 i1 i2 none |
	sem1 := Semaphore new.
	sem2 := Semaphore new.
	i1 := [ sem1 wait ] fork.
	i2 := [ sem2 signal ] fork.
	none := Object new.
	sem2 wait.
	Processor yield.
	context instVarNamed: 'processes' put: { 
			i1.
			i2 }.
	self assert: (context processAt: 1 ifAbsent: [ none ]) equals: i1.
	sem1 signal.
	Processor yield.
	self assert: (context processAt: 2 ifAbsent: [ none ]) equals: none.
	self assert: (context processAt: 3 ifAbsent: [ none ]) equals: none
]

{ #category : #tests }
RMDMetaContextTest >> testProcessBarrier [

	context processBarrier: true.
	self assert: context processBarrier equals: true.
	context processBarrier: false.
	self assert: context processBarrier equals: false
]

{ #category : #tests }
RMDMetaContextTest >> testRemoveTerminatedProcesses [

	| sem processes |
	sem := Semaphore new.
	processes := { [ sem wait ] fork }.
	context instVarNamed: 'processes' put: processes.
	context removeTerminatedProcesses.
	self assert: (context processAt: 1 ifAbsent: [ nil ]) notNil.
	sem signal.
	Processor yield.
	self assert: (context processAt: 1 ifAbsent: [ nil ]) isNil
]

{ #category : #tests }
RMDMetaContextTest >> testRunIdString [

	self assert: (context runIdString: 1) equals: 'run1'.
	self assert: (context runIdString: 123) equals: 'run123'
]

{ #category : #tests }
RMDMetaContextTest >> testRunningRunIdsDo [

	| sem1 sem2 i1 i2 none |
	sem1 := Semaphore new.
	sem2 := Semaphore new.
	i1 := [ sem1 wait ] fork.
	i2 := [ sem2 signal ] fork.
	none := Object new.
	sem2 wait.
	Processor yield.
	context instVarNamed: 'processes' put: { 
			i1.
			i2 }.
	self
		assert: (Array streamContents: [ :stream | 
				 context runningRunIdsDo: [ :id | stream nextPut: id ] ])
		equals: { 1 }.
	sem1 signal.
	Processor yield.
	self
		assert: (Array streamContents: [ :stream | 
				 context runningRunIdsDo: [ :id | stream nextPut: id ] ])
		equals: {  }
]
