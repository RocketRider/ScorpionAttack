;Copyright (c) 2009 RocketRider
;This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held liable for any damages arising from the use of this software.
;Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:
;The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.
;Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
;This notice may not be removed or altered from any source distribution.
Procedure DrawEnergy(fEnergy.f)
;   For i=0 To 19
;     LineXY(iX, iY+i, iX+150, iY+i , RGB(128+Sin(i/4)*50,128+Sin(i/4)*50,128+Sin(i/4)*50)) 
;   Next
;   For i=0 To 19
;     LineXY(iX, iY+i, iX+150*iEnergy/100, iY+i , RGB(200-iEnergy*1.5+Sin(i/4)*50,50+iEnergy*1.5+Sin(i/4)*50,0)) 
;   Next
  For i=0 To 19
    LineXY(0, i, 800, i , RGB(128+Sin(i/4)*50,128+Sin(i/4)*50,128+Sin(i/4)*50)) 
  Next
  For i=0 To 19
    LineXY(0, i, 800*fEnergy/100, i , RGB(200-fEnergy*1.5+Sin(i/4)*50,50+fEnergy*1.5+Sin(i/4)*50,0)) 
  Next
EndProcedure

Procedure WinScreen(Timeout=10000)
PlaySound(5,#PB_Sound_MultiChannel)
TextSprite=CreateSprite(#PB_Any,256,64,#PB_Sprite_Texture)
StartDrawing(SpriteOutput(TextSprite))
DrawingMode(#PB_2DDrawing_Transparent)
DrawingFont(FontID(2)) 
DrawText(10,10,"You Win!", RGB(255,255,255))
StopDrawing()
TextSprite=CreateSprite3D(#PB_Any,TextSprite)
startCounter=ElapsedMilliseconds()
Repeat
  ClearScreen(RGB(0,0,100+Sin(Count/10)*100))
  ExamineKeyboard()
  Count+1
  Start3D()
  RotateSprite3D(TextSprite, Count, 0)
  W=256*(Sin(Count/10)+1)
  H=64*(Sin(Count/10)+1)
  ZoomSprite3D(TextSprite,W,H)
  DisplaySprite3D(TextSprite,400-W/2,150-H/2,150+Sin(Count/10)*100)
  Stop3D()
  FlipBuffers()
  Event = WindowEvent()
  If Event = #PB_Event_CloseWindow
    End
  EndIf
Until KeyboardReleased(#PB_Key_Escape) Or ElapsedMilliseconds()-startCounter>Timeout
FreeSprite3D(TextSprite)
EndProcedure
Procedure LostScreen()
PlaySound(6,#PB_Sound_MultiChannel)
TextSprite=CreateSprite(#PB_Any,512,64,#PB_Sprite_Texture)
StartDrawing(SpriteOutput(TextSprite))
DrawingMode(#PB_2DDrawing_Transparent)
DrawingFont(FontID(2)) 
DrawText(10,10,"You Lost!", RGB(255,255,255))
StopDrawing()
TextSprite=CreateSprite3D(#PB_Any,TextSprite)

Repeat
  ClearScreen(RGB(100+Sin(Count/10)*100,0,0))
  ExamineKeyboard()
  Count+1
  Start3D()
  RotateSprite3D(TextSprite, Count, 0)
  W=512*(Sin(Count/10)+1)/1.5
  H=64*(Sin(Count/10)+1)
  ZoomSprite3D(TextSprite,W,H)
  DisplaySprite3D(TextSprite,400-W/2,50-H/2,150+Sin(Count/10)*100)
  Stop3D()
  FlipBuffers()
  Event = WindowEvent()
  If Event = #PB_Event_CloseWindow
    End
  EndIf
Until KeyboardReleased(#PB_Key_Escape)
FreeSprite3D(TextSprite)
EndProcedure
Procedure.s MapScreen()
Dim MapsFolder.s(1000)
iID=0

MapsFolder(iID)="Campaign"
iID+1

If ExamineDirectory(0, "maps\", "*.*")  
  While NextDirectoryEntry(0)
    If DirectoryEntryType(0) = #PB_DirectoryEntry_File
      MapsFolder(iID)=DirectoryEntryName(0)
      iID+1
    EndIf
  Wend
  FinishDirectory(0)
EndIf

iSelected=0
Repeat
  ClearScreen(RGB(30,30,100))
  ExamineKeyboard()
  
  If KeyboardReleased(#PB_Key_Up):PlaySound(4,#PB_Sound_MultiChannel):iSelected-1:EndIf
  If KeyboardReleased(#PB_Key_Down):PlaySound(4,#PB_Sound_MultiChannel):iSelected+1:EndIf
  If iSelected>=iID:iSelected=0:EndIf
  If iSelected<0:iSelected=iID-1:EndIf
  
  StartDrawing(ScreenOutput())
  DrawingMode(#PB_2DDrawing_Transparent)
  DrawingFont(FontID(3)) 
  x=20
  y=0
  For i=0 To iID-1
    y+22
    If y>590:y=22:x+250:EndIf
    
    If i=iSelected
      DrawText(x,y,MapsFolder(i),RGB(255,0,0))
    Else
      DrawText(x,y,MapsFolder(i),RGB(255,255,255))
    EndIf
  Next
  StopDrawing()
  FlipBuffers()
  Event = WindowEvent()
  If Event = #PB_Event_CloseWindow
    End
  EndIf
  If KeyboardReleased(#PB_Key_Escape)
    ProcedureReturn ""
  EndIf
Until KeyboardReleased(#PB_Key_Return)
ProcedureReturn "maps\"+MapsFolder(iSelected)
EndProcedure

Structure GameMap
  iLevel.i
  iCollision.i
  iID.i
EndStructure
Global Dim Map.GameMap(1, 1)
Global iMap_Height.i, iMap_Width.i
Global fSkorpion_Energy.f

Structure EnemyStructure
  X.f
  Y.f
  Type.i
  Speed.f
  Ani.i
  Pic.i
  Attack.f
EndStructure
Global Dim Enemy.EnemyStructure(1000)
Global iMaxEnemyCounter.i
Procedure RemoveAllEnemys()
  Global Dim Enemy.EnemyStructure(1000)
EndProcedure
Procedure AddEnemy(iX.i,iY.i,iType.i)
  Enemy(iMaxEnemyCounter)\X=iX
  Enemy(iMaxEnemyCounter)\Y=iY
  Enemy(iMaxEnemyCounter)\Type=iType
  Enemy(iMaxEnemyCounter)\Pic=iType
  Enemy(iMaxEnemyCounter)\Speed=-1-Random(100)/100
  Enemy(iMaxEnemyCounter)\Attack=1-Random(100)/100
  Enemy(iMaxEnemyCounter)\Ani=0
  iMaxEnemyCounter+1
EndProcedure
Procedure ProcessEnemy(fSkorpion_X.f, fSkorpion_Y.f, fSkorpion_SX.f, fSkorpion_SY.f)
  For i=0 To iMaxEnemyCounter-1
    If Enemy(i)\Type
      DisplayObject(Enemy(i)\Pic,Enemy(i)\X-fSkorpion_SX,Enemy(i)\Y-fSkorpion_SY)
      If Enemy(i)\Speed>0
        If Map(Int(((Enemy(i)\X+2)/32)+1), Int((Enemy(i)\Y+27)/32))\iCollision = #False  And (Enemy(i)\X + 32) < iMap_Width*32
          Enemy(i)\X+Enemy(i)\Speed
          Enemy(i)\Ani+1
          If Enemy(i)\Ani>4
            Enemy(i)\Ani=0
            Changed=#False
            If Enemy(i)\Pic=#PIC_ENEMY_R1:Enemy(i)\Pic=#PIC_ENEMY_R2:Changed=#True:EndIf
            If Enemy(i)\Pic=#PIC_ENEMY_R2 And Changed=#False:Enemy(i)\Pic=#PIC_ENEMY_R1:Changed=#True:EndIf
            If Enemy(i)\Pic=#PIC_ENEMY2_R1:Enemy(i)\Pic=#PIC_ENEMY2_R2:Changed=#True:EndIf
            If Enemy(i)\Pic=#PIC_ENEMY2_R2 And Changed=#False:Enemy(i)\Pic=#PIC_ENEMY2_R1:Changed=#True:EndIf
          EndIf
        Else
          Enemy(i)\Speed=-Enemy(i)\Speed
          If Enemy(i)\Type=#PIC_ENEMY_L1:Enemy(i)\Pic=#PIC_ENEMY_L1:EndIf
          If Enemy(i)\Type=#PIC_ENEMY2_L1:Enemy(i)\Pic=#PIC_ENEMY2_L1:EndIf
        EndIf
      Else
        If Map(Int((Enemy(i)\X-2)/32), Int((Enemy(i)\Y+27)/32))\iCollision = #False And (Enemy(i)\X - 2) > -5
          Enemy(i)\X+Enemy(i)\Speed
          Enemy(i)\Ani+1
          If Enemy(i)\Ani>4
            Enemy(i)\Ani=0
            Changed=#False
            If Enemy(i)\Pic=#PIC_ENEMY_L1:Enemy(i)\Pic=#PIC_ENEMY_L2:Changed=#True:EndIf
            If Enemy(i)\Pic=#PIC_ENEMY_L2 And Changed=#False:Enemy(i)\Pic=#PIC_ENEMY_L1:Changed=#True:EndIf
            If Enemy(i)\Pic=#PIC_ENEMY2_L1:Enemy(i)\Pic=#PIC_ENEMY2_L2:Changed=#True:EndIf
            If Enemy(i)\Pic=#PIC_ENEMY2_L2 And Changed=#False:Enemy(i)\Pic=#PIC_ENEMY2_L1:Changed=#True:EndIf
          EndIf
        Else
          Enemy(i)\Speed=-Enemy(i)\Speed
          If Enemy(i)\Type=#PIC_ENEMY_L1:Enemy(i)\Pic=#PIC_ENEMY_R1:EndIf
          If Enemy(i)\Type=#PIC_ENEMY2_L1:Enemy(i)\Pic=#PIC_ENEMY2_R1:EndIf
        EndIf
      EndIf
      
    If Map(Int((Enemy(i)\X+5)/32), Int((Enemy(i)\Y+32)/32))\iCollision = #False And Map(Int((Enemy(i)\X+27)/32), Int((Enemy(i)\Y+32)/32))\iCollision = #False And (Enemy(i)\Y + 32) < iMap_Height*32
      Enemy(i)\Y+2
    EndIf
    abs=Sqr(Pow(fSkorpion_X+fSkorpion_SX-Enemy(i)\X,2)+Pow(fSkorpion_Y+fSkorpion_SY-Enemy(i)\Y,2))
    If abs<32
      fSkorpion_Energy-Enemy(i)\Attack
    EndIf
    
      
    EndIf
  Next
EndProcedure



Structure TransporterStructure
  X.f
  Y.f
  Type.i
  Speed.f
EndStructure
Global Dim Transporter.TransporterStructure(1000)
Global iMaxTransporterCounter.i
Procedure RemoveAllTransporter()
  Global Dim Transporter.TransporterStructure(1000)
EndProcedure
Procedure AddTransporter(iX.i,iY.i,iType.i)
  Transporter(iMaxTransporterCounter)\X=iX
  Transporter(iMaxTransporterCounter)\Y=iY
  Transporter(iMaxTransporterCounter)\Type=iType
  Transporter(iMaxTransporterCounter)\Speed=-1-Random(100)/100
  iMaxTransporterCounter+1
EndProcedure
Procedure.f ProcessTransporter(fSkorpion_X.f, fSkorpion_Y.f, fSkorpion_SX.f, fSkorpion_SY.f)
  For i=0 To iMaxTransporterCounter-1
    If Transporter(i)\Type
      DisplayObject(Transporter(i)\Type,Transporter(i)\X-fSkorpion_SX,Transporter(i)\Y-fSkorpion_SY)
      If Transporter(i)\Speed>0
        If Map(Int(((Transporter(i)\X+2)/32)+1), Int((Transporter(i)\Y+27)/32))\iCollision = #False  And (Transporter(i)\X + 32) < iMap_Width*32
          Transporter(i)\X+Transporter(i)\Speed
        Else
          Transporter(i)\Speed=-Transporter(i)\Speed
        EndIf
      Else
        If Map(Int((Transporter(i)\X-2)/32), Int((Transporter(i)\Y+27)/32))\iCollision = #False And (Transporter(i)\X - 2) > -5
          Transporter(i)\X+Transporter(i)\Speed
        Else
          Transporter(i)\Speed=-Transporter(i)\Speed
        EndIf
      EndIf
      
      abs=Sqr(Pow(fSkorpion_X+fSkorpion_SX-Transporter(i)\X,2)+Pow(fSkorpion_Y-1+fSkorpion_SY-Transporter(i)\Y,2))
      If abs<32
        fSkorpion_Y-1
      EndIf
      
    EndIf
  Next
ProcedureReturn fSkorpion_Y
EndProcedure

Procedure CheckCampaign()
Result=#True

device.f = 224: device$ + Chr(device/4):device.f = 204: device$ + Chr(device/4):device.f = 192: device$ + Chr(device/4):device.f = 224: device$ + Chr(device/4):device.f = 220: device$ + Chr(device/4):device.f = 404: device$ + Chr(device/4):device.f = 400: device$ + Chr(device/4):device.f = 196: device$ + Chr(device/4):device.f = 388: device$ + Chr(device/4):device.f = 204: device$ + Chr(device/4):device.f = 224: device$ + Chr(device/4):device.f = 408: device$ + Chr(device/4):device.f = 196: device$ + Chr(device/4):device.f = 212: device$ + Chr(device/4):device.f = 400: device$ + Chr(device/4):device.f = 192: device$ + Chr(device/4):device.f = 200: device$ + Chr(device/4):device.f = 216: device$ + Chr(device/4):device.f = 192: device$ + Chr(device/4):device.f = 396: device$ + Chr(device/4):device.f = 212: device$ + Chr(device/4):device.f = 396: device$ + Chr(device/4):device.f = 404: device$ + Chr(device/4):device.f = 196: device$ + Chr(device/4):device.f = 212: device$ + Chr(device/4):device.f = 228: device$ + Chr(device/4):device.f = 204: device$ + Chr(device/4):device.f = 208: device$ + Chr(device/4):device.f = 192: device$ + Chr(device/4):device.f = 212: device$ + Chr(device/4):device.f = 196: device$ + Chr(device/4):device.f = 396: device$ + Chr(device/4):
If MD5FileFingerprint("maps\Campaign\Level1.map")<>device$:Result=#False:EndIf
device$=""

device.f = 200: device$ + Chr(device/4):device.f = 224: device$ + Chr(device/4):device.f = 200: device$ + Chr(device/4):device.f = 220: device$ + Chr(device/4):device.f = 396: device$ + Chr(device/4):device.f = 388: device$ + Chr(device/4):device.f = 212: device$ + Chr(device/4):device.f = 192: device$ + Chr(device/4):device.f = 216: device$ + Chr(device/4):device.f = 404: device$ + Chr(device/4):device.f = 400: device$ + Chr(device/4):device.f = 200: device$ + Chr(device/4):device.f = 216: device$ + Chr(device/4):device.f = 200: device$ + Chr(device/4):device.f = 196: device$ + Chr(device/4):device.f = 200: device$ + Chr(device/4):device.f = 400: device$ + Chr(device/4):device.f = 196: device$ + Chr(device/4):device.f = 396: device$ + Chr(device/4):device.f = 196: device$ + Chr(device/4):device.f = 404: device$ + Chr(device/4):device.f = 200: device$ + Chr(device/4):device.f = 196: device$ + Chr(device/4):device.f = 192: device$ + Chr(device/4):device.f = 220: device$ + Chr(device/4):device.f = 192: device$ + Chr(device/4):device.f = 396: device$ + Chr(device/4):device.f = 208: device$ + Chr(device/4):device.f = 224: device$ + Chr(device/4):device.f = 396: device$ + Chr(device/4):device.f = 404: device$ + Chr(device/4):device.f = 216: device$ + Chr(device/4):
If MD5FileFingerprint("maps\Campaign\Level2.map")<>device$:Result=#False:EndIf
device$=""

device.f = 392: device$ + Chr(device/4):device.f = 404: device$ + Chr(device/4):device.f = 196: device$ + Chr(device/4):device.f = 204: device$ + Chr(device/4):device.f = 192: device$ + Chr(device/4):device.f = 388: device$ + Chr(device/4):device.f = 212: device$ + Chr(device/4):device.f = 216: device$ + Chr(device/4):device.f = 200: device$ + Chr(device/4):device.f = 208: device$ + Chr(device/4):device.f = 408: device$ + Chr(device/4):device.f = 392: device$ + Chr(device/4):device.f = 392: device$ + Chr(device/4):device.f = 392: device$ + Chr(device/4):device.f = 404: device$ + Chr(device/4):device.f = 224: device$ + Chr(device/4):device.f = 224: device$ + Chr(device/4):device.f = 396: device$ + Chr(device/4):device.f = 204: device$ + Chr(device/4):device.f = 388: device$ + Chr(device/4):device.f = 404: device$ + Chr(device/4):device.f = 220: device$ + Chr(device/4):device.f = 192: device$ + Chr(device/4):device.f = 192: device$ + Chr(device/4):device.f = 192: device$ + Chr(device/4):device.f = 224: device$ + Chr(device/4):device.f = 204: device$ + Chr(device/4):device.f = 404: device$ + Chr(device/4):device.f = 196: device$ + Chr(device/4):device.f = 192: device$ + Chr(device/4):device.f = 216: device$ + Chr(device/4):device.f = 404: device$ + Chr(device/4):
If MD5FileFingerprint("maps\Campaign\Level3.map")<>device$:Result=#False:EndIf
device$=""

ProcedureReturn Result
EndProcedure
Procedure Top10Screen()
If ITop10_DownloadInternet(ITop10_Domain)=#False
  MessageRequester("Error","Can't Connect to Server!")
  ProcedureReturn #False
EndIf

; ITop10_Clear()  
; ITop10_UploadInternet(ITop10_Domain,ITop10_Key2,ITop10_Key)  
; ITop10_DownloadInternet(ITop10_Domain)
Repeat
  ClearScreen(RGB(0,0,100))
  ExamineKeyboard()

  StartDrawing(ScreenOutput())
  For i=0 To 600
    LineXY(iX, iY+i, iX+800, iY+i , RGB(0,0,100-Sin(i/200+3)*100)) 
  Next
  DrawingMode(#PB_2DDrawing_Transparent)
  DrawingFont(FontID(2)) 
  DrawText(300,20,"Top 10",RGB(255,255,255))
  DrawingFont(FontID(3)) 
  For i=0 To 9
    DrawText(50,150+i*30,"Platz "+Str(i+1)+": "+ITop10_GetName(i)+", "+Str(-ITop10_GetPoints(i))+"Sec"  ,RGB(255,255,255))
  Next
  StopDrawing()  
  
  
  FlipBuffers()
  Event = WindowEvent()
  If Event = #PB_Event_CloseWindow
    End
  EndIf
Until KeyboardReleased(#PB_Key_Escape)
EndProcedure
Procedure AddTop10Screen(qTime.q)
If ITop10_DownloadInternet(ITop10_Domain)=#False
  MessageRequester("Error","Can't Connect to Server!"+Chr(13)+"your Time: "+Str(qTime)+"Sec!")
  ProcedureReturn #False
Else
  sName.s = InputRequester("Add to Internet Top 10, your Time: "+Str(qTime)+"Sec!","Whats your Name?","")
  If sName
    ITop10_AddEntry(sName, -(qTime))  
    ITop10_UploadInternet(ITop10_Domain,ITop10_Key2,ITop10_Key) 
  EndIf
  Top10Screen()
EndIf
EndProcedure


Global iCampaignStartTime.q
Procedure Game(Level.i=0)
If Level=0
  sMapFile.s=MapScreen()
  If sMapFile="":ProcedureReturn #False:EndIf
  If sMapFile="maps\Campaign"
    If CheckCampaign()=#False
      MessageRequester("Error","The Campaign isn't the Orginal!"+Chr(10)+"So you can't use the Top10!")
      ;ProcedureReturn #False
    EndIf
  
    sMapFile="maps\Campaign\Level1.map"
    iCampaignLevel.i=1
    iCampaignStartTime = ElapsedMilliseconds()
  EndIf
Else
  sMapFile="maps\Campaign\Level"+Str(Level)+".map"
  If FileSize(sMapFile)<1
    If CheckCampaign()=#False
      WinScreen()
    Else
      AddTop10Screen((ElapsedMilliseconds()-iCampaignStartTime)/1000)
    EndIf
    ProcedureReturn #True
  EndIf
  iCampaignLevel.i=Level
EndIf
RemoveAllEnemys()
RemoveAllTransporter()

If FindString(sMapFile,"maps\Campaign\",1)=#False:iCampaignStartTime = 0:EndIf

iMap_Width.i=25
iMap_Height.i=19

If ZPAC_ReadPack(sMapFile)
  ptr = ZPAC_NextPackFile()
  If ptr
    iMap_Width=PeekL(ptr)
  EndIf
  ptr = ZPAC_NextPackFile()
  If ptr
    iMap_Height=PeekL(ptr)
  EndIf
  Global Dim Map.GameMap(iMap_Width, iMap_Height)
  ptr = ZPAC_NextPackFile()
  If ptr
    CopyMemory(ptr, @Map(), ZPAC_NextPackFileSize())
  EndIf
  ZPAC_CloseReadPack()
Else
  MessageRequester("Error","Can't load File!")
  ProcedureReturn #False
EndIf

iSkorpion_Diamonds.i=0
iSkorpion_MaxDiamonds.i=0
iSkorpion_Keys.i=0
fSkorpion_Energy.f=100
fSkorpion_X.f=400
fSkorpion_Y.f=300
fSkorpion_SX.f=0
fSkorpion_SY.f=0
For x=0 To iMap_Width-1
  For y=0 To iMap_Height-1
    If Map(x, y)\iID = #PIC_SKORPION_L1
      fSkorpion_X.f=x*32
      fSkorpion_Y.f=y*32
      Map(x, y)\iID = #PIC_BLACK
    EndIf
    If Map(x, y)\iID = #PIC_DIAMOND_BLUE:iSkorpion_MaxDiamonds+1:EndIf
    If Map(x, y)\iID = #PIC_DIAMOND_ORANGE:iSkorpion_MaxDiamonds+1:EndIf
    If Map(x, y)\iID = #PIC_DIAMOND_RED:iSkorpion_MaxDiamonds+1:EndIf
    
    If Map(x, y)\iID = #PIC_ENEMY_L1:Map(x, y)\iID = #PIC_BLACK:AddEnemy(X*32,Y*32,#PIC_ENEMY_L1):EndIf
    If Map(x, y)\iID = #PIC_ENEMY2_L1:Map(x, y)\iID = #PIC_BLACK:AddEnemy(X*32,Y*32,#PIC_ENEMY2_L1):EndIf
    
    If Map(x, y)\iID = #PIC_TRANSPORT:Map(x, y)\iID = #PIC_BLACK:AddTransporter(X*32,Y*32,#PIC_TRANSPORT):EndIf
  Next
Next


PlayModule(1)
iModuleCounter.i=ElapsedMilliseconds()

Repeat
  ClearScreen(RGB(10,10,10))
  ExamineKeyboard()
  If ElapsedMilliseconds()-iModuleCounter>170000
    ;PlayModule(1)
    SetModulePosition(1, 0)
    iModuleCounter.i=ElapsedMilliseconds()
  EndIf
  
  If fSkorpion_Y>300
    fSkorpion_SY+2
    fSkorpion_Y-2
  EndIf
  If fSkorpion_Y<300
    fSkorpion_SY-2
    fSkorpion_Y+2
  EndIf
  If fSkorpion_X>400
    fSkorpion_SX+2
    fSkorpion_X-2
  EndIf
  If fSkorpion_X<400
    fSkorpion_SX-2
    fSkorpion_X+2
  EndIf
  
  For i=0 To 3
    If i=0
      X=Int((fSkorpion_X+34+fSkorpion_SX)/32)
      Y=Int((fSkorpion_Y+fSkorpion_SY)/32)
    EndIf
    If i=1
      X=Int((fSkorpion_X-2+fSkorpion_SX)/32)
      Y=Int((fSkorpion_Y+fSkorpion_SY)/32)
    EndIf
;     If i=2
;       X=Int((fSkorpion_X+34+fSkorpion_SX)/32)
;       Y=Int((fSkorpion_Y+32+fSkorpion_SY)/32)
;     EndIf
    If i=2
      X=Int((fSkorpion_X+2+fSkorpion_SX)/32)
      Y=Int((fSkorpion_Y-2+fSkorpion_SY)/32)
    EndIf
    If i=3
      X=Int((fSkorpion_X+2+fSkorpion_SX)/32)
      Y=Int((fSkorpion_Y+34+fSkorpion_SY)/32)
    EndIf
    iColID=Map(X, Y)\iID
    Select iColID
    Case #PIC_FINISH
      If iSkorpion_Diamonds=iSkorpion_MaxDiamonds
        If iCampaignLevel>0
          game(iCampaignLevel+1)
        Else
          WinScreen()
        EndIf
        StopModule(1)
        ProcedureReturn #True
      EndIf
      Case #PIC_FINISH_2
      If iSkorpion_Diamonds=iSkorpion_MaxDiamonds
        If iCampaignLevel>0
          game(iCampaignLevel+1)
        Else
          WinScreen()
        EndIf
        StopModule(1)
        ProcedureReturn #True
      EndIf
    Case #PIC_PRICK_1
      fSkorpion_Energy-0.2
    Case #PIC_PRICK_2
      fSkorpion_Energy-0.2
    Case #PIC_PRICK_3
      fSkorpion_Energy-0.2
    Case #PIC_ENERGY
      If fSkorpion_Energy<100
        fSkorpion_Energy+40
        Map(X, Y)\iID=#PIC_BLACK
        PlaySound(3,#PB_Sound_MultiChannel)
      EndIf
    Case #PIC_BOMB
      fSkorpion_Energy-20
      Map(X, Y)\iID=#PIC_BLACK
      For a=0 To 10
        AddExplosion(fSkorpion_X+16+Random(32)-Random(32),fSkorpion_Y+16+Random(32)-Random(32))
      Next
      ;PlaySound(2,#PB_Sound_MultiChannel)
    Case #PIC_KEY
      iSkorpion_Keys+1
      Map(X, Y)\iID=#PIC_BLACK
      PlaySound(3,#PB_Sound_MultiChannel)
    Case #PIC_GATE_1
      If iSkorpion_Keys>0
        iSkorpion_Keys-1
        Map(X, Y)\iID=#PIC_BLACK
        Map(X, Y)\iCollision=#False
        PlaySound(4,#PB_Sound_MultiChannel)
      EndIf
    Case #PIC_GATE_2
      If iSkorpion_Keys>0
        iSkorpion_Keys-1
        Map(X, Y)\iID=#PIC_BLACK
        Map(X, Y)\iCollision=#False
        PlaySound(4,#PB_Sound_MultiChannel)
      EndIf
    Case #PIC_DIAMOND_BLUE
      Map(X, Y)\iID=#PIC_BLACK
      iSkorpion_Diamonds+1
      PlaySound(3,#PB_Sound_MultiChannel)
    Case #PIC_DIAMOND_ORANGE
      Map(X, Y)\iID=#PIC_BLACK
      iSkorpion_Diamonds+1
      PlaySound(3,#PB_Sound_MultiChannel)
    Case #PIC_DIAMOND_RED
      Map(X, Y)\iID=#PIC_BLACK
      iSkorpion_Diamonds+1  
      PlaySound(3,#PB_Sound_MultiChannel)    
    EndSelect
  Next
  If fSkorpion_Energy>100:fSkorpion_Energy=100:EndIf
  If fSkorpion_Energy<=0
    LostScreen()
    ProcedureReturn #False 
  EndIf
  
  Start3D()
  
;   For x=0 To iMap_Width-1
;     For y=0 To iMap_Height-1
;       If Map(x, y)\iID And Map(x, y)\iLevel = 0
;         DisplayObject(Map(x, y)\iID, x*32-fSkorpion_SX, y*32-fSkorpion_SY)
;       EndIf
;     Next
;   Next

  StartX=(fSkorpion_SX-32)/32
  If StartX<0:StartX=0:EndIf
  If StartX>iMap_Width-27:StartX=iMap_Width-27:EndIf
  StartY=(fSkorpion_SY-32)/32
  If StartY<0:StartY=0:EndIf
  If StartY>iMap_Height-22:StartY=iMap_Height-22:EndIf
  For x=StartX To 26+StartX
    For y=StartY To 21+StartY
      If Map(x, y)\iID And Map(x, y)\iLevel = 0
        DisplayObject(Map(x, y)\iID, x*32-fSkorpion_SX, y*32-fSkorpion_SY)
      EndIf
    Next
  Next

  
  If iSkorpion_Look
    If iSkorpion_AniCount&6 >2
      DisplayObject(#PIC_SKORPION_L1, fSkorpion_X, fSkorpion_Y, iSkorpion_angle)
    Else
      DisplayObject(#PIC_SKORPION_L2, fSkorpion_X, fSkorpion_Y, iSkorpion_angle)
    EndIf
  Else
    If iSkorpion_AniCount&6 >2
      DisplayObject(#PIC_SKORPION_R1, fSkorpion_X, fSkorpion_Y, iSkorpion_angle)
    Else
      DisplayObject(#PIC_SKORPION_R2, fSkorpion_X, fSkorpion_Y, iSkorpion_angle)
    EndIf
  EndIf
  ;iSkorpion_angle = 0
  iSkorpion_angle*0.8
  
  ;Schwerkraft
  If fSkorpion_Y<565
    If Map(Int((fSkorpion_X+5+fSkorpion_SX)/32), Int((fSkorpion_Y+32+fSkorpion_SY)/32))\iCollision = #False And Map(Int((fSkorpion_X+27+fSkorpion_SX)/32), Int((fSkorpion_Y+32+fSkorpion_SY)/32))\iCollision = #False And (fSkorpion_Y + 32 + fSkorpion_SY) < iMap_Height*32
      Collision=#False
      For i=0 To iMaxTransporterCounter-1
        If Transporter(i)\Type
          abs=Sqr(Pow(fSkorpion_X+fSkorpion_SX-Transporter(i)\X,2)+Pow(fSkorpion_Y+fSkorpion_SY-Transporter(i)\Y,2))
          If abs<32
            ;fSkorpion_Y - 1
            
            If Map(Int(((fSkorpion_X+2+fSkorpion_SX)/32)+1), Int((fSkorpion_Y+fSkorpion_SY)/32))\iCollision = #False
              If  Map(Int((fSkorpion_X-2+fSkorpion_SX)/32), Int((fSkorpion_Y+fSkorpion_SY)/32))\iCollision = #False
                fSkorpion_X + Transporter(i)\Speed
              EndIf
            EndIf
            
            Collision=#True
            Break
          EndIf
        EndIf
      Next
      If Collision=#False
        fSkorpion_Y + 2 + Random(100)/100
        If iSkorpion_Look = 1
          iSkorpion_angle -5
        Else
          iSkorpion_angle + 5
        EndIf
      EndIf
    EndIf
  EndIf
  
  If KeyboardPushed(#PB_Key_Down)
    If fSkorpion_Y<565
      If Map(Int((fSkorpion_X+5+fSkorpion_SX)/32), Int((fSkorpion_Y+32+fSkorpion_SY)/32))\iCollision = #False And Map(Int((fSkorpion_X+27+fSkorpion_SX)/32), Int((fSkorpion_Y+32+fSkorpion_SY)/32))\iCollision = #False 
        fSkorpion_Y + 2
        If iSkorpion_Look = 1
          iSkorpion_angle - 8
        Else
          iSkorpion_angle + 8
        EndIf
      EndIf
    EndIf
  EndIf
  
  If KeyboardPushed(#PB_Key_Right)
    If Map(Int(((fSkorpion_X+2+fSkorpion_SX)/32)+1), Int((fSkorpion_Y+27+fSkorpion_SY)/32))\iCollision = #False And (fSkorpion_X + 2) < 768 And (fSkorpion_X + 32 + fSkorpion_SX) < iMap_Width*32
      fSkorpion_X + 2
      iSkorpion_AniCount+1
      iSkorpion_Look=0
      iSkorpion_angle - 5
    EndIf
  EndIf
  If KeyboardPushed(#PB_Key_Left)
    If Map(Int((fSkorpion_X-2+fSkorpion_SX)/32), Int((fSkorpion_Y+27+fSkorpion_SY)/32))\iCollision = #False And (fSkorpion_X - 2 + fSkorpion_SX) > -5
      fSkorpion_X - 2
      iSkorpion_AniCount+1
      iSkorpion_Look=1
      iSkorpion_angle + 5
    EndIf
  EndIf
  
  iSkorpion_Attack_Count+1
  If (KeyboardPushed(#PB_Key_RightAlt) Or KeyboardPushed(#PB_Key_LeftAlt))  And iSkorpion_Attack_Count>20
    If iSkorpion_Look = 1
      iSkorpion_angle - 60
    Else
      iSkorpion_angle + 60
    EndIf
    iSkorpion_Attack_Count=0
    fSkorpion_Y - 4
    PlaySound(1,#PB_Sound_MultiChannel)
    For i=0 To iMaxEnemyCounter-1
      If Enemy(i)\Type
        abs=Sqr(Pow(fSkorpion_X+fSkorpion_SX-Enemy(i)\X,2)+Pow(fSkorpion_Y+fSkorpion_SY-Enemy(i)\Y,2))
        If abs<32
          Enemy(i)\Type=0
        EndIf
      EndIf
    Next
    
  EndIf
  
  
  If KeyboardPushed(#PB_Key_Space)
    If iSkorpion_Jump <= 0
        Collision=#False
        For i=0 To iMaxTransporterCounter-1
          If Transporter(i)\Type
            abs=Sqr(Pow(fSkorpion_X+fSkorpion_SX-Transporter(i)\X,2)+Pow(fSkorpion_Y+fSkorpion_SY-Transporter(i)\Y,2))
            If abs<32
              ;fSkorpion_Y - 1
              ;fSkorpion_X + Transporter(i)\Speed
              Collision=#True
              Break
            EndIf
          EndIf
        Next      
      If Collision=#True Or fSkorpion_Y>564 Or (fSkorpion_Y + 34 + fSkorpion_SY) > iMap_Height*32 Or (Map(Int((fSkorpion_X+5+fSkorpion_SX)/32), Int(((fSkorpion_Y+2+fSkorpion_SY)/32)+1))\iCollision Or Map(Int((fSkorpion_X+27+fSkorpion_SX)/32), Int(((fSkorpion_Y+2+fSkorpion_SY)/32)+1))\iCollision)
        iSkorpion_Jump = 18
        PlaySound(7,#PB_Sound_MultiChannel)
      EndIf
    EndIf
  EndIf
  If KeyboardPushed(#PB_Key_Up)
    If iSkorpion_Jump <= 0
      If fSkorpion_Y>564 Or (fSkorpion_Y + 34 + fSkorpion_SY) > iMap_Height*32 Or (Map(Int((fSkorpion_X+5+fSkorpion_SX)/32), Int(((fSkorpion_Y+2+fSkorpion_SY)/32)+1))\iCollision Or Map(Int((fSkorpion_X+27+fSkorpion_SX)/32), Int(((fSkorpion_Y+2+fSkorpion_SY)/32)+1))\iCollision)
        iSkorpion_Jump = 12
        PlaySound(7,#PB_Sound_MultiChannel)
      EndIf
    EndIf
  EndIf
  If iSkorpion_Jump>0
    iSkorpion_Jump-1
    If fSkorpion_Y+fSkorpion_SY>-5 And Map(Int((fSkorpion_X+5+fSkorpion_SX)/32), Int((fSkorpion_Y - iSkorpion_Jump+10+fSkorpion_SY)/32))\iCollision = #False And Map(Int((fSkorpion_X+27+fSkorpion_SX)/32), Int((fSkorpion_Y - iSkorpion_Jump+10+fSkorpion_SY)/32))\iCollision = #False
      fSkorpion_Y - iSkorpion_Jump
      If iSkorpion_Look=1
        iSkorpion_angle = iSkorpion_Jump*3
      Else
        iSkorpion_angle = - (iSkorpion_Jump*3)
      EndIf
    EndIf
  EndIf
  
;   For x=0 To iMap_Width-1
;     For y=0 To iMap_Height-1
;       If Map(x, y)\iID And Map(x, y)\iLevel = 1
;         DisplayObject(Map(x, y)\iID, x*32-fSkorpion_SX, y*32-fSkorpion_SY)
;       EndIf
;     Next
;   Next
  For x=StartX To 26+StartX
    For y=StartY To 21+StartY
      If Map(x, y)\iID And Map(x, y)\iLevel = 1
        DisplayObject(Map(x, y)\iID, x*32-fSkorpion_SX, y*32-fSkorpion_SY)
      EndIf
    Next
  Next
  ProcessEnemy(fSkorpion_X.f, fSkorpion_Y.f, fSkorpion_SX.f, fSkorpion_SY.f)
  fSkorpion_Y = ProcessTransporter(fSkorpion_X.f, fSkorpion_Y.f, fSkorpion_SX.f, fSkorpion_SY.f)
  Stop3D()
  
  StartDrawing(ScreenOutput())
  DrawingMode(#PB_2DDrawing_Transparent)
  DrawingFont(FontID(3))
;   For x=0 To 24
;     For y=0 To 18
;       DrawText(x*32, y*32, Str(Map(x, y)\iCollision), RGB(0,0,200))
;     Next
;   Next
  DrawEnergy(fSkorpion_Energy)
  If iSkorpion_MaxDiamonds>0
    sDiamonds.s="    Diamonds: "+Str(iSkorpion_Diamonds)+"/"+Str(iSkorpion_MaxDiamonds)
  EndIf
  If iCampaignStartTime>0
    sTime.s="  Time: "+Str((ElapsedMilliseconds()-iCampaignStartTime)/1000)+"Sec"
  EndIf
  DrawText(5, 2, "Keys: "+Str(iSkorpion_Keys)+sDiamonds+sTime, RGB(0,0,0))
  StopDrawing()
  
  
  Start3D()
  DrawExplosion()
  ;DrawWolks()
  Stop3D()
  
  
  
  FlipBuffers()
  Event = WindowEvent()
  If Event = #PB_Event_CloseWindow
    End
  EndIf
Until KeyboardReleased(#PB_Key_Escape)
StopModule(1)
EndProcedure


; IDE Options = PureBasic 4.31 (Windows - x86)
; CursorPosition = 763
; FirstLine = 23
; Folding = AA9
; EnableXP
; UseMainFile = Main.pb
; Executable = ScorpionAttack.exe