Class {
	#name : 'RemobidycMenubarMorph',
	#superclass : 'MenubarMorph',
	#category : 'ReMobidyc-Application',
	#package : 'ReMobidyc-Application'
}

{ #category : 'instance creation' }
RemobidycMenubarMorph class >> open [

	<script>
	self new
		menuBarItems:
			(PragmaMenuBuilder pragmaKeyword: #remobidycMenu model: self)
				menuSpec items;
		open
]

{ #category : 'class initialization' }
RemobidycMenubarMorph class >> reset [

	<script>
	self closeAll.
	self open
]
