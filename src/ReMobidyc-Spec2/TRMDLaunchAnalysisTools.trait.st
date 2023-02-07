Trait {
	#name : #TRMDLaunchAnalysisTools,
	#category : #'ReMobidyc-Spec2-Traits'
}

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

	(self newMenu
		 addGroup: [ :group | 
			 group
				 addItem: [ :item | 
					 item
						 name: 'Population';
						 action: [ self openInPopulationTabular ] ];
				 addItem: [ :item | 
					 item
						 name: 'Attributes at Time';
						 action: [ self openInAttributeTabular ] ] ];
		 yourself) openWithSpecAtPointer
]

{ #category : #private }
TRMDLaunchAnalysisTools >> selectedTime [

	^ self subclassResponsibility
]
