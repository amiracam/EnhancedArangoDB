Class {
	#name : #Guitar,
	#superclass : #Object,
	#traits : 'ArangoObject + DataObject',
	#classTraits : 'ArangoObject classTrait + DataObject classTrait',
	#category : #'Polyglotric-EnhancedArangoDB-Tests'
}

{ #category : #'as yet unclassified' }
Guitar >> attributes [ 
	^#(_key model brand yearBuilt pickupType neckType)
]
