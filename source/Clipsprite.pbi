; ========================================== 
; #  ClipSprite3D for DirectX7 / DirectX9  # 
; ========================================== 

; Original by: S.M. (Stefan Moebius) 
; Modfied by: Christian Kemna (Fluid Byte) 
; Created: March  15, 2009 
; Test-Platform: Windows XP SP3 
; PB Version: 4.30 
; Web: http://www.codedreality.de/ 

CompilerIf Subsystem("DirectX9") 
   Structure D3DTLVERTEX 
     x.f 
     y.f 
     z.f 
     rhw.f 
     Color.l 
     tu.f 
     tv.f 
   EndStructure 

   Structure PB_DX9Sprite3D 
     TexRes.l                    ; TexRes 
     Vertice.D3DTLVERTEX[4]       ; The 4 vertices for the rectangle sprite 
     TmpVertice.D3DTLVERTEX[4]   ; The 4 vertices for the rectangle sprite 
     Width.l                     ; width set with ZoomSprite3D() 
     Height.l                     ; height set with ZoomSprite3D() 
     RealWidth.l 
     RealHeight.l 
     Angle.f 
     Transformed.l 
   EndStructure 

   Procedure ClipSprite3D(Sprite3D,ClipX,ClipY,ClipWidth,ClipHeight) 
      Protected *ptr.PB_DX9Sprite3D = IsSprite3D(Sprite3D) 
       
      If *ptr = 0 : ProcedureReturn #False : EndIf 
       
      If ClipX < 0 : ClipX = 0 : EndIf 
      If ClipY < 0 : ClipY = 0 : EndIf 
       
      If ClipWidth < 0 : ClipWidth = 0 : EndIf 
      If ClipHeight < 0 : ClipHeight = 0 : EndIf 
       
      If ClipX > *ptr\RealWidth : ClipX = *ptr\RealWidth : EndIf 
      If ClipY > *ptr\RealHeight : ClipY = *ptr\RealHeight : EndIf 
       
      If ClipX + ClipWidth > *ptr\RealWidth : ClipWidth = *ptr\RealWidth - ClipX : EndIf 
      If ClipY + ClipHeight > *ptr\RealHeight : ClipHeight = *ptr\RealHeight - ClipY : EndIf 
       
      *ptr\Vertice[0]\tu = ClipX / *ptr\RealWidth 
      *ptr\Vertice[0]\tv = ClipY / *ptr\RealHeight 
       
      *ptr\Vertice[1]\tu = (ClipX + ClipWidth) / *ptr\RealWidth 
      *ptr\Vertice[1]\tv = ClipY / *ptr\RealHeight 
       
      *ptr\Vertice[2]\tu = ClipX / *ptr\RealWidth 
      *ptr\Vertice[2]\tv = (ClipY + ClipHeight) / *ptr\RealHeight 
       
      *ptr\Vertice[3]\tu = (ClipX + ClipWidth) / *ptr\RealWidth 
      *ptr\Vertice[3]\tv = (ClipY + ClipHeight) / *ptr\RealHeight 
       
      ProcedureReturn #True 
   EndProcedure 
CompilerElse 
   Structure D3DTLVERTEX 
      x.f 
      y.f 
      z.f 
      rhw.f 
      Color.l 
      Specular.l 
      tu.f 
      tv.f 
   EndStructure 
    
   Structure PB_DX7Sprite3D 
      Texture.IDirectDrawSurface7   ; DirectDrawSurface7 
      Vertice.D3DTLVERTEX[4]         ; The 4 vertices for the rectangle sprite 
      Width.w                         ; width set with ZoomSprite3D() 
      Height.w                      ; height set with ZoomSprite3D()    
      unknown.l 
   EndStructure 

   Procedure ClipSprite3D(Sprite3D,ClipX,ClipY,ClipWidth,ClipHeight) 
      Protected *ptr.PB_DX7Sprite3D = IsSprite3D(Sprite3D) 
       
      If *ptr = 0 : ProcedureReturn 0 : EndIf 
       
      Protected RealWidth = SpriteWidth(Sprite3D) 
      Protected RealHeight = SpriteHeight(Sprite3D) 
          
      If ClipX < 0 : ClipX = 0 : EndIf 
      If ClipY < 0 : ClipY = 0 : EndIf 
       
      If ClipWidth < 0 : ClipWidth = 0 : EndIf 
      If ClipHeight < 0 : ClipHeight = 0 : EndIf       

      If ClipX > RealWidth : ClipX =  RealWidth : EndIf 
      If ClipY > RealHeight : ClipY = RealHeight : EndIf 
       
      If ClipX + ClipWidth > RealWidth : ClipWidth = RealWidth - ClipX : EndIf 
      If ClipY + ClipHeight > RealHeight : ClipHeight = RealHeight - ClipY : EndIf 
       
      *ptr\Vertice[0]\tu = ClipX / RealWidth 
      *ptr\Vertice[0]\tv = ClipY / RealHeight 
       
      *ptr\Vertice[1]\tu = (ClipX + ClipWidth) / RealWidth 
      *ptr\Vertice[1]\tv = ClipY / RealHeight 
       
      *ptr\Vertice[2]\tu = ClipX / RealWidth 
      *ptr\Vertice[2]\tv = (ClipY + ClipHeight) / RealHeight 
       
      *ptr\Vertice[3]\tu = (ClipX + ClipWidth) / RealWidth 
      *ptr\Vertice[3]\tv = (ClipY + ClipHeight) / RealHeight 
       
      ProcedureReturn 1 
   EndProcedure 
CompilerEndIf
; IDE Options = PureBasic 4.31 (Windows - x86)
; CursorPosition = 33
; Folding = 9
; EnableXP