Class {
	#name : 'RMDAnyType',
	#superclass : 'RMDType',
	#category : 'ReMobidyc-Language-Type',
	#package : 'ReMobidyc-Language',
	#tag : 'Type'
}

{ #category : 'arithmetics' }
RMDAnyType >> * aRMDType [

	^ self
]

{ #category : 'arithmetics' }
RMDAnyType >> ** aNumber [

	^ self
]

{ #category : 'arithmetics' }
RMDAnyType >> / aRMDType [

	^ self
]

{ #category : 'comparing' }
RMDAnyType >> = anObject [
	^ self class = anObject class
]

{ #category : 'comparing' }
RMDAnyType >> hash [
	^ self class hash
]

{ #category : 'testing' }
RMDAnyType >> isAny [

	^ true
]

{ #category : 'printing' }
RMDAnyType >> printOn: aStream [

	aStream nextPutAll: '[*]'
]

{ #category : 'type checking' }
RMDAnyType >> unify: aRMDType [
	^ aRMDType
]

{ #category : 'accessing' }
RMDAnyType >> unit [

	^ nil
]
