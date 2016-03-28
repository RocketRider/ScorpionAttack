;Copyright (c) 2009 RocketRider
;This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held liable for any damages arising from the use of this software.
;Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:
;The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.
;Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
;This notice may not be removed or altered from any source distribution.
IncludeFile "zpac.pbi"
IncludeFile "Clipsprite.pbi"
IncludeFile "Objects.pbi"

Global ObjectButtonX = 5, ObjectButtonY = 5

Procedure CreateObjectButton(iObject.i, iCol.i=0, iLevel.i=0, sDescription.s="")
  Gadget=ButtonImageGadget(#PB_Any, ObjectButtonX, ObjectButtonY, 35, 35, ImageID(GrabObject(iObject)))
  SetGadgetData(Gadget, iObject)
  
  If sDescription
    GadgetToolTip(Gadget, sDescription) 
  EndIf
  
  SetProp_(GadgetID(Gadget), "Col", iCol)
  SetProp_(GadgetID(Gadget), "Level", iLevel)

  ObjectButtonX+34
  If ObjectButtonX>150:ObjectButtonX=5:ObjectButtonY+34:EndIf
EndProcedure



Structure GameMap
  iLevel.i
  iCollision.i
  iID.i
EndStructure

sFile.s=OpenFileRequester("Change Map",GetCurrentDirectory()+"maps\","*.map",0)
; If sFile=""
;   End
; EndIf
If FileSize(sFile)<0
  iMap_Width.i = Val(InputRequester("Width", "","25"))
  iMap_Height.i = Val(InputRequester("Height", "","19"))
  Dim Map.GameMap(iMap_Width, iMap_Height)
Else
  ZPAC_ReadPack(sFile)
  iMap_Width=PeekL(ZPAC_NextPackFile())
  iMap_Height=PeekL(ZPAC_NextPackFile())
  ptr=ZPAC_NextPackFile()
  Dim Map.GameMap(iMap_Width, iMap_Height)
  CopyMemory(ptr,Map(),SizeOf(GameMap)*(iMap_Width+1)*(iMap_Height+1))
  ZPAC_CloseReadPack()
EndIf




InitSprite()
InitSprite3D()
UsePNGImageDecoder()


OpenWindow(1,0,0,1000,600,"Scorpion Attack's Editor",#PB_Window_SystemMenu|#PB_Window_ScreenCentered)
OpenWindowedScreen(WindowID(1),0,0,800,600,0,0,0)
ScrollAreaGadget(1, 800,0,200,600,180,1000)
LoadImageObjects()
LoadObjects()


CreateObjectButton(#PIC_BLACK, 0, 0, "Empty")
CreateObjectButton(#PIC_SKORPION_L1, 0, 0, "Start position")
CreateObjectButton(#PIC_FINISH, 0, 0, "Finish position")
CreateObjectButton(#PIC_FINISH_2, 0, 0, "Finish position")
CreateObjectButton(#PIC_FLOR_GRAY_1, 1)
CreateObjectButton(#PIC_FLOR_GRAY_2, 1)
CreateObjectButton(#PIC_FLOR_GRAY_3, 1)
CreateObjectButton(#PIC_FLOR_GRAY_END, 1)
CreateObjectButton(#PIC_GRAS_1, 0, 1)
CreateObjectButton(#PIC_GRAS_2, 0, 1)
CreateObjectButton(#PIC_GRAS_3, 0, 1)
CreateObjectButton(#PIC_GRAS_4, 0, 1)
CreateObjectButton(#PIC_BLUME_1, 0, 1)
CreateObjectButton(#PIC_BLUME_2, 0, 0)
CreateObjectButton(#PIC_BLUME_3, 0, 1)
CreateObjectButton(#PIC_BLUME_4, 0, 0)
CreateObjectButton(#PIC_BLUME_5, 0, 0)
CreateObjectButton(#PIC_GROUND_GRAY_1, 1)
CreateObjectButton(#PIC_GROUND_GRAY_2, 1)
CreateObjectButton(#PIC_GROUND_GRAY_3, 1)
CreateObjectButton(#PIC_GROUND_GRAY_END, 1)
CreateObjectButton(#PIC_GROUND_GRAY_START, 1)
CreateObjectButton(#PIC_PALM_TOP_LEFT, 1)
CreateObjectButton(#PIC_PALM_TOP, 1)
CreateObjectButton(#PIC_PALM_TOP_RIGHT, 1)
CreateObjectButton(#PIC_PALM_STAM, 1)
CreateObjectButton(#PIC_PALM_STAM, 1)
CreateObjectButton(#PIC_PALM_LEFT, 1)
CreateObjectButton(#PIC_PALM_STAM_TOP, 1)
CreateObjectButton(#PIC_PALM_RIGHT, 1)
CreateObjectButton(#PIC_FLOR_BROWN_1, 1)
CreateObjectButton(#PIC_FLOR_BROWN_2, 1)
CreateObjectButton(#PIC_FLOR_BROWN_3, 1)
CreateObjectButton(#PIC_FLOR_BROWN_4, 1)
CreateObjectButton(#PIC_FLOR_BROWN_5, 1)
CreateObjectButton(#PIC_FLOR_BROWN_6, 1)
CreateObjectButton(#PIC_FLOR_BROWN_7, 1)
CreateObjectButton(#PIC_FLOR_BROWN_8, 1)
CreateObjectButton(#PIC_FLOR_BROWN_9, 1)
CreateObjectButton(#PIC_FLOR_BROWN_10, 1)
CreateObjectButton(#PIC_GROUND_BROWN_1, 1)
CreateObjectButton(#PIC_GROUND_BROWN_2, 1)
CreateObjectButton(#PIC_GROUND_BROWN_3, 1)
CreateObjectButton(#PIC_GROUND_BROWN_4, 1)
CreateObjectButton(#PIC_GROUND_BROWN_5, 1)
CreateObjectButton(#PIC_GROUND_BROWN_6, 1)

CreateObjectButton(#PIC_PRICK_1, 0, 1, "Prick")
CreateObjectButton(#PIC_PRICK_2, 0, 1, "Prick")
CreateObjectButton(#PIC_PRICK_3, 0, 1, "Prick")
CreateObjectButton(#PIC_BOMB, 0, 0, "Bomb")
CreateObjectButton(#PIC_ENERGY)
CreateObjectButton(#PIC_KEY)
CreateObjectButton(#PIC_GATE_1, 1, 0, "Gate")
CreateObjectButton(#PIC_GATE_2, 1, 0, "Gate")
CreateObjectButton(#PIC_DIAMOND_BLUE, 0, 0, "Diamond, needed to win")
CreateObjectButton(#PIC_DIAMOND_ORANGE, 0, 0, "Diamond, needed to win")
CreateObjectButton(#PIC_DIAMOND_RED, 0, 0, "Diamond, needed to win")


CreateObjectButton(#PIC_WOLK1_PART1, 1)
CreateObjectButton(#PIC_WOLK1_PART2, 1)
CreateObjectButton(#PIC_WOLK1_PART3, 1)
CreateObjectButton(#PIC_WOLK2_PART1, 1)
CreateObjectButton(#PIC_WOLK2_PART2, 1)
CreateObjectButton(#PIC_WOLK3_PART1, 1)
CreateObjectButton(#PIC_WOLK3_PART2, 1)
CreateObjectButton(#PIC_WOLK3_PART3, 1)

CreateObjectButton(#PIC_WALL, 1)

CreateObjectButton(#PIC_DANGER_1, 1)
CreateObjectButton(#PIC_DANGER_2, 1)
CreateObjectButton(#PIC_BONUS_1, 1)
CreateObjectButton(#PIC_BONUS_2, 1)
CreateObjectButton(#PIC_LEVEL_1, 1)
CreateObjectButton(#PIC_LEVEL_2, 1)

CreateObjectButton(#PIC_ENEMY_L1,0,0,"Walking Enemy")
CreateObjectButton(#PIC_ENEMY2_L1,0,0,"Walking Enemy")

CreateObjectButton(#PIC_TRANSPORT,0,0,"Flying Transporter")


iScrollX.i=0
iScrollY.i=0
Repeat
  Delay(0)
  Repeat
    Event = WindowEvent()
    If Event= #PB_Event_Gadget
      Gadget=EventGadget()
      Picture=GetGadgetData(Gadget)
    EndIf
    If Event = #PB_Event_CloseWindow:Quit=1:EndIf
  Until Event=0
  MouseX=WindowMouseX(1)
  MouseY=WindowMouseY(1)
  MouseBoxX=Int(MouseX/32)+iScrollX
  MouseBoxY=Int(MouseY/32)+iScrollY
  
  ButtonPressed=#False
  If GetAsyncKeyState_(#VK_RIGHT) And ButtonReleased=#True And iScrollX<iMap_Width-25:iScrollX+1:ButtonReleased=#False:ButtonPressed=#True:EndIf
  If GetAsyncKeyState_(#VK_LEFT) And ButtonReleased=#True And iScrollX>0:iScrollX-1:ButtonReleased=#False:ButtonPressed=#True:EndIf
  If GetAsyncKeyState_(#VK_UP) And ButtonReleased=#True And iScrollY>0:iScrollY-1:ButtonReleased=#False:ButtonPressed=#True:EndIf
  If GetAsyncKeyState_(#VK_DOWN) And ButtonReleased=#True And iScrollY<iMap_Height-19:iScrollY+1:ButtonReleased=#False:ButtonPressed=#True:EndIf
  If ButtonPressed=#False:ButtonReleased=#True:Else:ButtonReleased=#False:EndIf
  
  
  
  If GetAsyncKeyState_(#VK_LBUTTON) And Picture
    If MouseX>0 And MouseBoxX<iMap_Width And MouseX<800
      If MouseY>0 And MouseBoxY<iMap_Height And MouseY<600
        Map(MouseBoxX,MouseBoxY)\iID=Picture
        Map(MouseBoxX,MouseBoxY)\iCollision=GetProp_(GadgetID(Gadget), "Col")
        Map(MouseBoxX,MouseBoxY)\iLevel=GetProp_(GadgetID(Gadget), "Level")
        iMapChanged=#True
      EndIf
    EndIf
  EndIf
  
  If GetAsyncKeyState_(#VK_RBUTTON) And Picture
    If MouseX>0 And MouseBoxX<iMap_Width And MouseX<800
      If MouseY>0 And MouseBoxY<iMap_Height And MouseY<600
        Map(MouseBoxX,MouseBoxY)\iID=#PIC_BLACK
        Map(MouseBoxX,MouseBoxY)\iCollision=0
        Map(MouseBoxX,MouseBoxY)\iLevel=0
        iMapChanged=#True
      EndIf
    EndIf
  EndIf
  
  ClearScreen(0)
  
  Start3D()
  For x=0 To 24
    For y=0 To 18
      If Map(x+iScrollX, y+iScrollY)\iID
        DisplayObject(Map(x+iScrollX, y+iScrollY)\iID, x*32, y*32)
      EndIf
    Next
  Next
  Stop3D()
  
  StartDrawing(ScreenOutput())
  DrawingMode(#PB_2DDrawing_Outlined)
  Box(Int(MouseX/32)*32, Int(MouseY/32)*32, 32, 32 ,RGB(0,0,255))
  StopDrawing()
  FlipBuffers()
Until Quit=1

If iMapChanged
  If sFile And MessageRequester("Replace Map", "Do you want to replace the old map?",#PB_MessageRequester_YesNo)=#PB_MessageRequester_Yes
    iOverWrite=#True
  Else
    sFile.s=SaveFileRequester("Save Map",GetCurrentDirectory()+"maps\","*.map",0)
    If sFile And FindString(sFile, ".", 1)=0:sFile=sFile+".map":EndIf
    If sFile
      iOverWrite=#True
    EndIf
  EndIf
EndIf

If iOverWrite
  ZPAC_CreatePack(sFile)
  ZPAC_AddMemoryPack(@iMap_Width, 4)
  ZPAC_AddMemoryPack(@iMap_Height, 4)
  ZPAC_AddMemoryPack(@Map(), SizeOf(GameMap)*(iMap_Width+1)*(iMap_Height+1))
  ZPAC_CloseCreatePack()
EndIf
; IDE Options = PureBasic 4.31 (Windows - x86)
; CursorPosition = 201
; FirstLine = 165
; Folding = +
; EnableXP
; UseIcon = data\skorpion-ico.ico
; Executable = ScorpionAttack-Editor.exe
; SubSystem = DirectX 9
; EnableCompileCount = 79
; EnableBuildCount = 17
; EnableExeConstant
; IncludeVersionInfo
; VersionField0 = 1,0,0,0
; VersionField1 = 1,0,0,0
; VersionField2 = RRSoftware
; VersionField3 = Scorpion Attack Editor
; VersionField4 = 1.00
; VersionField5 = 1.00
; VersionField6 = Scorpion Attack Editor
; VersionField7 = Scorpion Attack
; VersionField8 = Scorpion Attack Editor
; VersionField9 = (c) 2009 RocketRider
; VersionField14 = http://www.RRSoftware.de