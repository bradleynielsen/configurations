Attribute VB_Name = "Module1"
'Macros for Ribbon buttons
'Author:            Brad Nielsen
'Last Modified:     11/10/2017

Sub TabToYellow()
'
' TabToYellow Macro
'
With ActiveSheet.Tab
        .Color = 65535
        .TintAndShade = 0
    End With
End Sub
Sub TabToRed()
'
' TabToRed Macro
'
With ActiveSheet.Tab
        .Color = 255
        .TintAndShade = 0
    End With
End Sub
Sub TabToGreen()
'
' TabToGreen Macro
'
With ActiveSheet.Tab
        .Color = 5287936
        .TintAndShade = 0
    End With
End Sub
Sub TabToBlue()
'
' TabToBlue Macro
'
With ActiveSheet.Tab
        .Color = 15773696
        .TintAndShade = 0
    End With
End Sub
Sub TabNoColor()
' TabNoColor Macro
With ActiveSheet.Tab
    .ColorIndex = xlNone
End With
  
End Sub




Sub CellsNoColor()
' Cells to No Color Macro
    With Selection.Interior
        .Pattern = xlNone
        .TintAndShade = 0
        .PatternTintAndShade = 0
    End With
End Sub

Sub CellsToYellow()
'
' Cells to Yellow Macro
'
   Dim rng As Range
   Set rng = Selection
     With Selection.Interior
        .Pattern = xlSolid
        .PatternColorIndex = xlAutomatic
        .Color = 65535
        .TintAndShade = 0
        .PatternTintAndShade = 0
    End With
End Sub


Sub CellsToRed()
'
' Cells to Red Macro
'
   Dim rng As Range
   Set rng = Selection
    With Selection.Interior
        .Pattern = xlSolid
        .PatternColorIndex = xlAutomatic
        .Color = 255
        .TintAndShade = 0
        .PatternTintAndShade = 0
    End With
End Sub



Sub AutoSizeCol()
'Auto size columns and rows
    Cells.Select
    Cells.EntireRow.AutoFit
    Cells.EntireColumn.AutoFit
    
    Range("A1").Select
End Sub
Sub UsedRange()
'Reset the used range
    ActiveSheet.UsedRange
End Sub
Sub ResetComments()
Dim cmt As Comment
For Each cmt In ActiveSheet.Comments
   cmt.Shape.Top = cmt.Parent.Top + 5
   cmt.Shape.Left = _
      cmt.Parent.Offset(0, 1).Left + 5
Next
End Sub

Sub Comments_AutoSize()
'posted by Dana DeLouis  2000-09-16

  Dim MyComments As Comment
  Dim lArea As Long
  For Each MyComments In ActiveSheet.Comments
    With MyComments
      .Shape.TextFrame.AutoSize = True
      If .Shape.Width > 300 Then
        lArea = .Shape.Width * .Shape.Height
        .Shape.Width = 200
        ' An adjustment factor of 1.1
         ' seems to work ok.
        .Shape.Height = (lArea / 200) * 1.1
      End If
    End With
  Next ' comment
End Sub


Sub HideUnhideNote()
'Hide and unhide comments

On Error GoTo EscapeError

If ActiveCell.Comment.Visible = True Then
    ActiveCell.Comment.Visible = False
Else
    ActiveCell.Comment.Visible = True
End If

EscapeError:

End Sub



'Fn for ADALR
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

'Author:            Chase Younger
'Last Modified:     2/18/2016

'Searches workbook for lookup value and returns a string of comma separated worksheet names for worksheets in which that value was found.
Function MYWBSEARCH(lookupval)

Dim sh As Worksheet
Dim Loc As Range
Dim result As String

For Each sh In ThisWorkbook.Worksheets
    With sh.UsedRange
        Set Loc = .Cells.Find(lookupval)
        If Not Loc Is Nothing Then
            Do Until Loc Is Nothing
                result = result + sh.Name + ", "
                Set Loc = .FindNext(Loc)
            Loop
        End If
    End With
    Set Loc = Nothing
Next
MYWBSEARCH = result
End Function


Sub hideTab()

    ActiveWindow.SelectedSheets.Visible = False

End Sub

Sub deleteTab()
    
    ActiveWindow.SelectedSheets.Delete
    
End Sub
