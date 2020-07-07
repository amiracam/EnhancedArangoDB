Class {
	#name : #Guitar,
	#superclass : #Object,
	#traits : 'ArangoObject + DataObject',
	#classTraits : 'ArangoObject classTrait + DataObject classTrait',
	#instVars : [
		'model',
		'brand',
		'yearBuilt',
		'pickupType',
		'neckType'
	],
	#category : #'Polyglotric-EnhancedArangoDB-Tests'
}

{ #category : #'as yet unclassified' }
Guitar >> attributes [ 
	^#(model brand yearBuilt pickupType neckType)
]
