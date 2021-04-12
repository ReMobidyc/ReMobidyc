Class {
	#name : #RMDType,
	#superclass : #Object,
	#category : #'ReMobidyc-Language-Type'
}

{ #category : #'instance creation' }
RMDType class >> any [
	^ self anyTypeClass new
]

{ #category : #'class access' }
RMDType class >> anyTypeClass [
	^ RMDAnyType
]

{ #category : #'instance creation' }
RMDType class >> m [
	^ self unitTypeClass unit: RMDUnit m
]

{ #category : #'instance creation' }
RMDType class >> noDimension [
	^ self unitTypeClass unit: RMDUnit noDimension
]

{ #category : #'instance creation' }
RMDType class >> rad [
	^ self unitTypeClass unit: RMDUnit rad
]

{ #category : #'instance creation' }
RMDType class >> s [
	^ self unitTypeClass unit: RMDUnit s
]

{ #category : #'instance creation' }
RMDType class >> unit: aRMDUnit [
	^ self unitTypeClass unit: aRMDUnit
]

{ #category : #'class access' }
RMDType class >> unitTypeClass [
	^ RMDUnitType
]

{ #category : #'type checking' }
RMDType >> unify: aRMDType [
	^ self subclassResponsibility
]

{ #category : #'type checking' }
RMDType >> unifyWithUnitType: aRMDType [
	^ self subclassResponsibility
]
