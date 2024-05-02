Trait {
	#name : 'TRMDPresenter',
	#category : 'ReMobidyc-Spec2-Traits',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Traits'
}

{ #category : 'api' }
TRMDPresenter >> beError [

	self color: self errorColor
]

{ #category : 'api' }
TRMDPresenter >> beOk [
	self color: self okColor
]

{ #category : 'api' }
TRMDPresenter >> beWarning [
	self color: self warningColor
]

{ #category : 'accessing' }
TRMDPresenter >> color: aColor [

	super color: aColor.
	self withAdapterDo: [ :a |
		a widgetDo: [ :w | w ifNotNil: [ w color: aColor ] ] ]
]

{ #category : 'accessing' }
TRMDPresenter >> errorColor [
	^ self theme backgroundColor mixed: 0.9 with: Color red
]

{ #category : 'accessing' }
TRMDPresenter >> okColor [
	^ self theme backgroundColor
]

{ #category : 'accessing' }
TRMDPresenter >> warningColor [
	^ self theme backgroundColor mixed: 0.9 with: Color yellow
]
