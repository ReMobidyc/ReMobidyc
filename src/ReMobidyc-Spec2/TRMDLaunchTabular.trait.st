Trait {
	#name : #TRMDLaunchTabular,
	#category : #'ReMobidyc-Spec2-Traits'
}

{ #category : #operations }
TRMDLaunchTabular >> openInAttributeTabular [

	self load ifNotNil: [ :model | 
		self repository isRunsRepository ifTrue: [ 
			(model metaInterpreterOnReadOnlyModelPath: self file) ifNotNil:
				#openInAttributeTabular ] ]
]

{ #category : #operations }
TRMDLaunchTabular >> openInPopulationTabular [

	self load ifNotNil: [ :model | 
		self repository isRunsRepository ifTrue: [ 
			(model metaInterpreterOnReadOnlyModelPath: self file) ifNotNil:
				#openInPopulationTabular ] ]
]

{ #category : #operations }
TRMDLaunchTabular >> openInTabular [

	(self newMenu
		 addGroup: [ :group | 
			 group
				 addItem: [ :item | 
					 item
						 name: 'Population';
						 action: [ self openInPopulationTabular ] ];
				 addItem: [ :item | 
					 item
						 name: 'Attributes';
						 action: [ self openInAttributeTabular ] ] ];
		 yourself) openWithSpecAtPointer
]
