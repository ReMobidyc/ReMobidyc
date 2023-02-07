Trait {
	#name : #TRMDLaunchAnalysisTools,
	#category : #'ReMobidyc-Spec2-Traits'
}

{ #category : #menus }
TRMDLaunchAnalysisTools >> analysisMenu [

	| menu |
	menu := self newMenu.
	self tabularMenu: menu.
	self replayObservatoryMenu: menu.
	^ menu
]

{ #category : #private }
TRMDLaunchAnalysisTools >> metaInterpreterForTabularDo: aBlock [

	^ self subclassResponsibility
]

{ #category : #operations }
TRMDLaunchAnalysisTools >> openInAttributeTabular [

	^ (self metaInterpreterForTabularDo: #openInAttributeTabular)
		  selectTime: self selectedTime;
		  yourself
]

{ #category : #operations }
TRMDLaunchAnalysisTools >> openInPopulationTabular [

	^ (self metaInterpreterForTabularDo: #openInPopulationTabular)
		  selectTime: self selectedTime;
		  yourself
]

{ #category : #operations }
TRMDLaunchAnalysisTools >> openInReplayObservatory [

	^ (self metaInterpreterForTabularDo: #openInReplayObservatory)
		  selectTime: self selectedTime;
		  yourself
]

{ #category : #operations }
TRMDLaunchAnalysisTools >> openTabularMenu [

	self tabularMenu openWithSpecAtPointer
]

{ #category : #menus }
TRMDLaunchAnalysisTools >> replayObservatoryMenu [

	^ self replayObservatoryMenu: self newMenu
]

{ #category : #menus }
TRMDLaunchAnalysisTools >> replayObservatoryMenu: aSpMenuPresenter [

	^ aSpMenuPresenter
		  addGroup: [ :group | 
			  group addItem: [ :item | 
					  item
						  name: 'Open in Observatory';
						  action: [ self openInReplayObservatory ] ] ];
		  yourself
]

{ #category : #private }
TRMDLaunchAnalysisTools >> selectedTime [

	^ self subclassResponsibility
]

{ #category : #menus }
TRMDLaunchAnalysisTools >> tabularMenu [

	^ self tabularMenu: self newMenu
]

{ #category : #menus }
TRMDLaunchAnalysisTools >> tabularMenu: aSpMenuPresenter [

	^ aSpMenuPresenter
		  addGroup: [ :group | 
			  group
				  addItem: [ :item | 
					  item
						  name: 'Open in Population Tabular';
						  action: [ self openInPopulationTabular ] ];
				  addItem: [ :item | 
					  item
						  name: 'Open in Attributes at Time Tabular';
						  action: [ self openInAttributeTabular ] ] ];
		  yourself
]
