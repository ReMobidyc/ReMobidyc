Extension { #name : 'RSBoundingShape' }

{ #category : '*ReMobidyc-Spec2' }
RSBoundingShape >> translateBottomMiddleTo: aPositionAsPoint [
	"Translate the shape to make the top left corner at a given position

```
c := RSCanvas new.
lbl := RSLabel text: 'Top left corner'.
c add: lbl.
lbl setAsFixed.
lbl translateTopLeftTo: 0 @ 0.
c open
```
	
"

	self translateTo: aPositionAsPoint - (0 @ self height / 2)
]

{ #category : '*ReMobidyc-Spec2' }
RSBoundingShape >> translateMiddleLeftTo: aPositionAsPoint [
	"Translate the shape to make the middle right position at a given position

```
|c center label |
c := RSCanvas new.

center := RSEllipse new size: 2; color: Color red.
c add: center.
center translateTo: 0 @ 0.

label := RSLabel text: 'Middle left corner'.
c add: label.
label translateMiddleLeftTo: 0 @ 0.
c @ RSCanvasController.
c open
```
	
"
	self translateTo: aPositionAsPoint + ((self extent x / 2) @ 0)
]

{ #category : '*ReMobidyc-Spec2' }
RSBoundingShape >> translateTopMiddleTo: aPositionAsPoint [
	"Translate the shape to make the top left corner at a given position

```
c := RSCanvas new.
lbl := RSLabel text: 'Top left corner'.
c add: lbl.
lbl setAsFixed.
lbl translateTopLeftTo: 0 @ 0.
c open
```
	
"

	self translateTo: aPositionAsPoint + (0 @ self height / 2)
]
