Class {
	#name : #SindarinStepCommand,
	#superclass : #SindarinCommand,
	#category : #'NewTools-Sindarin-Tools'
}

{ #category : #default }
SindarinStepCommand class >> defaultCommandName [
	^ 'Step'
]

{ #category : #default }
SindarinStepCommand class >> defaultDescription [
	^ 'Step in'
]

{ #category : #initialization }
SindarinStepCommand class >> defaultIconName [
	^#glamorousInto
]

{ #category : #hooks }
SindarinStepCommand >> execute [
	self context step
]