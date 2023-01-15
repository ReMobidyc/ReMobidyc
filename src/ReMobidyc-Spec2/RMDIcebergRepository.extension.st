Extension { #name : #RMDIcebergRepository }

{ #category : #'*ReMobidyc-Spec2' }
RMDIcebergRepository >> editMenu [

	^ SpMenuPresenter new
		  addGroup: [ :group | 
			  group
				  addItem: [ :item | 
					  item
						  name: 'Rename...';
						  action: [ self rename ] ];
				  addItem: [ :item | 
					  item
						  name: 'open Repository';
						  icon: RMDIcebergRepository icon;
						  action: [ 
							  self icebergRepository ifNotNil: [ :repo | 
									  (RMDIcebergRepositoryBrowser on: repo) open ] ] ] ];
		  yourself
]
