Class {
	#name : 'RMDRandomNode',
	#superclass : 'RMDExpressionNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'testing' }
RMDRandomNode class >> isAbstract [

	^ self == RMDRandomNode
]

{ #category : 'converting' }
RMDRandomNode >> asPresenter [

	^ RMDBinaryDistributionPresenter on: self
]

{ #category : 'accessing' }
RMDRandomNode >> distributionName [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
RMDRandomNode >> parameter1Expression [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
RMDRandomNode >> parameter2Expression [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
RMDRandomNode >> parameterName [

	^ self subclassResponsibility
]
