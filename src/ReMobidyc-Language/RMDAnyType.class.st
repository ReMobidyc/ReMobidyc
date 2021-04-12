Class {
	#name : #RMDAnyType,
	#superclass : #RMDType,
	#category : #'ReMobidyc-Language-Type'
}

{ #category : #comparing }
RMDAnyType >> = anObject [
	^ self class = anObject class
]

{ #category : #comparing }
RMDAnyType >> hash [
	^ self class hash
]

{ #category : #'type checking' }
RMDAnyType >> unify: aRMDType [
	^ aRMDType
]

{ #category : #'type checking' }
RMDAnyType >> unifyWithUnitType: aRMDType [
	^ aRMDType
]
