Function LastCol(sh As Worksheet)
    On Error Resume Next
    LastCol = sh.Cells.Find(What:="*", _
                            After:=sh.Range("A1"), _
                            Lookat:=xlPart, _
                            LookIn:=xlFormulas, _
                            SearchOrder:=xlByColumns, _
                            SearchDirection:=xlPrevious, _
                            MatchCase:=False).Column
    On Error GoTo 0
End Function

Function LastRow(sh As Worksheet)
    On Error Resume Next
    LastRow = sh.Cells.Find(What:="*", _
                            After:=sh.Range("A1"), _
                            Lookat:=xlPart, _
                            LookIn:=xlFormulas, _
                            SearchOrder:=xlByRows, _
                            SearchDirection:=xlPrevious, _
                            MatchCase:=False).Row
    On Error GoTo 0
End Function

Sub AppendDataAfterLastColumn()
    Dim sh As Worksheet
    Dim DestSh As Worksheet
    Dim Last As Long
    Dim CopyRng As Range

    With Application
        .ScreenUpdating = False
        .EnableEvents = False
    End With

    ' Delete the summary worksheet if it exists.
    Application.DisplayAlerts = False
    On Error Resume Next
    ActiveWorkbook.Worksheets("MergedHoriz").Delete
    On Error GoTo 0
    Application.DisplayAlerts = True

    ' Add a worksheet with the name "RDBMergeSheet"
    Set DestSh = ActiveWorkbook.Worksheets.Add
    DestSh.Name = "MergedHoriz"

    ' Loop through all worksheets and copy the data to the
    ' summary worksheet.
    For Each sh In ActiveWorkbook.Worksheets
        If sh.Name <> DestSh.Name Then

            ' Find the last column with data on the summary
            ' worksheet.
            Last = LastCol(DestSh)

            ' Fill in the columns that you want to copy.
            Set CopyRng = sh.Range("A:K")

            ' Test to see whether there enough rows in the summary
            ' worksheet to copy all the data.
            If Last + CopyRng.Columns.Count > DestSh.Columns.Count Then
                MsgBox "There are not enough columns in " & _
                   "the summary worksheet."
                GoTo ExitTheSub
            End If

            ' This statement copies values, formats, and the column width.
            CopyRng.Copy
            With DestSh.Cells(1, Last + 1)
                .PasteSpecial 8    ' Column width
                .PasteSpecial xlPasteValues
                .PasteSpecial xlPasteFormats
                Application.CutCopyMode = False
            End With

        End If
    Next

ExitTheSub:

    Application.Goto DestSh.Cells(1)

    With Application
        .ScreenUpdating = True
        .EnableEvents = True
    End With
End Sub


Sub AppendDataAfterLastRow()
    Dim sh As Worksheet
    Dim DestSh As Worksheet
    Dim Last As Long
    Dim CopyRng As Range

    With Application
        .ScreenUpdating = False
        .EnableEvents = False
    End With

    ' Delete the summary worksheet if it exists.
    Application.DisplayAlerts = False
    On Error Resume Next
    ActiveWorkbook.Worksheets("MergedVert").Delete
    On Error GoTo 0
    Application.DisplayAlerts = True

    ' Add a worksheet with the name "RDBMergeSheet"
    Set DestSh = ActiveWorkbook.Worksheets.Add
    DestSh.Name = "MergedVert"

    ' Loop through all worksheets and copy the data to the
    ' summary worksheet.
    For Each sh In ActiveWorkbook.Worksheets
        If sh.Name <> DestSh.Name Then

            ' Find the last column with data on the summary
            ' worksheet.
            Last = LastRow(DestSh)

            ' Fill in the rows that you want to copy. ??????????
            '????????? need to set this to return a vertical range
            Set CopyRng = sh.UsedRange

            ' Test to see whether there enough rows in the summary
            ' worksheet to copy all the data.
            If Last + CopyRng.Rows.Count > DestSh.Rows.Count Then

                MsgBox "source worksheet rows: " & Last
                MsgBox "range rows: " & CopyRng.Rows.Count
                MsgBox "summary worksheet rows: " & DestSh.Rows.Count
                MsgBox "There are not enough rows in " & _
                   "the summary worksheet."
                GoTo ExitTheSub
            End If

            ' This statement copies values, formats, and the column width.
            CopyRng.Copy
            With DestSh.Cells(Last + 1, 1)
                .PasteSpecial 8    ' Column width
                .PasteSpecial xlPasteValues
                .PasteSpecial xlPasteFormats
                Application.CutCopyMode = False
            End With

        End If
    Next

ExitTheSub:

    Application.Goto DestSh.Cells(1)

    With Application
        .ScreenUpdating = True
        .EnableEvents = True
    End With
End Sub
