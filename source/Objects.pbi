;Copyright (c) 2009 RocketRider
;This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held liable for any damages arising from the use of this software.
;Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:
;The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.
;Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
;This notice may not be removed or altered from any source distribution.

Macro ObjectConst(B, X, Y)
X + Y << 8 + B << 16
EndMacro


#PIC_BLACK = ObjectConst(4, 1, 1)

#PIC_SKORPION_L1 = ObjectConst(1, 14, 2)
#PIC_SKORPION_L2 = ObjectConst(1, 14, 3)
#PIC_SKORPION_R1 = ObjectConst(1, 13, 2)
#PIC_SKORPION_R2 = ObjectConst(1, 13, 3)

#PIC_GROUND_GRAY_1 = ObjectConst(4, 0, 0)
#PIC_GROUND_GRAY_2 = ObjectConst(4, 1, 0)
#PIC_GROUND_GRAY_3 = ObjectConst(4, 2, 0)
#PIC_GROUND_GRAY_START = ObjectConst(3, 0, 7)
#PIC_GROUND_GRAY_END = ObjectConst(3, 6, 7)

#PIC_FLOR_GRAY_1 = ObjectConst(3, 0, 6)
#PIC_FLOR_GRAY_2 = ObjectConst(3, 1, 6)
#PIC_FLOR_GRAY_3 = ObjectConst(3, 2, 6)
#PIC_FLOR_GRAY_END = ObjectConst(3, 14, 7)

#PIC_PALM_STAM = ObjectConst(4, 7, 3)
#PIC_PALM_STAM_TOP = ObjectConst(4, 7, 2)
#PIC_PALM_TOP_LEFT = ObjectConst(4, 6, 1)
#PIC_PALM_LEFT = ObjectConst(4, 6, 2)
#PIC_PALM_TOP = ObjectConst(4, 7, 1)
#PIC_PALM_RIGHT = ObjectConst(4, 8, 2)
#PIC_PALM_TOP_RIGHT = ObjectConst(4, 8, 1)

#PIC_EXPL_1 = ObjectConst(2, 0, 5)
#PIC_EXPL_2 = ObjectConst(2, 1, 5)
#PIC_EXPL_3 = ObjectConst(2, 2, 5)
#PIC_EXPL_4 = ObjectConst(2, 3, 5)
#PIC_EXPL_5 = ObjectConst(2, 4, 5)
#PIC_EXPL_6 = ObjectConst(2, 5, 5)
#PIC_EXPL_7 = ObjectConst(2, 6, 5)


#PIC_GRAS_1  = ObjectConst(4, 8, 4)
#PIC_GRAS_2  = ObjectConst(4, 9, 4)
#PIC_GRAS_3  = ObjectConst(4, 9, 3)
#PIC_GRAS_4  = ObjectConst(4, 12, 2)
#PIC_BLUME_1  = ObjectConst(4, 12, 1)
#PIC_BLUME_2  = ObjectConst(4, 13, 1)
#PIC_BLUME_3  = ObjectConst(4, 16, 2)
#PIC_BLUME_4  = ObjectConst(4, 14, 5)
#PIC_BLUME_5  = ObjectConst(4, 14, 1)

#PIC_WOLK1_PART1  = ObjectConst(3, 3, 5)
#PIC_WOLK1_PART2  = ObjectConst(3, 4, 5)
#PIC_WOLK1_PART3  = ObjectConst(3, 5, 5)

#PIC_WOLK2_PART1  = ObjectConst(3, 6, 5)
#PIC_WOLK2_PART2  = ObjectConst(3, 7, 5)

#PIC_WOLK3_PART1  = ObjectConst(3, 8, 5)
#PIC_WOLK3_PART2  = ObjectConst(3, 9, 5)
#PIC_WOLK3_PART3  = ObjectConst(3, 10, 5)

#PIC_FINISH  = ObjectConst(5, 1, 3)
#PIC_FINISH_2  = ObjectConst(6, 4, 4)

