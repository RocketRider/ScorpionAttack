;Copyright (c) 2009 RocketRider
;This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held liable for any damages arising from the use of this software.
;Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:
;The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.
;Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
;This notice may not be removed or altered from any source distribution.
Declare DrawExplosion()
Declare DrawWolks()
Declare AddExplosion(iX.i, iY.i)

Global ITop10_Domain.s="http://www.test.de"
Global ITop10_KEY2.s=""
Global ITop10_Key.s=""


IncludeFile "zpac.pbi"
IncludeFile "Clipsprite.pbi"
IncludeFile "ITop10.pbi"
IncludeFile "Objects.pbi"
IncludeFile "Game.pbi"





Structure Explosion
  iX.i
  iY.i
  iCount.i
  iAngle.i
  iZoomX.i
  iZoomY.i
EndStructure
Global Dim Explosion.Explosion(100)
Global iExplosionCount.i
Procedure AddExplosion(iX.i, iY.i)
PlaySound(2,#PB_Sound_MultiChannel)
  For i=0 To 99
    If Explosion(i)\iCount = 0
      Explosion(i)\iCount=1
      Explosion(i)\iX=iX
      Explosion(i)\iY=iY
      Explosion(i)\iAngle=Random(360)
      Explosion(i)\iZoomX=30+Random(30)
      Explosion(i)\iZoomY=30+Random(30)
      ProcedureReturn #True
    EndIf
  Next
EndProcedure
Procedure DrawExplosion()
  For i=0 To 99
    If Explosion(i)\iCount>0
      If Explosion(i)\iCount=1
        DisplayObject(#PIC_EXPL_7, Explosion(i)\iX-Explosion(i)\iZoomX/2, Explosion(i)\iY-Explosion(i)\iZoomY/2, Explosion(i)\iAngle, 255, Explosion(i)\iZoomX, Explosion(i)\iZoomY)
      EndIf
      If Explosion(i)\iCount=2
        DisplayObject(#PIC_EXPL_6, Explosion(i)\iX-Explosion(i)\iZoomX/2, Explosion(i)\iY-Explosion(i)\iZoomY/2, Explosion(i)\iAngle, 255, Explosion(i)\iZoomX, Explosion(i)\iZoomY)
      EndIf
      If Explosion(i)\iCount=3
        DisplayObject(#PIC_EXPL_5, Explosion(i)\iX-Explosion(i)\iZoomX/2, Explosion(i)\iY-Explosion(i)\iZoomY/2, Explosion(i)\iAngle, 255, Explosion(i)\iZoomX, Explosion(i)\iZoomY)
      EndIf
      If Explosion(i)\iCount=4
        DisplayObject(#PIC_EXPL_4, Explosion(i)\iX-Explosion(i)\iZoomX/2, Explosion(i)\iY-Explosion(i)\iZoomY/2, Explosion(i)\iAngle, 255, Explosion(i)\iZoomX, Explosion(i)\iZoomY)
      EndIf
      If Explosion(i)\iCount=5
        DisplayObject(#PIC_EXPL_3, Explosion(i)\iX-Explosion(i)\iZoomX/2, Explosion(i)\iY-Explosion(i)\iZoomY/2, Explosion(i)\iAngle, 255, Explosion(i)\iZoomX, Explosion(i)\iZoomY)
      EndIf
      If Explosion(i)\iCount=6
        DisplayObject(#PIC_EXPL_2, Explosion(i)\iX-Explosion(i)\iZoomX/2, Explosion(i)\iY-Explosion(i)\iZoomY/2, Explosion(i)\iAngle, 255, Explosion(i)\iZoomX, Explosion(i)\iZoomY)
      EndIf
      If Explosion(i)\iCount=7
        DisplayObject(#PIC_EXPL_1, Explosion(i)\iX-Explosion(i)\iZoomX/2, Explosion(i)\iY-Explosion(i)\iZoomY/2, Explosion(i)\iAngle, 255, Explosion(i)\iZoomX, Explosion(i)\iZoomY)
      EndIf
      If Explosion(i)\iCount>7
        DisplayObject(#PIC_EXPL_1, Explosion(i)\iX-Explosion(i)\iZoomX/2, Explosion(i)\iY-Explosion(i)\iZoomY/2, Explosion(i)\iAngle, 255-Explosion(i)\iCount*10, Explosion(i)\iZoomX, Explosion(i)\iZoomY)
      EndIf  
      If Random(1)
      Explosion(i)\iCount+1
      Explosion(i)\iAngle+Random(1)-Random(1)
      Explosion(i)\iZoomX+Random(1)
      Explosion(i)\iZoomY+Random(1)
      EndIf
      If Explosion(i)\iCount>23
        Explosion(i)\iCount = 0
      EndIf
    EndIf
  Next
EndProcedure
Procedure RemoveAllExplosion()
  For i=0 To 99
    Explosion(i)\iCount=0
  Next
EndProcedure

Structure Wolk
  fX.f
  fY.f
  fSpeed.f
  iZoomX.i
  iZoomY.i
  iType.i
  iTransparece.i
EndStructure
Global Dim Wolks.Wolk(100)
Procedure DrawWolks()
  For i=0 To 99
    If Wolks(i)\fSpeed
      If Wolks(i)\iType=0
        DisplayObject(#PIC_WOLK1_PART1, Wolks(i)\fX, Wolks(i)\fY, 0, Wolks(i)\iTransparece, Wolks(i)\iZoomX, Wolks(i)\iZoomY)
        DisplayObject(#PIC_WOLK1_PART2, Wolks(i)\fX+Wolks(i)\iZoomX, Wolks(i)\fY, 0, Wolks(i)\iTransparece, Wolks(i)\iZoomX, Wolks(i)\iZoomY)
        DisplayObject(#PIC_WOLK1_PART3, Wolks(i)\fX+Wolks(i)\iZoomX*2, Wolks(i)\fY, 0, Wolks(i)\iTransparece, Wolks(i)\iZoomX, Wolks(i)\iZoomY)
      EndIf
      If Wolks(i)\iType=1
        DisplayObject(#PIC_WOLK2_PART1, Wolks(i)\fX, Wolks(i)\fY, 0, Wolks(i)\iTransparece, Wolks(i)\iZoomX, Wolks(i)\iZoomY)
        DisplayObject(#PIC_WOLK2_PART2, Wolks(i)\fX+Wolks(i)\iZoomX, Wolks(i)\fY, 0, Wolks(i)\iTransparece, Wolks(i)\iZoomX, Wolks(i)\iZoomY)
      EndIf
      If Wolks(i)\iType=2
        DisplayObject(#PIC_WOLK3_PART1, Wolks(i)\fX, Wolks(i)\fY, 0, Wolks(i)\iTransparece, Wolks(i)\iZoomX, Wolks(i)\iZoomY)
        DisplayObject(#PIC_WOLK3_PART2, Wolks(i)\fX+Wolks(i)\iZoomX, Wolks(i)\fY, 0, Wolks(i)\iTransparece, Wolks(i)\iZoomX, Wolks(i)\iZoomY)
        DisplayObject(#PIC_WOLK3_PART3, Wolks(i)\fX+Wolks(i)\iZoomX*2, Wolks(i)\fY, 0, Wolks(i)\iTransparece, Wolks(i)\iZoomX, Wolks(i)\iZoomY)
      EndIf
      
      Wolks(i)\fX + Wolks(i)\fSpeed
      
      If Wolks(i)\fSpeed>0
        If Wolks(i)\fX > 800
          Wolks(i)\fX=-200-Random(100)
          iZoom=32+Random(20)
          Wolks(i)\iZoomX=iZoom
          Wolks(i)\iZoomY=iZoom
          Wolks(i)\iType=Random(2)
          Wolks(i)\iTransparece=100+Random(155)
        EndIf
      Else
        If Wolks(i)\fX <-200
          Wolks(i)\fX = 800+Random(100)
          iZoom=32+Random(20)
          Wolks(i)\iZoomX=iZoom
          Wolks(i)\iZoomY=iZoom
          Wolks(i)\iType=Random(2)
          Wolks(i)\iTransparece=100+Random(155)
        EndIf
      EndIf
      
    EndIf
  Next
EndProcedure
Procedure AddWolk(iX, iY, fSpeed.f)
  For i=0 To 99
    If Wolks(i)\fSpeed = #False
      Wolks(i)\fSpeed = fSpeed
      Wolks(i)\fX = iX
      Wolks(i)\fY = iY
      iZoom=32+Random(20)
      Wolks(i)\iZoomX=iZoom
      Wolks(i)\iZoomY=iZoom
      Wolks(i)\iType=Random(2)
      Wolks(i)\iTransparece=100+Random(155)
      
      ProcedureReturn #True
    EndIf
  Next
EndProcedure



Procedure.s CreditsScreen()
Text.s="***Development***|RocketRider|***GFX***|Ari Feldman|Kaeru Gaman|RocketRider|Hroudtwolf|***Font***|Kaeru Gaman||Special Thanks to the PB-Lounge Team|For This perfekt Contest||Created by RRSoftware.de|"

PlayModule(2)
Repeat
  ClearScreen(RGB(30,30,100))
  StartDrawing(ScreenOutput())
  For i=0 To 600
    LineXY(iX, iY+i, iX+800, iY+i , RGB(0,0,100-Sin(i/100+2)*100)) 
  Next
  StopDrawing()
  ExamineKeyboard()
  
  
  StartDrawing(ScreenOutput())
  DrawingMode(#PB_2DDrawing_Transparent)
  DrawingFont(FontID(2)) 
  yCount+1
  y=600-yCount
  DrawText(400-TextWidth("Credits")/2 ,y+20,"Credits",RGB(255,255,255))
  DrawingFont(FontID(1)) 
  y+60
  For i=1 To CountString(Text,"|")
    If FindString(StringField(Text,i,"|"),"*",1)
      DrawText(400-TextWidth(StringField(Text,i,"|"))/2 ,y+20,StringField(Text,i,"|"),RGB(100-Sin(y/100+2)*100,100-Sin(y/100+2)*100,100-Sin(y/100+2)*100))
    Else
      DrawText(400-TextWidth(StringField(Text,i,"|"))/2 ,y+20,StringField(Text,i,"|"),RGB(0,0,0))
    EndIf
    y+40
  Next

  StopDrawing()
  FlipBuffers()
  Event = WindowEvent()
  If Event = #PB_Event_CloseWindow
    End
  EndIf
Until KeyboardReleased(#PB_Key_Escape) Or yCount>1200
StopModule(2)
EndProcedure





InitSound()
InitSprite()
InitSprite3D()
InitKeyboard()
ZPAC_Init()
UsePNGImageDecoder()
;Sprite3DQuality(#PB_Sprite3D_BilinearFiltering)
OpenWindow(1,0,0,800,600,"Scorpion Attack",#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget)
OpenWindowedScreen(WindowID(1),0,0,800,600,1,0,0)

Lib=OpenLibrary(#PB_Any,"Gdi32.dll")
Add=GetFunction(Lib,"AddFontResourceExA")
CallFunctionFast(Add, "data\warlord_big.ttf", 16, 0)
CloseLibrary(Lib)

;AddFontResource_("data\warlord_big.ttf")
LoadFont(1, "warlord big", 25, #PB_Font_HighQuality);|#PB_Font_Bold)
LoadFont(2, "warlord big", 40, #PB_Font_HighQuality);|#PB_Font_Bold)
LoadFont(3, "warlord big", 14, #PB_Font_HighQuality)

LoadModule(1,"data\amigamus.mod")
LoadModule(2,"data\techno-for-you.mod")
LoadSound(1,"data\born.wav")
LoadSound(2,"data\explosion.wav")
LoadSound(3,"data\eat.wav")
LoadSound(4,"data\set.wav")
LoadSound(5,"data\won.wav")
LoadSound(6,"data\timeover.wav")
LoadSound(7,"data\delete.wav")

Structure Map
  iLevel.i
  iCollision.i
  iID.i
EndStructure

Dim MenuBK_Map.Map(25, 19)
For i=0 To 24
  Select Random(2)
  Case 0
    MenuBK_Map(i,17)\iID = #PIC_GROUND_GRAY_1
  Case 1
    MenuBK_Map(i,17)\iID = #PIC_GROUND_GRAY_2
  Case 2
    MenuBK_Map(i,17)\iID = #PIC_GROUND_GRAY_3
  EndSelect
  MenuBK_Map(i,17)\iCollision = #True
Next
For i=0 To 24
  Select Random(2)
  Case 0
    MenuBK_Map(i,18)\iID = #PIC_FLOR_GRAY_1
  Case 1
    MenuBK_Map(i,18)\iID = #PIC_FLOR_GRAY_2
  Case 2
    MenuBK_Map(i,18)\iID = #PIC_FLOR_GRAY_3
  EndSelect
  MenuBK_Map(i,18)\iCollision = #True
Next

MenuBK_Map(6,17)\iID = #PIC_FLOR_GRAY_1
MenuBK_Map(7,17)\iID = #PIC_FLOR_GRAY_1
MenuBK_Map(8,17)\iID = #PIC_FLOR_GRAY_1
MenuBK_Map(5,16)\iID = #PIC_GROUND_GRAY_START
MenuBK_Map(6,16)\iID = #PIC_GROUND_GRAY_2
MenuBK_Map(7,16)\iID = #PIC_GROUND_GRAY_1
MenuBK_Map(8,16)\iID = #PIC_GROUND_GRAY_3
MenuBK_Map(9,16)\iID = #PIC_GROUND_GRAY_END
MenuBK_Map(5,16)\iCollision = #True
MenuBK_Map(6,16)\iCollision = #True
MenuBK_Map(7,16)\iCollision = #True
MenuBK_Map(8,16)\iCollision = #True
MenuBK_Map(9,16)\iCollision = #True


MenuBK_Map(1,17)\iID = #PIC_PALM_STAM
MenuBK_Map(1,16)\iID = #PIC_PALM_STAM
MenuBK_Map(1,15)\iID = #PIC_PALM_STAM
MenuBK_Map(1,14)\iID = #PIC_PALM_STAM_TOP
MenuBK_Map(1,13)\iID = #PIC_PALM_TOP
MenuBK_Map(0,13)\iID = #PIC_PALM_TOP_LEFT
MenuBK_Map(2,13)\iID = #PIC_PALM_TOP_RIGHT
MenuBK_Map(2,14)\iID = #PIC_PALM_RIGHT
MenuBK_Map(0,14)\iID = #PIC_PALM_LEFT
MenuBK_Map(1,17)\iCollision = #True
MenuBK_Map(1,16)\iCollision = #True
MenuBK_Map(1,15)\iCollision = #True
MenuBK_Map(1,14)\iCollision = #True
MenuBK_Map(1,13)\iCollision = #True
MenuBK_Map(0,13)\iCollision = #True
MenuBK_Map(2,13)\iCollision = #True
MenuBK_Map(2,14)\iCollision = #True
MenuBK_Map(0,14)\iCollision = #True


MenuBK_Map(23,17)\iID = #PIC_PALM_STAM
MenuBK_Map(23,16)\iID = #PIC_PALM_STAM
MenuBK_Map(23,15)\iID = #PIC_PALM_STAM
MenuBK_Map(23,14)\iID = #PIC_PALM_STAM
MenuBK_Map(23,13)\iID = #PIC_PALM_STAM
MenuBK_Map(23,12)\iID = #PIC_PALM_STAM_TOP
MenuBK_Map(23,11)\iID = #PIC_PALM_TOP
MenuBK_Map(22,11)\iID = #PIC_PALM_TOP_LEFT
MenuBK_Map(24,11)\iID = #PIC_PALM_TOP_RIGHT
MenuBK_Map(24,12)\iID = #PIC_PALM_RIGHT
MenuBK_Map(22,12)\iID = #PIC_PALM_LEFT
MenuBK_Map(23,17)\iCollision = #True
MenuBK_Map(23,16)\iCollision = #True
MenuBK_Map(23,15)\iCollision = #True
MenuBK_Map(23,14)\iCollision = #True
MenuBK_Map(23,13)\iCollision = #True
MenuBK_Map(23,12)\iCollision = #True
MenuBK_Map(23,11)\iCollision = #True
MenuBK_Map(22,11)\iCollision = #True
MenuBK_Map(24,11)\iCollision = #True
MenuBK_Map(24,12)\iCollision = #True
MenuBK_Map(22,12)\iCollision = #True


MenuBK_Map(16,16)\iID = #PIC_BLUME_1
MenuBK_Map(16,16)\iLevel = 1
MenuBK_Map(24,16)\iID = #PIC_GRAS_3
MenuBK_Map(24,16)\iLevel = 1
MenuBK_Map(22,16)\iID = #PIC_GRAS_2
MenuBK_Map(22,16)\iLevel = 1
MenuBK_Map(0,16)\iID = #PIC_GRAS_1
MenuBK_Map(0,16)\iLevel = 1
MenuBK_Map(2,16)\iID = #PIC_GRAS_1
MenuBK_Map(2,16)\iLevel = 1
MenuBK_Map(3,16)\iID = #PIC_GRAS_1
MenuBK_Map(3,16)\iLevel = 1
MenuBK_Map(4,16)\iID = #PIC_GRAS_1
MenuBK_Map(4,16)\iLevel = 1
MenuBK_Map(6,15)\iID = #PIC_BLUME_2
MenuBK_Map(6,15)\iLevel = 1

MenuTextSprite=CreateSprite(#PB_Any,1024,1024)


StartDrawing(SpriteOutput(MenuTextSprite))
DrawingMode(#PB_2DDrawing_Transparent)
DrawingFont(FontID(1)) 
DrawText(150+2,350,"Start Game",RGB(100,100,100))
DrawText(150,350+2,"Start Game",RGB(100,100,100))
DrawText(150-2,350,"Start Game",RGB(100,100,100))
DrawText(150,350-2,"Start Game",RGB(100,100,100))
DrawText(150,350,"Start Game",RGB(255,255,255))

DrawText(400+2,380,"Credits",RGB(100,100,100))
DrawText(400,380+2,"Credits",RGB(100,100,100))
DrawText(400-2,380,"Credits",RGB(100,100,100))
DrawText(400,380-2,"Credits",RGB(100,100,100))
DrawText(400,380,"Credits",RGB(255,255,255))

DrawText(600+2,400,"Quit",RGB(100,100,100))
DrawText(600,400+2,"Quit",RGB(100,100,100))
DrawText(600-2,400,"Quit",RGB(100,100,100))
DrawText(600,400-2,"Quit",RGB(100,100,100))
DrawText(600,400,"Quit",RGB(255,255,255))

DrawingFont(FontID(3))
DrawText(100+2,400,"Top 10",RGB(100,100,100))
DrawText(100,400+2,"Top 10",RGB(100,100,100))
DrawText(100-2,400,"Top 10",RGB(100,100,100))
DrawText(100,400-2,"Top 10",RGB(100,100,100))
DrawText(100,400,"Top 10",RGB(255,255,255))

DrawingFont(FontID(2)) 
text.s="SCORPION Attack"
DrawText(120+2,20,text,RGB(128,128,128))
DrawText(120,20+2,text,RGB(128,128,128))
DrawText(120-2,20,text,RGB(128,128,128))
DrawText(120,20-2,text,RGB(128,128,128))
DrawText(120,20,text,RGB(250,250,255))
StopDrawing()


For i=0 To 10
  AddWolk(Random(800), Random(300), Random(200)/100 - Random(200)/100)
Next

iSkorpion_X = 210
iSkorpion_Y = 470
iScrollText = 800
LoadObjects()


Repeat
  ExamineKeyboard()
  ClearScreen(RGB(12,12,120))
  StartDrawing(ScreenOutput())
  For i=0 To 600
    LineXY(iX, iY+i, iX+800, iY+i , RGB(0,0,200-i/4)) 
  Next
  StopDrawing()
  Start3D()
  ;DisplayObject(#PIC_FLOR_GRAY_3, 10, 10)
  
  ;Draw Background Objects
  For x=0 To 24
    For y=0 To 18
      If MenuBK_Map(x, y)\iID And MenuBK_Map(x, y)\iLevel = 0
        DisplayObject(MenuBK_Map(x, y)\iID, x*32, y*32)
      EndIf
    Next
  Next
  
  ;Draw Skorpion
  If iSkorpion_Look
    If iSkorpion_AniCount&6 >2
      DisplayObject(#PIC_SKORPION_L1, iSkorpion_X, iSkorpion_Y, iSkorpion_angle)
    Else
      DisplayObject(#PIC_SKORPION_L2, iSkorpion_X, iSkorpion_Y, iSkorpion_angle)
    EndIf
  Else
    If iSkorpion_AniCount&6 >2
      DisplayObject(#PIC_SKORPION_R1, iSkorpion_X, iSkorpion_Y, iSkorpion_angle)
    Else
      DisplayObject(#PIC_SKORPION_R2, iSkorpion_X, iSkorpion_Y, iSkorpion_angle)
    EndIf
  EndIf
  iSkorpion_angle = 0
  
  ;Schwerkraft
  If MenuBK_Map(iSkorpion_X/32, ((iSkorpion_Y+2)/32)+1)\iCollision = #False And MenuBK_Map((iSkorpion_X/32)+1, ((iSkorpion_Y+2)/32)+1)\iCollision = #False 
    iSkorpion_Y + 2
    If iSkorpion_Look=1
      iSkorpion_angle = -5
    Else
      iSkorpion_angle = 5
    EndIf
  EndIf
  
  If KeyboardPushed(#PB_Key_Right)
    If MenuBK_Map(((iSkorpion_X+2)/32)+1, ((iSkorpion_Y)/32)+1)\iCollision = #False And (iSkorpion_X + 2) < 768
      iSkorpion_X + 2
      iSkorpion_AniCount+1
      iSkorpion_Look=0
      iSkorpion_angle = -10
    EndIf
  EndIf
  If KeyboardPushed(#PB_Key_Left)
    If MenuBK_Map(((iSkorpion_X-2)/32), ((iSkorpion_Y)/32)+1)\iCollision = #False And (iSkorpion_X - 2) > 0
      iSkorpion_X - 2
      iSkorpion_AniCount+1
      iSkorpion_Look=1
      iSkorpion_angle = 10
    EndIf
  EndIf
  If KeyboardPushed(#PB_Key_Space)
    If iSkorpion_Jump<=0
      If MenuBK_Map(iSkorpion_X/32, ((iSkorpion_Y+2)/32)+1)\iCollision Or MenuBK_Map((iSkorpion_X/32)+1, ((iSkorpion_Y+2)/32)+1)\iCollision
        iSkorpion_Jump=18
      EndIf
    EndIf
  EndIf
  If KeyboardPushed(#PB_Key_Up)
    If iSkorpion_Jump<=0
      If MenuBK_Map(iSkorpion_X/32, ((iSkorpion_Y+2)/32)+1)\iCollision Or MenuBK_Map((iSkorpion_X/32)+1, ((iSkorpion_Y+2)/32)+1)\iCollision
        iSkorpion_Jump=12
      EndIf
    EndIf
  EndIf
  If iSkorpion_Jump>0
    iSkorpion_Jump-1
    If MenuBK_Map(iSkorpion_X/32, ((iSkorpion_Y - iSkorpion_Jump)/32)+1)\iCollision = #False And MenuBK_Map((iSkorpion_X/32)+1, ((iSkorpion_Y - iSkorpion_Jump)/32)+1)\iCollision = #False 
      iSkorpion_Y - iSkorpion_Jump
      If iSkorpion_Look=1
        iSkorpion_angle = iSkorpion_Jump*3
      Else
        iSkorpion_angle = -(iSkorpion_Jump*3)
      EndIf
    EndIf
  EndIf
  
  If iSkorpion_X>150 And iSkorpion_X<300
    If iSkorpion_Y>350 And iSkorpion_Y<360
      AddExplosion(iSkorpion_X+16, iSkorpion_Y+16)
      iAuswahlcount=15
      iAuswahlitem=0
    EndIf
  EndIf
  
  If iSkorpion_X>400 And iSkorpion_X<500
    If iSkorpion_Y>380 And iSkorpion_Y<390
      AddExplosion(iSkorpion_X+16, iSkorpion_Y+16)
      iAuswahlcount=15
      iAuswahlitem=1
    EndIf
  EndIf
  
  If iSkorpion_X>600 And iSkorpion_X<650
    If iSkorpion_Y>400 And iSkorpion_Y<410
      AddExplosion(iSkorpion_X+16, iSkorpion_Y+16)
      iAuswahlcount=15
      iAuswahlitem=2
    EndIf
  EndIf
  
  If iSkorpion_X>80 And iSkorpion_X<150
    If iSkorpion_Y>400 And iSkorpion_Y<420
      AddExplosion(iSkorpion_X+16, iSkorpion_Y+16)
      iAuswahlcount=15
      iAuswahlitem=3
    EndIf
  EndIf
  
  ;Draw Foreground Objects
  For x=0 To 24
    For y=0 To 18
      If MenuBK_Map(x, y)\iID And MenuBK_Map(x, y)\iLevel > 0
        DisplayObject(MenuBK_Map(x, y)\iID, x*32, y*32)
      EndIf
    Next
  Next
  
  ;DrawExplosion()
  DrawWolks()
  Stop3D()
  DisplayTransparentSprite(MenuTextSprite,0,0)
  StartDrawing(ScreenOutput())
  DrawingMode(#PB_2DDrawing_Transparent)
  DrawingFont(FontID(3)) 
  DrawText(iScrollText,580,"Jump into the Game!"+Space(20)+"Thanks to Hroudtwolf for this great Contest!"+Space(20)+"Created by RRSoftware.de",RGB(200+Sin(iSkorpion_X/100)*50,200+Sin(iSkorpion_X/100)*50,200+Sin(iSkorpion_X/100)*50))
  iScrollText-1
  If iScrollText<-1300:iScrollText=800:EndIf
  StopDrawing()

  
  Start3D()
  DrawExplosion()
  Stop3D()
  
  If iAuswahlcount>0
    iAuswahlcount-1
    If iAuswahlcount=0
      RemoveAllExplosion()
      If iAuswahlitem=0
        Game()
        iSkorpion_X = 210
        iSkorpion_Y = 470
        RemoveAllExplosion()
      EndIf
      If iAuswahlitem=1
        CreditsScreen()
        iSkorpion_X = 210
        iSkorpion_Y = 470
      EndIf
      If iAuswahlitem=2
        Quit = 1
      EndIf
      If iAuswahlitem=3
        iSkorpion_X = 210
        iSkorpion_Y = 470
        Top10Screen()
      EndIf
    EndIf
  EndIf
  
  
  FlipBuffers()
  Event = WindowEvent()
  If Event = #PB_Event_CloseWindow
    Quit = 1
  EndIf
Until Quit = 1 Or KeyboardReleased(#PB_Key_Escape)
ZPAC_Free()




; IDE Options = PureBasic 4.31 (Windows - x86)
; CursorPosition = 17
; Folding = g-
; EnableXP
; EnableUser
; Executable = ScorpionAttack.exe
; SubSystem = DirectX 9
; Warnings = Display
; EnableCompileCount = 1269
; EnableBuildCount = 62
; EnableExeConstant
; IncludeVersionInfo
; VersionField0 = 1,0,0,0
; VersionField1 = 1,0,0,0
; VersionField2 = RRSoftware
; VersionField3 = Scorpion Attack
; VersionField4 = 1.00
; VersionField5 = 1.00
; VersionField6 = Scorpion Attack
; VersionField7 = Scorpion Attack
; VersionField8 = Scorpion Attack
; VersionField9 = (c) 2009 RocketRider
; VersionField14 = http://www.RRSoftware.de