"
A GuitarTest is a test class for testing the behavior of Guitar
"
Class {
	#name : #GuitarTest,
	#superclass : #TestCase,
	#category : #'Polyglotric-EnhancedArangoDB-Tests'
}

{ #category : #tests }
GuitarTest >> testGuitarAccessors [

	| guitar varNames |
	guitar := Guitar new.
	varNames := guitar class instVarNames.
	self assert: (varNames includesAll: #(_id _rev _key))
]