#PIC_FLOR_BROWN_1  = ObjectConst(3, 3, 0)
#PIC_FLOR_BROWN_2  = ObjectConst(3, 4, 0)
#PIC_FLOR_BROWN_3  = ObjectConst(3, 5, 0)
#PIC_FLOR_BROWN_4  = ObjectConst(3, 6, 0)
#PIC_FLOR_BROWN_5  = ObjectConst(3, 7, 0)
#PIC_FLOR_BROWN_6  = ObjectConst(3, 8, 0)
#PIC_FLOR_BROWN_7  = ObjectConst(3, 12, 0)
#PIC_FLOR_BROWN_8  = ObjectConst(3, 13, 0)
#PIC_FLOR_BROWN_9  = ObjectConst(3, 14, 0)
#PIC_FLOR_BROWN_10  = ObjectConst(3, 15, 0)
#PIC_GROUND_BROWN_1  = ObjectConst(3, 5, 1)
#PIC_GROUND_BROWN_2  = ObjectConst(3, 6, 1)
#PIC_GROUND_BROWN_3  = ObjectConst(3, 7, 1)
#PIC_GROUND_BROWN_4  = ObjectConst(3, 8, 1)
#PIC_GROUND_BROWN_5  = ObjectConst(3, 9, 1)
#PIC_GROUND_BROWN_6  = ObjectConst(3, 10, 1)

#PIC_PRICK_1  = ObjectConst(4, 11, 4)
#PIC_PRICK_2  = ObjectConst(4, 12, 4)
#PIC_PRICK_3  = ObjectConst(4, 13, 4)
#PIC_BOMB  = ObjectConst(2, 7, 4)

#PIC_ENERGY  = ObjectConst(2, 18, 12)
#PIC_KEY  = ObjectConst(1, 16, 2)
#PIC_GATE_1  = ObjectConst(2, 4, 7)
#PIC_GATE_2  = ObjectConst(2, 4, 9)

#PIC_DIAMOND_ORANGE  = ObjectConst(1, 12, 1)
#PIC_DIAMOND_BLUE  = ObjectConst(1, 14, 1)
#PIC_DIAMOND_RED  = ObjectConst(1, 16, 3)

#PIC_DANGER_1  = ObjectConst(4, 10, 7)
#PIC_DANGER_2  = ObjectConst(4, 11, 7)
#PIC_LEVEL_1  = ObjectConst(4, 10, 8)
#PIC_LEVEL_2  = ObjectConst(4, 11, 8)
#PIC_BONUS_1  = ObjectConst(4, 10, 9)
#PIC_BONUS_2  = ObjectConst(4, 11, 9)

#PIC_WALL  = ObjectConst(4, 5, 2)

#PIC_ENEMY_L1  = ObjectConst(1, 0, 2)
#PIC_ENEMY_L2  = ObjectConst(1, 0, 3)
#PIC_ENEMY_R1  = ObjectConst(1, 1, 2)
#PIC_ENEMY_R2  = ObjectConst(1, 1, 3)

#PIC_ENEMY2_L1 = ObjectConst(1, 14, 8)
#PIC_ENEMY2_L2 = ObjectConst(1, 14, 9)
#PIC_ENEMY2_R1 = ObjectConst(1, 15, 8)
#PIC_ENEMY2_R2 = ObjectConst(1, 15, 9)

#PIC_TRANSPORT = ObjectConst(2, 17, 4)

