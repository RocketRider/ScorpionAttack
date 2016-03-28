
Procedure.l __DownloadToMem(AgentName.s, URL$, ptr.l, size.l ) 
  net = InternetOpen_("Top10Uplader_"+AgentName, 0, 0, 0, 0) 
  result = InternetOpenUrl_(net, URL$, "", 0, $84000000, 0) 
  If result > 0 
    InternetReadFile_ ( result, ptr, size, @readsize) 
  EndIf 
  InternetCloseHandle_ (net) 
  InternetCloseHandle_ (result) 
  ProcedureReturn result
EndProcedure 

Procedure.s __UploadTop10Data(AgentName.s,Address.s,Top10Data.s,Key.s)
;Address: http://www.test.de/top10/
;Top10Data name1,100,name2,200
;Key: DEIN_KEY

Top10Data.s=","+ Top10Data
Top10Data.s=ReplaceString(Top10Data,":","")
Top10Data.s=ReplaceString(Top10Data,";","")
Top10Data.s=ReplaceString(Top10Data,"%","")
Top10Data.s=ReplaceString(Top10Data,"&","")
Top10Data.s=ReplaceString(Top10Data,"=","")
Top10Data.s=ReplaceString(Top10Data,"?","")
;Top10Data.s=ReplaceString(Top10Data," ","")
Top10Data.s=ReplaceString(Top10Data,",","%2C")
lens.s = Str(Len(Top10Data))
len.s = LSet("",4 - Len(lens.s),"0") +lens
Top10Data.s=len.s + Top10Data

res.s=Space(31)

result = __DownloadToMem(AgentName.s, Address+"top10_writer.php?top10data="+Top10Data+"&key="+Key.s, @res, 31) 

If result > 0
ProcedureReturn res
EndIf

ProcedureReturn ""
EndProcedure

Procedure.s __DownloadTop10Data(Address.s)
length.s=Space(4)
If __DownloadToMem("Download", Address+ "top10.txt", @length.s, 4)>0
len.l =Val(length)+4
top10data.s = Space(len)
If __DownloadToMem("Download", Address+ "top10.txt", @top10data.s, len)>0
Result.s = Right(top10data, Len(top10data) - 5)
ProcedureReturn Left(Trim(Result), Len(Trim(Result))-1)
Else
ProcedureReturn "{ERROR}"
EndIf

Else
ProcedureReturn "{ERROR}"
EndIf

EndProcedure


Structure Top10
name.s
points.l
EndStructure

Global Dim Top10.Top10(10)
Global LastResult.s

ProcedureDLL.l ITop10_DownloadInternet(Address.s)
Result.s = __DownloadTop10Data(Address.s)
If Result = "{ERROR}"
ProcedureReturn #False
EndIf
Result+ ","
count.l = CountString(Result,",")

For i= 1 To count Step 2
name.s = StringField(Result,i,",")
points.l = Val(StringField(Result,i + 1,","))

If n < 10
Top10(n)\name = name
Top10(n)\points = points
EndIf
n+1

Next
ProcedureReturn #True
EndProcedure

ProcedureDLL.s ITop10_GetName(index)
If index >=0 And index <= 9
ProcedureReturn Top10(index)\name
EndIf
EndProcedure

ProcedureDLL.l ITop10_GetPoints(index)
If index >=0 And index <= 9
ProcedureReturn Top10(index)\points
EndIf
EndProcedure

ProcedureDLL.l ITop10_AddEntry(name.s,points.l)

name=ReplaceString(name,",","")
name=ReplaceString(name,";","")
name=ReplaceString(name,".","")
name=ReplaceString(name,"&","")
name=ReplaceString(name,"=","")
name=ReplaceString(name,"-","")
name=ReplaceString(name,"!","")
name=ReplaceString(name,"?","")
name=ReplaceString(name,Chr(34),"")
name=ReplaceString(name,"'","")
name=ReplaceString(name,"@","")

If Len(name)>20
name = Left(name,20)
EndIf

update=0
For i=0 To 9
If Top10(i)\points <= points:update=1:EndIf
Next
If update
Top10(10)\name= name
Top10(10)\points = points
SortStructuredArray(Top10(),1, 4, #PB_Sort_Long)
ProcedureReturn 1
EndIf
EndProcedure

;Address: http://www.test.de/top10/
;Key: DEIN_KEY
ProcedureDLL.l ITop10_UploadInternet(Address.s,Agent.s,Key.s)

out.s=""
For i=0 To 9
out.s+ Top10(i)\name+","+Str(Top10(i)\points)+","
Next
out=Left(out,Len(out)-1)


LastResult.s = Trim(__UploadTop10Data(Agent, Address.s,out,Key.s))

Result = #False

If LastResult = "DATA SUCCESSFULLY SAVED!"
Result = #True
EndIf

ProcedureReturn Result
EndProcedure

ProcedureDLL.s ITop10_UploadResult()
ProcedureReturn LastResult
EndProcedure

ProcedureDLL.l ITop10_Clear()
For t=0 To 9
Top10(t)\name="Noname"
Top10(t)\points = 0 
Next
EndProcedure



; IDE Options = PureBasic 4.31 (Windows - x86)
; CursorPosition = 166
; Folding = Aw
; EnableXP