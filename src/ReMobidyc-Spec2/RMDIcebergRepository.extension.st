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
						  name: 'open Iceberg';
						  icon: RMDIcebergRepository icon;
						  action: [ 
							  self icebergRepository ifNotNil: [ :repo | 
									  (IceTipRepositoryBrowser onRepository: repo) open ] ] ] ];
		  yourself
]