Procedure LoadObjects()
  LoadSprite(1,"data\action1.png", #PB_Sprite_Texture)
  LoadSprite(2,"data\arinoid_master.png", #PB_Sprite_Texture)
  LoadSprite(3,"data\blocks1.png", #PB_Sprite_Texture)
  LoadSprite(4,"data\blocks2.png", #PB_Sprite_Texture)
  LoadSprite(5,"data\tankbrigade.png", #PB_Sprite_Texture)
  LoadSprite(6,"data\1945.png", #PB_Sprite_Texture)
  CreateSprite3D(1, 1)
  CreateSprite3D(2, 2)
  CreateSprite3D(3, 3)
  CreateSprite3D(4, 4)
  CreateSprite3D(5, 5)
  CreateSprite3D(6, 6)
EndProcedure
Procedure DisplayObject(iObject.i, iX.i, iY.i, iAngle.i = 0, iTransparency.i = 255, iZoomX=#False, iZoomY=#False)
If iObject
  iOX.i = iObject & $FF
  iOY.i = (iObject >> 8) & $FF
  iOB.i = (iObject >> 16) & $FF
  
  ;ClipSprite(iOB,2+iOX*34,2+iOY*34,32,32)
  ;DisplayTransparentSprite(iOB, iX, iY)
  Select iOB
  Case 1  
    ClipSprite3D(iOB,1+iOX*34,1+iOY*34,34,34)
    RotateSprite3D(iOB, 0, 0)
    If iZoomX=#False:iZoomX=34:EndIf
    If iZoomY=#False:iZoomY=34:EndIf
    ZoomSprite3D(iOB, iZoomX, iZoomY)  
  Case 2
    ClipSprite3D(iOB,1+iOX*32,1+iOY*32,31,31)
    RotateSprite3D(iOB, 0, 0)
    If iZoomX=#False:iZoomX=31:EndIf
    If iZoomY=#False:iZoomY=31:EndIf
    ZoomSprite3D(iOB, iZoomX, iZoomY)
  Case 5
    ClipSprite3D(iOB,2+iOX*32,3+iOY*32,31,31)
    RotateSprite3D(iOB, 0, 0)
    If iZoomX=#False:iZoomX=31:EndIf
    If iZoomY=#False:iZoomY=31:EndIf
    ZoomSprite3D(iOB, iZoomX, iZoomY)  
  Case 6
    ClipSprite3D(iOB,iOX*34,iOY*34,32,32)
    RotateSprite3D(iOB, 0, 0)
    If iZoomX=#False:iZoomX=32:EndIf
    If iZoomY=#False:iZoomY=32:EndIf
    ZoomSprite3D(iOB, iZoomX, iZoomY)    
  Default
    ClipSprite3D(iOB,2+iOX*34,2+iOY*34,32,32)
    RotateSprite3D(iOB, 0, 0)
    If iZoomX=#False:iZoomX=32:EndIf
    If iZoomY=#False:iZoomY=32:EndIf
    ZoomSprite3D(iOB, iZoomX, iZoomY)
  EndSelect
  
  RotateSprite3D(iOB, iAngle, 1)
  DisplaySprite3D(iOB, iX, iY, iTransparency)
EndIf
EndProcedure


Procedure LoadImageObjects()
  LoadImage(1,"data\action1.png")
  LoadImage(2,"data\arinoid_master.png")
  LoadImage(3,"data\blocks1.png")
  LoadImage(4,"data\blocks2.png")
  LoadImage(5,"data\tankbrigade.png")
  LoadImage(6,"data\1945.png")
EndProcedure
Procedure GrabObject(iObject.i)
  iOX.i = iObject & $FF
  iOY.i = (iObject >> 8) & $FF
  iOB.i = (iObject >> 16) & $FF
  
  Select iOB
  Case 1  
    iResult = GrabImage(iOB, #PB_Any, 1+iOX*34,1+iOY*34,34,34)
  Case 2
    iResult = GrabImage(iOB, #PB_Any, 1+iOX*32,1+iOY*32,31,31)
  Case 5
    iResult = GrabImage(iOB, #PB_Any, 2+iOX*32,3+iOY*32,31,31)
  Case 6
    iResult = GrabImage(iOB, #PB_Any, iOX*34,iOY*34,32,32)  
  Default
    iResult = GrabImage(iOB, #PB_Any, 2+iOX*34,2+iOY*34,32,32)
  EndSelect
  
ProcedureReturn iResult
EndProcedure

; IDE Options = PureBasic 4.31 (Windows - x86)
; CursorPosition = 121
; FirstLine = 93
; Folding = i
; EnableXP