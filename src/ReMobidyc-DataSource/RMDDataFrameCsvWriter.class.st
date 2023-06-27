Class {
	#name : #RMDDataFrameCsvWriter,
	#superclass : #DataFrameCsvWriter,
	#category : #'ReMobidyc-DataSource-Utilities'
}

{ #category : #writing }
RMDDataFrameCsvWriter >> write: aDataFrame to: aFileReference [

	| stream writer |
	stream := aFileReference writeStream.

	writer := NeoCSVWriter on: stream.
	writer
		fieldWriter: #raw;
		separator: self separator;
		lineEndConvention: self lineEndConvention.
	writer writeHeader: aDataFrame columnNames.
	aDataFrame do: [ :row | writer nextPut: row ].
	writer close
]
