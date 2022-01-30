(library
    (bindings raylib bindings)
  (export VrStereoConfig VrDeviceInfo Music Sound AudioStream Wave BoundingBox RayCollision Ray ModelAnimation Model BoneInfo Transform Material MaterialMap Shader Mesh Camera2D Camera Camera3D Font GlyphInfo NPatchInfo RenderTexture2D RenderTexture TextureCubemap Texture2D Texture Image Rectangle Color Matrix Quaternion Vector4 Vector3 Vector2 SetAudioStreamBufferSizeDefault SetAudioStreamPitch SetAudioStreamVolume StopAudioStream IsAudioStreamPlaying ResumeAudioStream PauseAudioStream PlayAudioStream IsAudioStreamProcessed UpdateAudioStream UnloadAudioStream LoadAudioStream GetMusicTimePlayed GetMusicTimeLength SetMusicPitch SetMusicVolume SeekMusicStream ResumeMusicStream PauseMusicStream StopMusicStream UpdateMusicStream IsMusicStreamPlaying PlayMusicStream UnloadMusicStream LoadMusicStreamFromMemory LoadMusicStream UnloadWaveSamples LoadWaveSamples WaveCrop WaveCopy WaveFormat SetSoundPitch SetSoundVolume IsSoundPlaying GetSoundsPlaying StopSoundMulti PlaySoundMulti ResumeSound PauseSound StopSound PlaySound ExportWaveAsCode ExportWave UnloadSound UnloadWave UpdateSound LoadSoundFromWave LoadSound LoadWaveFromMemory LoadWave SetMasterVolume IsAudioDeviceReady CloseAudioDevice InitAudioDevice GetRayCollisionQuad GetRayCollisionTriangle GetRayCollisionMesh GetRayCollisionModel GetRayCollisionBox GetRayCollisionSphere CheckCollisionBoxSphere CheckCollisionBoxes CheckCollisionSpheres IsModelAnimationValid UnloadModelAnimations UnloadModelAnimation UpdateModelAnimation LoadModelAnimations SetModelMeshMaterial SetMaterialTexture UnloadMaterial LoadMaterialDefault LoadMaterials GenMeshCubicmap GenMeshHeightmap GenMeshKnot GenMeshTorus GenMeshCone GenMeshCylinder GenMeshHemiSphere GenMeshSphere GenMeshCube GenMeshPlane GenMeshPoly GenMeshBinormals GenMeshTangents GetMeshBoundingBox ExportMesh DrawMeshInstanced DrawMesh UnloadMesh UpdateMeshBuffer UploadMesh DrawBillboardPro DrawBillboardRec DrawBillboard DrawBoundingBox DrawModelWiresEx DrawModelWires DrawModelEx DrawModel GetModelBoundingBox UnloadModelKeepMeshes UnloadModel LoadModelFromMesh LoadModel DrawGrid DrawRay DrawPlane DrawCylinderWiresEx DrawCylinderWires DrawCylinderEx DrawCylinder DrawSphereWires DrawSphereEx DrawSphere DrawCubeTextureRec DrawCubeTexture DrawCubeWiresV DrawCubeWires DrawCubeV DrawCube DrawTriangleStrip3D DrawTriangle3D DrawCircle3D DrawPoint3D DrawLine3D CodepointToUTF8 GetCodepoint GetCodepointCount UnloadCodepoints LoadCodepoints GetGlyphAtlasRec GetGlyphInfo GetGlyphIndex MeasureTextEx MeasureText DrawTextCodepoint DrawTextPro DrawTextEx DrawText DrawFPS UnloadFont UnloadFontData LoadFontData LoadFontFromMemory LoadFontFromImage LoadFontEx LoadFont GetFontDefault GetPixelDataSize SetPixelColor GetPixelColor GetColor ColorAlphaBlend ColorAlpha ColorFromHSV ColorToHSV ColorFromNormalized ColorNormalize ColorToInt Fade DrawTexturePoly DrawTextureNPatch DrawTexturePro DrawTextureTiled DrawTextureQuad DrawTextureRec DrawTextureEx DrawTextureV DrawTexture SetTextureWrap SetTextureFilter GenTextureMipmaps UpdateTextureRec UpdateTexture UnloadRenderTexture UnloadTexture LoadRenderTexture LoadTextureCubemap LoadTextureFromImage LoadTexture ImageDrawTextEx ImageDrawText ImageDraw ImageDrawRectangleLines ImageDrawRectangleRec ImageDrawRectangleV ImageDrawRectangle ImageDrawCircleV ImageDrawCircle ImageDrawLineV ImageDrawLine ImageDrawPixelV ImageDrawPixel ImageClearBackground GetImageColor GetImageAlphaBorder UnloadImagePalette UnloadImageColors LoadImagePalette LoadImageColors ImageColorReplace ImageColorBrightness ImageColorContrast ImageColorGrayscale ImageColorInvert ImageColorTint ImageRotateCCW ImageRotateCW ImageFlipHorizontal ImageFlipVertical ImageDither ImageMipmaps ImageResizeCanvas ImageResizeNN ImageResize ImageAlphaPremultiply ImageAlphaMask ImageAlphaClear ImageAlphaCrop ImageCrop ImageToPOT ImageFormat ImageTextEx ImageText ImageFromImage ImageCopy GenImageCellular GenImageWhiteNoise GenImageChecked GenImageGradientRadial GenImageGradientH GenImageGradientV GenImageColor ExportImageAsCode ExportImage UnloadImage LoadImageFromScreen LoadImageFromTexture LoadImageFromMemory LoadImageAnim LoadImageRaw LoadImage GetCollisionRec CheckCollisionPointLine CheckCollisionLines CheckCollisionPointTriangle CheckCollisionPointCircle CheckCollisionPointRec CheckCollisionCircleRec CheckCollisionCircles CheckCollisionRecs DrawPolyLinesEx DrawPolyLines DrawPoly DrawTriangleStrip DrawTriangleFan DrawTriangleLines DrawTriangle DrawRectangleRoundedLines DrawRectangleRounded DrawRectangleLinesEx DrawRectangleLines DrawRectangleGradientEx DrawRectangleGradientH DrawRectangleGradientV DrawRectanglePro DrawRectangleRec DrawRectangleV DrawRectangle DrawRingLines DrawRing DrawEllipseLines DrawEllipse DrawCircleLines DrawCircleV DrawCircleGradient DrawCircleSectorLines DrawCircleSector DrawCircle DrawLineStrip DrawLineBezierCubic DrawLineBezierQuad DrawLineBezier DrawLineEx DrawLineV DrawLine DrawPixelV DrawPixel SetShapesTexture SetCameraMoveControls SetCameraSmoothZoomControl SetCameraAltControl SetCameraPanControl UpdateCamera SetCameraMode GetGesturePinchAngle GetGesturePinchVector GetGestureDragAngle GetGestureDragVector GetGestureHoldDuration GetGestureDetected IsGestureDetected SetGesturesEnabled GetTouchPointCount GetTouchPointId GetTouchPosition GetTouchY GetTouchX SetMouseCursor GetMouseWheelMove SetMouseScale SetMouseOffset SetMousePosition GetMouseDelta GetMousePosition GetMouseY GetMouseX IsMouseButtonUp IsMouseButtonReleased IsMouseButtonDown IsMouseButtonPressed SetGamepadMappings GetGamepadAxisMovement GetGamepadAxisCount GetGamepadButtonPressed IsGamepadButtonUp IsGamepadButtonReleased IsGamepadButtonDown IsGamepadButtonPressed GetGamepadName IsGamepadAvailable GetCharPressed GetKeyPressed SetExitKey IsKeyUp IsKeyReleased IsKeyDown IsKeyPressed OpenURL LoadStorageValue SaveStorageValue DecodeDataBase64 EncodeDataBase64 DecompressData CompressData GetFileModTime ClearDroppedFiles IsFileDropped ChangeDirectory ClearDirectoryFiles GetWorkingDirectory GetPrevDirectoryPath GetDirectoryPath GetFileNameWithoutExt GetFileName GetFileExtension IsFileExtension DirectoryExists FileExists SaveFileText UnloadFileText LoadFileText SaveFileData UnloadFileData LoadFileData MemFree MemRealloc MemAlloc SetTraceLogLevel TraceLog SetConfigFlags TakeScreenshot SetRandomSeed GetRandomValue GetTime GetFrameTime GetFPS SetTargetFPS GetScreenToWorld2D GetWorldToScreen2D GetWorldToScreenEx GetWorldToScreen GetCameraMatrix2D GetCameraMatrix GetMouseRay UnloadShader SetShaderValueTexture SetShaderValueMatrix SetShaderValueV SetShaderValue GetShaderLocationAttrib GetShaderLocation LoadShaderFromMemory LoadShader UnloadVrStereoConfig LoadVrStereoConfig EndVrStereoMode BeginVrStereoMode EndScissorMode BeginScissorMode EndBlendMode BeginBlendMode EndShaderMode BeginShaderMode EndTextureMode BeginTextureMode EndMode3D BeginMode3D EndMode2D BeginMode2D EndDrawing BeginDrawing ClearBackground IsCursorOnScreen DisableCursor EnableCursor IsCursorHidden HideCursor ShowCursor WaitTime PollInputEvents SwapScreenBuffer GetClipboardText SetClipboardText GetMonitorName GetWindowScaleDPI GetWindowPosition GetMonitorRefreshRate GetMonitorPhysicalHeight GetMonitorPhysicalWidth GetMonitorHeight GetMonitorWidth GetMonitorPosition GetCurrentMonitor GetMonitorCount GetScreenHeight GetScreenWidth GetWindowHandle SetWindowSize SetWindowMinSize SetWindowMonitor SetWindowPosition SetWindowTitle SetWindowIcon RestoreWindow MinimizeWindow MaximizeWindow ToggleFullscreen ClearWindowState SetWindowState IsWindowState IsWindowResized IsWindowFocused IsWindowMaximized IsWindowMinimized IsWindowHidden IsWindowFullscreen IsWindowReady CloseWindow WindowShouldClose InitWindow)
  (import
    (chezscheme))
  (begin (define lib-raylib
	   (load-shared-object "./raylib/libraylib.so"))
	 (define-ftype Vector2
	   (struct
	       [x float]
	     [y float]))
	 (define-ftype Vector3
	   (struct
	       [x float]
	     [y float]
	     [z float]))
	 (define-ftype Vector4
	   (struct
	       [x float]
	     [y float]
	     [z float]
	     [w float]))
	 (define-ftype Quaternion Vector4)
	 (define-ftype Matrix
	   (struct
	       [m0 float]
	     [m4 float]
	     [m8 float]
	     [m12 float]
	     [m1 float]
	     [m5 float]
	     [m9 float]
	     [m13 float]
	     [m2 float]
	     [m6 float]
	     [m10 float]
	     [m14 float]
	     [m3 float]
	     [m7 float]
	     [m11 float]
	     [m15 float]))
	 (define-ftype Color
	   (struct
	       [r unsigned-8]
	     [g unsigned-8]
	     [b unsigned-8]
	     [a unsigned-8]))
	 (define-ftype Rectangle
	   (struct
	       [x float]
	     [y float]
	     [width float]
	     [height float]))
	 (define-ftype Image
	   (struct
	       [data void*]
	     [width int]
	     [height int]
	     [mipmaps int]
	     [format int]))
	 (define-ftype Texture
	   (struct
	       [id unsigned-int]
	     [width int]
	     [height int]
	     [mipmaps int]
	     [format int]))
	 (define-ftype Texture2D Texture)
	 (define-ftype TextureCubemap Texture)
	 (define-ftype RenderTexture
	   (struct
	       [id unsigned-int]
	     [texture Texture]
	     [depth Texture]))
	 (define-ftype RenderTexture2D RenderTexture)
	 (define-ftype NPatchInfo
	   (struct
	       [source Rectangle]
	     [left int]
	     [top int]
	     [right int]
	     [bottom int]
	     [layout int]))
	 (define-ftype GlyphInfo
	   (struct
	       [value int]
	     [offsetX int]
	     [offsetY int]
	     [advanceX int]
	     [image Image]))
	 (define-ftype Font
	   (struct
	       [baseSize int]
	     [glyphCount int]
	     [glyphPadding int]
	     [texture Texture2D]
	     [recs
	      (* Rectangle)]
	     [glyphs
	      (* GlyphInfo)]))
	 (define-ftype Camera3D
	   (struct
	       [position Vector3]
	     [target Vector3]
	     [up Vector3]
	     [fovy float]
	     [projection int]))
	 (define-ftype Camera Camera3D)
	 (define-ftype Camera2D
	   (struct
	       [offset Vector2]
	     [target Vector2]
	     [rotation float]
	     [zoom float]))
	 (define-ftype Mesh
	   (struct
	       [vertexCount int]
	     [triangleCount int]
	     [vertices
	      (* float)]
	     [texcoords
	      (* float)]
	     [texcoords2
	      (* float)]
	     [normals
	      (* float)]
	     [tangents
	      (* float)]
	     [colors
	      (* unsigned-8)]
	     [indices
	      (* unsigned-short)]
	     [animVertices
	      (* float)]
	     [animNormals
	      (* float)]
	     [boneIds
	      (* unsigned-8)]
	     [boneWeights
	      (* float)]
	     [vaoId unsigned-int]
	     [vboId
	      (* unsigned-int)]))
	 (define-ftype Shader
	   (struct
	       [id unsigned-int]
	     [locs
	      (* int)]))
	 (define-ftype MaterialMap
	   (struct
	       [texture Texture2D]
	     [color Color]
	     [value float]))
	 (define-ftype Material
	   (struct
	       [shader Shader]
	     [maps
	      (* MaterialMap)]
	     [params
	      (array 4 float)]))
	 (define-ftype Transform
	   (struct
	       [translation Vector3]
	     [rotation Quaternion]
	     [scale Vector3]))
	 (define-ftype BoneInfo
	   (struct
	       [name
		(array 32 char)]
	     [parent int]))
	 (define-ftype Model
	   (struct
	       [transform Matrix]
	     [meshCount int]
	     [materialCount int]
	     [meshes
	      (* Mesh)]
	     [materials
	      (* Material)]
	     [meshMaterial
	      (* int)]
	     [boneCount int]
	     [bones
	      (* BoneInfo)]
	     [bindPose
	      (* Transform)]))
	 (define-ftype ModelAnimation
	   (struct
	       [boneCount int]
	     [frameCount int]
	     [bones
	      (* BoneInfo)]
	     [framePoses
	      (*
	       (* Transform))]))
	 (define-ftype Ray
	   (struct
	       [position Vector3]
	     [direction Vector3]))
	 (define-ftype RayCollision
	   (struct
	       [hit boolean]
	     [distance float]
	     [point Vector3]
	     [normal Vector3]))
	 (define-ftype BoundingBox
	   (struct
	       [min Vector3]
	     [max Vector3]))
	 (define-ftype Wave
	   (struct
	       [frameCount unsigned-int]
	     [sampleRate unsigned-int]
	     [sampleSize unsigned-int]
	     [channels unsigned-int]
	     [data void*]))
	 (define-ftype AudioStream
	   (struct
	       [buffer void*]
	     [sampleRate unsigned-int]
	     [sampleSize unsigned-int]
	     [channels unsigned-int]))
	 (define-ftype Sound
	   (struct
	       [stream AudioStream]
	     [frameCount unsigned-int]))
	 (define-ftype Music
	   (struct
	       [stream AudioStream]
	     [frameCount unsigned-int]
	     [looping boolean]
	     [ctxType int]
	     [ctxData void*]))
	 (define-ftype VrDeviceInfo
	   (struct
	       [hResolution int]
	     [vResolution int]
	     [hScreenSize float]
	     [vScreenSize float]
	     [vScreenCenter float]
	     [eyeToScreenDistance float]
	     [lensSeparationDistance float]
	     [interpupillaryDistance float]
	     [lensDistortionValues
	      (array 4 float)]
	     [chromaAbCorrection
	      (array 4 float)]))
	 (define-ftype VrStereoConfig
	   (struct
	       [projection
		(array 2 Matrix)]
	     [viewOffset
	      (array 2 Matrix)]
	     [leftLensCenter
	      (array 2 float)]
	     [rightLensCenter
	      (array 2 float)]
	     [leftScreenCenter
	      (array 2 float)]
	     [rightScreenCenter
	      (array 2 float)]
	     [scale
	      (array 2 float)]
	     [scaleIn
	      (array 2 float)]))
	 (define InitWindow
	   (foreign-procedure #f "InitWindow"
			      (int int string)
			      void))
	 (define WindowShouldClose
	   (foreign-procedure #f "WindowShouldClose" () boolean))
	 (define CloseWindow
	   (foreign-procedure #f "CloseWindow" () void))
	 (define IsWindowReady
	   (foreign-procedure #f "IsWindowReady" () boolean))
	 (define IsWindowFullscreen
	   (foreign-procedure #f "IsWindowFullscreen" () boolean))
	 (define IsWindowHidden
	   (foreign-procedure #f "IsWindowHidden" () boolean))
	 (define IsWindowMinimized
	   (foreign-procedure #f "IsWindowMinimized" () boolean))
	 (define IsWindowMaximized
	   (foreign-procedure #f "IsWindowMaximized" () boolean))
	 (define IsWindowFocused
	   (foreign-procedure #f "IsWindowFocused" () boolean))
	 (define IsWindowResized
	   (foreign-procedure #f "IsWindowResized" () boolean))
	 (define IsWindowState
	   (foreign-procedure #f "IsWindowState"
			      (unsigned-int)
			      boolean))
	 (define SetWindowState
	   (foreign-procedure #f "SetWindowState"
			      (unsigned-int)
			      void))
	 (define ClearWindowState
	   (foreign-procedure #f "ClearWindowState"
			      (unsigned-int)
			      void))
	 (define ToggleFullscreen
	   (foreign-procedure #f "ToggleFullscreen" () void))
	 (define MaximizeWindow
	   (foreign-procedure #f "MaximizeWindow" () void))
	 (define MinimizeWindow
	   (foreign-procedure #f "MinimizeWindow" () void))
	 (define RestoreWindow
	   (foreign-procedure #f "RestoreWindow" () void))
	 (define SetWindowIcon
	   (foreign-procedure #f "SetWindowIcon"
			      ((& Image))
			      void))
	 (define SetWindowTitle
	   (foreign-procedure #f "SetWindowTitle"
			      (string)
			      void))
	 (define SetWindowPosition
	   (foreign-procedure #f "SetWindowPosition"
			      (int int)
			      void))
	 (define SetWindowMonitor
	   (foreign-procedure #f "SetWindowMonitor"
			      (int)
			      void))
	 (define SetWindowMinSize
	   (foreign-procedure #f "SetWindowMinSize"
			      (int int)
			      void))
	 (define SetWindowSize
	   (foreign-procedure #f "SetWindowSize"
			      (int int)
			      void))
	 (define GetWindowHandle
	   (foreign-procedure #f "GetWindowHandle" () void*))
	 (define GetScreenWidth
	   (foreign-procedure #f "GetScreenWidth" () int))
	 (define GetScreenHeight
	   (foreign-procedure #f "GetScreenHeight" () int))
	 (define GetMonitorCount
	   (foreign-procedure #f "GetMonitorCount" () int))
	 (define GetCurrentMonitor
	   (foreign-procedure #f "GetCurrentMonitor" () int))
	 (define GetMonitorPosition
	   (foreign-procedure #f "GetMonitorPosition"
			      (int)
			      (& Vector2)))
	 (define GetMonitorWidth
	   (foreign-procedure #f "GetMonitorWidth"
			      (int)
			      int))
	 (define GetMonitorHeight
	   (foreign-procedure #f "GetMonitorHeight"
			      (int)
			      int))
	 (define GetMonitorPhysicalWidth
	   (foreign-procedure #f "GetMonitorPhysicalWidth"
			      (int)
			      int))
	 (define GetMonitorPhysicalHeight
	   (foreign-procedure #f "GetMonitorPhysicalHeight"
			      (int)
			      int))
	 (define GetMonitorRefreshRate
	   (foreign-procedure #f "GetMonitorRefreshRate"
			      (int)
			      int))
	 (define GetWindowPosition
	   (foreign-procedure #f "GetWindowPosition" ()
			      (& Vector2)))
	 (define GetWindowScaleDPI
	   (foreign-procedure #f "GetWindowScaleDPI" ()
			      (& Vector2)))
	 (define GetMonitorName
	   (foreign-procedure #f "GetMonitorName"
			      (int)
			      (* char)))
	 (define SetClipboardText
	   (foreign-procedure #f "SetClipboardText"
			      (string)
			      void))
	 (define GetClipboardText
	   (foreign-procedure #f "GetClipboardText" ()
			      (* char)))
	 (define SwapScreenBuffer
	   (foreign-procedure #f "SwapScreenBuffer" () void))
	 (define PollInputEvents
	   (foreign-procedure #f "PollInputEvents" () void))
	 (define WaitTime
	   (foreign-procedure #f "WaitTime"
			      (float)
			      void))
	 (define ShowCursor
	   (foreign-procedure #f "ShowCursor" () void))
	 (define HideCursor
	   (foreign-procedure #f "HideCursor" () void))
	 (define IsCursorHidden
	   (foreign-procedure #f "IsCursorHidden" () boolean))
	 (define EnableCursor
	   (foreign-procedure #f "EnableCursor" () void))
	 (define DisableCursor
	   (foreign-procedure #f "DisableCursor" () void))
	 (define IsCursorOnScreen
	   (foreign-procedure #f "IsCursorOnScreen" () boolean))
	 (define ClearBackground
	   (foreign-procedure #f "ClearBackground"
			      ((& Color))
			      void))
	 (define BeginDrawing
	   (foreign-procedure #f "BeginDrawing" () void))
	 (define EndDrawing
	   (foreign-procedure #f "EndDrawing" () void))
	 (define BeginMode2D
	   (foreign-procedure #f "BeginMode2D"
			      ((& Camera2D))
			      void))
	 (define EndMode2D
	   (foreign-procedure #f "EndMode2D" () void))
	 (define BeginMode3D
	   (foreign-procedure #f "BeginMode3D"
			      ((& Camera3D))
			      void))
	 (define EndMode3D
	   (foreign-procedure #f "EndMode3D" () void))
	 (define BeginTextureMode
	   (foreign-procedure #f "BeginTextureMode"
			      ((& RenderTexture2D))
			      void))
	 (define EndTextureMode
	   (foreign-procedure #f "EndTextureMode" () void))
	 (define BeginShaderMode
	   (foreign-procedure #f "BeginShaderMode"
			      ((& Shader))
			      void))
	 (define EndShaderMode
	   (foreign-procedure #f "EndShaderMode" () void))
	 (define BeginBlendMode
	   (foreign-procedure #f "BeginBlendMode"
			      (int)
			      void))
	 (define EndBlendMode
	   (foreign-procedure #f "EndBlendMode" () void))
	 (define BeginScissorMode
	   (foreign-procedure #f "BeginScissorMode"
			      (int int int int)
			      void))
	 (define EndScissorMode
	   (foreign-procedure #f "EndScissorMode" () void))
	 (define BeginVrStereoMode
	   (foreign-procedure #f "BeginVrStereoMode"
			      ((& VrStereoConfig))
			      void))
	 (define EndVrStereoMode
	   (foreign-procedure #f "EndVrStereoMode" () void))
	 (define LoadVrStereoConfig
	   (foreign-procedure #f "LoadVrStereoConfig"
			      ((& VrDeviceInfo))
			      (& VrStereoConfig)))
	 (define UnloadVrStereoConfig
	   (foreign-procedure #f "UnloadVrStereoConfig"
			      ((& VrStereoConfig))
			      void))
	 (define LoadShader
	   (foreign-procedure #f "LoadShader"
			      (string string)
			      (& Shader)))
	 (define LoadShaderFromMemory
	   (foreign-procedure #f "LoadShaderFromMemory"
			      (string string)
			      (& Shader)))
	 (define GetShaderLocation
	   (foreign-procedure #f "GetShaderLocation"
			      ((& Shader)
			       string)
			      int))
	 (define GetShaderLocationAttrib
	   (foreign-procedure #f "GetShaderLocationAttrib"
			      ((& Shader)
			       string)
			      int))
	 (define SetShaderValue
	   (foreign-procedure #f "SetShaderValue"
			      ((& Shader)
			       int void* int)
			      void))
	 (define SetShaderValueV
	   (foreign-procedure #f "SetShaderValueV"
			      ((& Shader)
			       int void* int int)
			      void))
	 (define SetShaderValueMatrix
	   (foreign-procedure #f "SetShaderValueMatrix"
			      ((& Shader)
			       int
			       (& Matrix))
			      void))
	 (define SetShaderValueTexture
	   (foreign-procedure #f "SetShaderValueTexture"
			      ((& Shader)
			       int
			       (& Texture2D))
			      void))
	 (define UnloadShader
	   (foreign-procedure #f "UnloadShader"
			      ((& Shader))
			      void))
	 (define GetMouseRay
	   (foreign-procedure #f "GetMouseRay"
			      ((& Vector2)
			       (& Camera))
			      (& Ray)))
	 (define GetCameraMatrix
	   (foreign-procedure #f "GetCameraMatrix"
			      ((& Camera))
			      (& Matrix)))
	 (define GetCameraMatrix2D
	   (foreign-procedure #f "GetCameraMatrix2D"
			      ((& Camera2D))
			      (& Matrix)))
	 (define GetWorldToScreen
	   (foreign-procedure #f "GetWorldToScreen"
			      ((& Vector3)
			       (& Camera))
			      (& Vector2)))
	 (define GetWorldToScreenEx
	   (foreign-procedure #f "GetWorldToScreenEx"
			      ((& Vector3)
			       (& Camera)
			       int int)
			      (& Vector2)))
	 (define GetWorldToScreen2D
	   (foreign-procedure #f "GetWorldToScreen2D"
			      ((& Vector2)
			       (& Camera2D))
			      (& Vector2)))
	 (define GetScreenToWorld2D
	   (foreign-procedure #f "GetScreenToWorld2D"
			      ((& Vector2)
			       (& Camera2D))
			      (& Vector2)))
	 (define SetTargetFPS
	   (foreign-procedure #f "SetTargetFPS"
			      (int)
			      void))
	 (define GetFPS
	   (foreign-procedure #f "GetFPS" () int))
	 (define GetFrameTime
	   (foreign-procedure #f "GetFrameTime" () float))
	 (define GetTime
	   (foreign-procedure #f "GetTime" () double))
	 (define GetRandomValue
	   (foreign-procedure #f "GetRandomValue"
			      (int int)
			      int))
	 (define SetRandomSeed
	   (foreign-procedure #f "SetRandomSeed"
			      (unsigned-int)
			      void))
	 (define TakeScreenshot
	   (foreign-procedure #f "TakeScreenshot"
			      (string)
			      void))
	 (define SetConfigFlags
	   (foreign-procedure #f "SetConfigFlags"
			      (unsigned-int)
			      void))
	 (define TraceLog
	   (foreign-procedure #f "TraceLog"
			      (int string)
			      void))
	 (define SetTraceLogLevel
	   (foreign-procedure #f "SetTraceLogLevel"
			      (int)
			      void))
	 (define MemAlloc
	   (foreign-procedure #f "MemAlloc"
			      (int)
			      void*))
	 (define MemRealloc
	   (foreign-procedure #f "MemRealloc"
			      (void* int)
			      void*))
	 (define MemFree
	   (foreign-procedure #f "MemFree"
			      (void*)
			      void))
	 (define LoadFileData
	   (foreign-procedure #f "LoadFileData"
			      (string
			       (* unsigned-int))
			      (* unsigned-8)))
	 (define UnloadFileData
	   (foreign-procedure #f "UnloadFileData"
			      ((* unsigned-8))
			      void))
	 (define SaveFileData
	   (foreign-procedure #f "SaveFileData"
			      (string void* unsigned-int)
			      boolean))
	 (define LoadFileText
	   (foreign-procedure #f "LoadFileText"
			      (string)
			      (* char)))
	 (define UnloadFileText
	   (foreign-procedure #f "UnloadFileText"
			      ((* char))
			      void))
	 (define SaveFileText
	   (foreign-procedure #f "SaveFileText"
			      (string
			       (* char))
			      boolean))
	 (define FileExists
	   (foreign-procedure #f "FileExists"
			      (string)
			      boolean))
	 (define DirectoryExists
	   (foreign-procedure #f "DirectoryExists"
			      (string)
			      boolean))
	 (define IsFileExtension
	   (foreign-procedure #f "IsFileExtension"
			      (string string)
			      boolean))
	 (define GetFileExtension
	   (foreign-procedure #f "GetFileExtension"
			      (string)
			      (* char)))
	 (define GetFileName
	   (foreign-procedure #f "GetFileName"
			      (string)
			      (* char)))
	 (define GetFileNameWithoutExt
	   (foreign-procedure #f "GetFileNameWithoutExt"
			      (string)
			      (* char)))
	 (define GetDirectoryPath
	   (foreign-procedure #f "GetDirectoryPath"
			      (string)
			      (* char)))
	 (define GetPrevDirectoryPath
	   (foreign-procedure #f "GetPrevDirectoryPath"
			      (string)
			      (* char)))
	 (define GetWorkingDirectory
	   (foreign-procedure #f "GetWorkingDirectory" ()
			      (* char)))
	 (define ClearDirectoryFiles
	   (foreign-procedure #f "ClearDirectoryFiles" () void))
	 (define ChangeDirectory
	   (foreign-procedure #f "ChangeDirectory"
			      (string)
			      boolean))
	 (define IsFileDropped
	   (foreign-procedure #f "IsFileDropped" () boolean))
	 (define ClearDroppedFiles
	   (foreign-procedure #f "ClearDroppedFiles" () void))
	 (define GetFileModTime
	   (foreign-procedure #f "GetFileModTime"
			      (string)
			      long))
	 (define CompressData
	   (foreign-procedure #f "CompressData"
			      ((* unsigned-8)
			       int
			       (* int))
			      (* unsigned-8)))
	 (define DecompressData
	   (foreign-procedure #f "DecompressData"
			      ((* unsigned-8)
			       int
			       (* int))
			      (* unsigned-8)))
	 (define EncodeDataBase64
	   (foreign-procedure #f "EncodeDataBase64"
			      ((* unsigned-8)
			       int
			       (* int))
			      (* char)))
	 (define DecodeDataBase64
	   (foreign-procedure #f "DecodeDataBase64"
			      ((* unsigned-8)
			       (* int))
			      (* unsigned-8)))
	 (define SaveStorageValue
	   (foreign-procedure #f "SaveStorageValue"
			      (unsigned-int int)
			      boolean))
	 (define LoadStorageValue
	   (foreign-procedure #f "LoadStorageValue"
			      (unsigned-int)
			      int))
	 (define OpenURL
	   (foreign-procedure #f "OpenURL"
			      (string)
			      void))
	 (define IsKeyPressed
	   (foreign-procedure #f "IsKeyPressed"
			      (int)
			      boolean))
	 (define IsKeyDown
	   (foreign-procedure #f "IsKeyDown"
			      (int)
			      boolean))
	 (define IsKeyReleased
	   (foreign-procedure #f "IsKeyReleased"
			      (int)
			      boolean))
	 (define IsKeyUp
	   (foreign-procedure #f "IsKeyUp"
			      (int)
			      boolean))
	 (define SetExitKey
	   (foreign-procedure #f "SetExitKey"
			      (int)
			      void))
	 (define GetKeyPressed
	   (foreign-procedure #f "GetKeyPressed" () int))
	 (define GetCharPressed
	   (foreign-procedure #f "GetCharPressed" () int))
	 (define IsGamepadAvailable
	   (foreign-procedure #f "IsGamepadAvailable"
			      (int)
			      boolean))
	 (define GetGamepadName
	   (foreign-procedure #f "GetGamepadName"
			      (int)
			      (* char)))
	 (define IsGamepadButtonPressed
	   (foreign-procedure #f "IsGamepadButtonPressed"
			      (int int)
			      boolean))
	 (define IsGamepadButtonDown
	   (foreign-procedure #f "IsGamepadButtonDown"
			      (int int)
			      boolean))
	 (define IsGamepadButtonReleased
	   (foreign-procedure #f "IsGamepadButtonReleased"
			      (int int)
			      boolean))
	 (define IsGamepadButtonUp
	   (foreign-procedure #f "IsGamepadButtonUp"
			      (int int)
			      boolean))
	 (define GetGamepadButtonPressed
	   (foreign-procedure #f "GetGamepadButtonPressed" () int))
	 (define GetGamepadAxisCount
	   (foreign-procedure #f "GetGamepadAxisCount"
			      (int)
			      int))
	 (define GetGamepadAxisMovement
	   (foreign-procedure #f "GetGamepadAxisMovement"
			      (int int)
			      float))
	 (define SetGamepadMappings
	   (foreign-procedure #f "SetGamepadMappings"
			      (string)
			      int))
	 (define IsMouseButtonPressed
	   (foreign-procedure #f "IsMouseButtonPressed"
			      (int)
			      boolean))
	 (define IsMouseButtonDown
	   (foreign-procedure #f "IsMouseButtonDown"
			      (int)
			      boolean))
	 (define IsMouseButtonReleased
	   (foreign-procedure #f "IsMouseButtonReleased"
			      (int)
			      boolean))
	 (define IsMouseButtonUp
	   (foreign-procedure #f "IsMouseButtonUp"
			      (int)
			      boolean))
	 (define GetMouseX
	   (foreign-procedure #f "GetMouseX" () int))
	 (define GetMouseY
	   (foreign-procedure #f "GetMouseY" () int))
	 (define GetMousePosition
	   (foreign-procedure #f "GetMousePosition" ()
			      (& Vector2)))
	 (define GetMouseDelta
	   (foreign-procedure #f "GetMouseDelta" ()
			      (& Vector2)))
	 (define SetMousePosition
	   (foreign-procedure #f "SetMousePosition"
			      (int int)
			      void))
	 (define SetMouseOffset
	   (foreign-procedure #f "SetMouseOffset"
			      (int int)
			      void))
	 (define SetMouseScale
	   (foreign-procedure #f "SetMouseScale"
			      (float float)
			      void))
	 (define GetMouseWheelMove
	   (foreign-procedure #f "GetMouseWheelMove" () float))
	 (define SetMouseCursor
	   (foreign-procedure #f "SetMouseCursor"
			      (int)
			      void))
	 (define GetTouchX
	   (foreign-procedure #f "GetTouchX" () int))
	 (define GetTouchY
	   (foreign-procedure #f "GetTouchY" () int))
	 (define GetTouchPosition
	   (foreign-procedure #f "GetTouchPosition"
			      (int)
			      (& Vector2)))
	 (define GetTouchPointId
	   (foreign-procedure #f "GetTouchPointId"
			      (int)
			      int))
	 (define GetTouchPointCount
	   (foreign-procedure #f "GetTouchPointCount" () int))
	 (define SetGesturesEnabled
	   (foreign-procedure #f "SetGesturesEnabled"
			      (unsigned-int)
			      void))
	 (define IsGestureDetected
	   (foreign-procedure #f "IsGestureDetected"
			      (int)
			      boolean))
	 (define GetGestureDetected
	   (foreign-procedure #f "GetGestureDetected" () int))
	 (define GetGestureHoldDuration
	   (foreign-procedure #f "GetGestureHoldDuration" () float))
	 (define GetGestureDragVector
	   (foreign-procedure #f "GetGestureDragVector" ()
			      (& Vector2)))
	 (define GetGestureDragAngle
	   (foreign-procedure #f "GetGestureDragAngle" () float))
	 (define GetGesturePinchVector
	   (foreign-procedure #f "GetGesturePinchVector" ()
			      (& Vector2)))
	 (define GetGesturePinchAngle
	   (foreign-procedure #f "GetGesturePinchAngle" () float))
	 (define SetCameraMode
	   (foreign-procedure #f "SetCameraMode"
			      ((& Camera)
			       int)
			      void))
	 (define UpdateCamera
	   (foreign-procedure #f "UpdateCamera"
			      ((* Camera))
			      void))
	 (define SetCameraPanControl
	   (foreign-procedure #f "SetCameraPanControl"
			      (int)
			      void))
	 (define SetCameraAltControl
	   (foreign-procedure #f "SetCameraAltControl"
			      (int)
			      void))
	 (define SetCameraSmoothZoomControl
	   (foreign-procedure #f "SetCameraSmoothZoomControl"
			      (int)
			      void))
	 (define SetCameraMoveControls
	   (foreign-procedure #f "SetCameraMoveControls"
			      (int int int int int int)
			      void))
	 (define SetShapesTexture
	   (foreign-procedure #f "SetShapesTexture"
			      ((& Texture2D)
			       (& Rectangle))
			      void))
	 (define DrawPixel
	   (foreign-procedure #f "DrawPixel"
			      (int int
				   (& Color))
			      void))
	 (define DrawPixelV
	   (foreign-procedure #f "DrawPixelV"
			      ((& Vector2)
			       (& Color))
			      void))
	 (define DrawLine
	   (foreign-procedure #f "DrawLine"
			      (int int int int
				   (& Color))
			      void))
	 (define DrawLineV
	   (foreign-procedure #f "DrawLineV"
			      ((& Vector2)
			       (& Vector2)
			       (& Color))
			      void))
	 (define DrawLineEx
	   (foreign-procedure #f "DrawLineEx"
			      ((& Vector2)
			       (& Vector2)
			       float
			       (& Color))
			      void))
	 (define DrawLineBezier
	   (foreign-procedure #f "DrawLineBezier"
			      ((& Vector2)
			       (& Vector2)
			       float
			       (& Color))
			      void))
	 (define DrawLineBezierQuad
	   (foreign-procedure #f "DrawLineBezierQuad"
			      ((& Vector2)
			       (& Vector2)
			       (& Vector2)
			       float
			       (& Color))
			      void))
	 (define DrawLineBezierCubic
	   (foreign-procedure #f "DrawLineBezierCubic"
			      ((& Vector2)
			       (& Vector2)
			       (& Vector2)
			       (& Vector2)
			       float
			       (& Color))
			      void))
	 (define DrawLineStrip
	   (foreign-procedure #f "DrawLineStrip"
			      ((* Vector2)
			       int
			       (& Color))
			      void))
	 (define DrawCircle
	   (foreign-procedure #f "DrawCircle"
			      (int int float
				   (& Color))
			      void))
	 (define DrawCircleSector
	   (foreign-procedure #f "DrawCircleSector"
			      ((& Vector2)
			       float float float int
			       (& Color))
			      void))
	 (define DrawCircleSectorLines
	   (foreign-procedure #f "DrawCircleSectorLines"
			      ((& Vector2)
			       float float float int
			       (& Color))
			      void))
	 (define DrawCircleGradient
	   (foreign-procedure #f "DrawCircleGradient"
			      (int int float
				   (& Color)
				   (& Color))
			      void))
	 (define DrawCircleV
	   (foreign-procedure #f "DrawCircleV"
			      ((& Vector2)
			       float
			       (& Color))
			      void))
	 (define DrawCircleLines
	   (foreign-procedure #f "DrawCircleLines"
			      (int int float
				   (& Color))
			      void))
	 (define DrawEllipse
	   (foreign-procedure #f "DrawEllipse"
			      (int int float float
				   (& Color))
			      void))
	 (define DrawEllipseLines
	   (foreign-procedure #f "DrawEllipseLines"
			      (int int float float
				   (& Color))
			      void))
	 (define DrawRing
	   (foreign-procedure #f "DrawRing"
			      ((& Vector2)
			       float float float float int
			       (& Color))
			      void))
	 (define DrawRingLines
	   (foreign-procedure #f "DrawRingLines"
			      ((& Vector2)
			       float float float float int
			       (& Color))
			      void))
	 (define DrawRectangle
	   (foreign-procedure #f "DrawRectangle"
			      (int int int int
				   (& Color))
			      void))
	 (define DrawRectangleV
	   (foreign-procedure #f "DrawRectangleV"
			      ((& Vector2)
			       (& Vector2)
			       (& Color))
			      void))
	 (define DrawRectangleRec
	   (foreign-procedure #f "DrawRectangleRec"
			      ((& Rectangle)
			       (& Color))
			      void))
	 (define DrawRectanglePro
	   (foreign-procedure #f "DrawRectanglePro"
			      ((& Rectangle)
			       (& Vector2)
			       float
			       (& Color))
			      void))
	 (define DrawRectangleGradientV
	   (foreign-procedure #f "DrawRectangleGradientV"
			      (int int int int
				   (& Color)
				   (& Color))
			      void))
	 (define DrawRectangleGradientH
	   (foreign-procedure #f "DrawRectangleGradientH"
			      (int int int int
				   (& Color)
				   (& Color))
			      void))
	 (define DrawRectangleGradientEx
	   (foreign-procedure #f "DrawRectangleGradientEx"
			      ((& Rectangle)
			       (& Color)
			       (& Color)
			       (& Color)
			       (& Color))
			      void))
	 (define DrawRectangleLines
	   (foreign-procedure #f "DrawRectangleLines"
			      (int int int int
				   (& Color))
			      void))
	 (define DrawRectangleLinesEx
	   (foreign-procedure #f "DrawRectangleLinesEx"
			      ((& Rectangle)
			       float
			       (& Color))
			      void))
	 (define DrawRectangleRounded
	   (foreign-procedure #f "DrawRectangleRounded"
			      ((& Rectangle)
			       float int
			       (& Color))
			      void))
	 (define DrawRectangleRoundedLines
	   (foreign-procedure #f "DrawRectangleRoundedLines"
			      ((& Rectangle)
			       float int float
			       (& Color))
			      void))
	 (define DrawTriangle
	   (foreign-procedure #f "DrawTriangle"
			      ((& Vector2)
			       (& Vector2)
			       (& Vector2)
			       (& Color))
			      void))
	 (define DrawTriangleLines
	   (foreign-procedure #f "DrawTriangleLines"
			      ((& Vector2)
			       (& Vector2)
			       (& Vector2)
			       (& Color))
			      void))
	 (define DrawTriangleFan
	   (foreign-procedure #f "DrawTriangleFan"
			      ((* Vector2)
			       int
			       (& Color))
			      void))
	 (define DrawTriangleStrip
	   (foreign-procedure #f "DrawTriangleStrip"
			      ((* Vector2)
			       int
			       (& Color))
			      void))
	 (define DrawPoly
	   (foreign-procedure #f "DrawPoly"
			      ((& Vector2)
			       int float float
			       (& Color))
			      void))
	 (define DrawPolyLines
	   (foreign-procedure #f "DrawPolyLines"
			      ((& Vector2)
			       int float float
			       (& Color))
			      void))
	 (define DrawPolyLinesEx
	   (foreign-procedure #f "DrawPolyLinesEx"
			      ((& Vector2)
			       int float float float
			       (& Color))
			      void))
	 (define CheckCollisionRecs
	   (foreign-procedure #f "CheckCollisionRecs"
			      ((& Rectangle)
			       (& Rectangle))
			      boolean))
	 (define CheckCollisionCircles
	   (foreign-procedure #f "CheckCollisionCircles"
			      ((& Vector2)
			       float
			       (& Vector2)
			       float)
			      boolean))
	 (define CheckCollisionCircleRec
	   (foreign-procedure #f "CheckCollisionCircleRec"
			      ((& Vector2)
			       float
			       (& Rectangle))
			      boolean))
	 (define CheckCollisionPointRec
	   (foreign-procedure #f "CheckCollisionPointRec"
			      ((& Vector2)
			       (& Rectangle))
			      boolean))
	 (define CheckCollisionPointCircle
	   (foreign-procedure #f "CheckCollisionPointCircle"
			      ((& Vector2)
			       (& Vector2)
			       float)
			      boolean))
	 (define CheckCollisionPointTriangle
	   (foreign-procedure #f "CheckCollisionPointTriangle"
			      ((& Vector2)
			       (& Vector2)
			       (& Vector2)
			       (& Vector2))
			      boolean))
	 (define CheckCollisionLines
	   (foreign-procedure #f "CheckCollisionLines"
			      ((& Vector2)
			       (& Vector2)
			       (& Vector2)
			       (& Vector2)
			       (* Vector2))
			      boolean))
	 (define CheckCollisionPointLine
	   (foreign-procedure #f "CheckCollisionPointLine"
			      ((& Vector2)
			       (& Vector2)
			       (& Vector2)
			       int)
			      boolean))
	 (define GetCollisionRec
	   (foreign-procedure #f "GetCollisionRec"
			      ((& Rectangle)
			       (& Rectangle))
			      (& Rectangle)))
	 (define LoadImage
	   (foreign-procedure #f "LoadImage"
			      (string)
			      (& Image)))
	 (define LoadImageRaw
	   (foreign-procedure #f "LoadImageRaw"
			      (string int int int int)
			      (& Image)))
	 (define LoadImageAnim
	   (foreign-procedure #f "LoadImageAnim"
			      (string
			       (* int))
			      (& Image)))
	 (define LoadImageFromMemory
	   (foreign-procedure #f "LoadImageFromMemory"
			      (string
			       (* unsigned-8)
			       int)
			      (& Image)))
	 (define LoadImageFromTexture
	   (foreign-procedure #f "LoadImageFromTexture"
			      ((& Texture2D))
			      (& Image)))
	 (define LoadImageFromScreen
	   (foreign-procedure #f "LoadImageFromScreen" ()
			      (& Image)))
	 (define UnloadImage
	   (foreign-procedure #f "UnloadImage"
			      ((& Image))
			      void))
	 (define ExportImage
	   (foreign-procedure #f "ExportImage"
			      ((& Image)
			       string)
			      boolean))
	 (define ExportImageAsCode
	   (foreign-procedure #f "ExportImageAsCode"
			      ((& Image)
			       string)
			      boolean))
	 (define GenImageColor
	   (foreign-procedure #f "GenImageColor"
			      (int int
				   (& Color))
			      (& Image)))
	 (define GenImageGradientV
	   (foreign-procedure #f "GenImageGradientV"
			      (int int
				   (& Color)
				   (& Color))
			      (& Image)))
	 (define GenImageGradientH
	   (foreign-procedure #f "GenImageGradientH"
			      (int int
				   (& Color)
				   (& Color))
			      (& Image)))
	 (define GenImageGradientRadial
	   (foreign-procedure #f "GenImageGradientRadial"
			      (int int float
				   (& Color)
				   (& Color))
			      (& Image)))
	 (define GenImageChecked
	   (foreign-procedure #f "GenImageChecked"
			      (int int int int
				   (& Color)
				   (& Color))
			      (& Image)))
	 (define GenImageWhiteNoise
	   (foreign-procedure #f "GenImageWhiteNoise"
			      (int int float)
			      (& Image)))
	 (define GenImageCellular
	   (foreign-procedure #f "GenImageCellular"
			      (int int int)
			      (& Image)))
	 (define ImageCopy
	   (foreign-procedure #f "ImageCopy"
			      ((& Image))
			      (& Image)))
	 (define ImageFromImage
	   (foreign-procedure #f "ImageFromImage"
			      ((& Image)
			       (& Rectangle))
			      (& Image)))
	 (define ImageText
	   (foreign-procedure #f "ImageText"
			      (string int
				      (& Color))
			      (& Image)))
	 (define ImageTextEx
	   (foreign-procedure #f "ImageTextEx"
			      ((& Font)
			       string float float
			       (& Color))
			      (& Image)))
	 (define ImageFormat
	   (foreign-procedure #f "ImageFormat"
			      ((* Image)
			       int)
			      void))
	 (define ImageToPOT
	   (foreign-procedure #f "ImageToPOT"
			      ((* Image)
			       (& Color))
			      void))
	 (define ImageCrop
	   (foreign-procedure #f "ImageCrop"
			      ((* Image)
			       (& Rectangle))
			      void))
	 (define ImageAlphaCrop
	   (foreign-procedure #f "ImageAlphaCrop"
			      ((* Image)
			       float)
			      void))
	 (define ImageAlphaClear
	   (foreign-procedure #f "ImageAlphaClear"
			      ((* Image)
			       (& Color)
			       float)
			      void))
	 (define ImageAlphaMask
	   (foreign-procedure #f "ImageAlphaMask"
			      ((* Image)
			       (& Image))
			      void))
	 (define ImageAlphaPremultiply
	   (foreign-procedure #f "ImageAlphaPremultiply"
			      ((* Image))
			      void))
	 (define ImageResize
	   (foreign-procedure #f "ImageResize"
			      ((* Image)
			       int int)
			      void))
	 (define ImageResizeNN
	   (foreign-procedure #f "ImageResizeNN"
			      ((* Image)
			       int int)
			      void))
	 (define ImageResizeCanvas
	   (foreign-procedure #f "ImageResizeCanvas"
			      ((* Image)
			       int int int int
			       (& Color))
			      void))
	 (define ImageMipmaps
	   (foreign-procedure #f "ImageMipmaps"
			      ((* Image))
			      void))
	 (define ImageDither
	   (foreign-procedure #f "ImageDither"
			      ((* Image)
			       int int int int)
			      void))
	 (define ImageFlipVertical
	   (foreign-procedure #f "ImageFlipVertical"
			      ((* Image))
			      void))
	 (define ImageFlipHorizontal
	   (foreign-procedure #f "ImageFlipHorizontal"
			      ((* Image))
			      void))
	 (define ImageRotateCW
	   (foreign-procedure #f "ImageRotateCW"
			      ((* Image))
			      void))
	 (define ImageRotateCCW
	   (foreign-procedure #f "ImageRotateCCW"
			      ((* Image))
			      void))
	 (define ImageColorTint
	   (foreign-procedure #f "ImageColorTint"
			      ((* Image)
			       (& Color))
			      void))
	 (define ImageColorInvert
	   (foreign-procedure #f "ImageColorInvert"
			      ((* Image))
			      void))
	 (define ImageColorGrayscale
	   (foreign-procedure #f "ImageColorGrayscale"
			      ((* Image))
			      void))
	 (define ImageColorContrast
	   (foreign-procedure #f "ImageColorContrast"
			      ((* Image)
			       float)
			      void))
	 (define ImageColorBrightness
	   (foreign-procedure #f "ImageColorBrightness"
			      ((* Image)
			       int)
			      void))
	 (define ImageColorReplace
	   (foreign-procedure #f "ImageColorReplace"
			      ((* Image)
			       (& Color)
			       (& Color))
			      void))
	 (define LoadImageColors
	   (foreign-procedure #f "LoadImageColors"
			      ((& Image))
			      (* Color)))
	 (define LoadImagePalette
	   (foreign-procedure #f "LoadImagePalette"
			      ((& Image)
			       int
			       (* int))
			      (* Color)))
	 (define UnloadImageColors
	   (foreign-procedure #f "UnloadImageColors"
			      ((* Color))
			      void))
	 (define UnloadImagePalette
	   (foreign-procedure #f "UnloadImagePalette"
			      ((* Color))
			      void))
	 (define GetImageAlphaBorder
	   (foreign-procedure #f "GetImageAlphaBorder"
			      ((& Image)
			       float)
			      (& Rectangle)))
	 (define GetImageColor
	   (foreign-procedure #f "GetImageColor"
			      ((& Image)
			       int int)
			      (& Color)))
	 (define ImageClearBackground
	   (foreign-procedure #f "ImageClearBackground"
			      ((* Image)
			       (& Color))
			      void))
	 (define ImageDrawPixel
	   (foreign-procedure #f "ImageDrawPixel"
			      ((* Image)
			       int int
			       (& Color))
			      void))
	 (define ImageDrawPixelV
	   (foreign-procedure #f "ImageDrawPixelV"
			      ((* Image)
			       (& Vector2)
			       (& Color))
			      void))
	 (define ImageDrawLine
	   (foreign-procedure #f "ImageDrawLine"
			      ((* Image)
			       int int int int
			       (& Color))
			      void))
	 (define ImageDrawLineV
	   (foreign-procedure #f "ImageDrawLineV"
			      ((* Image)
			       (& Vector2)
			       (& Vector2)
			       (& Color))
			      void))
	 (define ImageDrawCircle
	   (foreign-procedure #f "ImageDrawCircle"
			      ((* Image)
			       int int int
			       (& Color))
			      void))
	 (define ImageDrawCircleV
	   (foreign-procedure #f "ImageDrawCircleV"
			      ((* Image)
			       (& Vector2)
			       int
			       (& Color))
			      void))
	 (define ImageDrawRectangle
	   (foreign-procedure #f "ImageDrawRectangle"
			      ((* Image)
			       int int int int
			       (& Color))
			      void))
	 (define ImageDrawRectangleV
	   (foreign-procedure #f "ImageDrawRectangleV"
			      ((* Image)
			       (& Vector2)
			       (& Vector2)
			       (& Color))
			      void))
	 (define ImageDrawRectangleRec
	   (foreign-procedure #f "ImageDrawRectangleRec"
			      ((* Image)
			       (& Rectangle)
			       (& Color))
			      void))
	 (define ImageDrawRectangleLines
	   (foreign-procedure #f "ImageDrawRectangleLines"
			      ((* Image)
			       (& Rectangle)
			       int
			       (& Color))
			      void))
	 (define ImageDraw
	   (foreign-procedure #f "ImageDraw"
			      ((* Image)
			       (& Image)
			       (& Rectangle)
			       (& Rectangle)
			       (& Color))
			      void))
	 (define ImageDrawText
	   (foreign-procedure #f "ImageDrawText"
			      ((* Image)
			       string int int int
			       (& Color))
			      void))
	 (define ImageDrawTextEx
	   (foreign-procedure #f "ImageDrawTextEx"
			      ((* Image)
			       (& Font)
			       string
			       (& Vector2)
			       float float
			       (& Color))
			      void))
	 (define LoadTexture
	   (foreign-procedure #f "LoadTexture"
			      (string)
			      (& Texture2D)))
	 (define LoadTextureFromImage
	   (foreign-procedure #f "LoadTextureFromImage"
			      ((& Image))
			      (& Texture2D)))
	 (define LoadTextureCubemap
	   (foreign-procedure #f "LoadTextureCubemap"
			      ((& Image)
			       int)
			      (& TextureCubemap)))
	 (define LoadRenderTexture
	   (foreign-procedure #f "LoadRenderTexture"
			      (int int)
			      (& RenderTexture2D)))
	 (define UnloadTexture
	   (foreign-procedure #f "UnloadTexture"
			      ((& Texture2D))
			      void))
	 (define UnloadRenderTexture
	   (foreign-procedure #f "UnloadRenderTexture"
			      ((& RenderTexture2D))
			      void))
	 (define UpdateTexture
	   (foreign-procedure #f "UpdateTexture"
			      ((& Texture2D)
			       void*)
			      void))
	 (define UpdateTextureRec
	   (foreign-procedure #f "UpdateTextureRec"
			      ((& Texture2D)
			       (& Rectangle)
			       void*)
			      void))
	 (define GenTextureMipmaps
	   (foreign-procedure #f "GenTextureMipmaps"
			      ((* Texture2D))
			      void))
	 (define SetTextureFilter
	   (foreign-procedure #f "SetTextureFilter"
			      ((& Texture2D)
			       int)
			      void))
	 (define SetTextureWrap
	   (foreign-procedure #f "SetTextureWrap"
			      ((& Texture2D)
			       int)
			      void))
	 (define DrawTexture
	   (foreign-procedure #f "DrawTexture"
			      ((& Texture2D)
			       int int
			       (& Color))
			      void))
	 (define DrawTextureV
	   (foreign-procedure #f "DrawTextureV"
			      ((& Texture2D)
			       (& Vector2)
			       (& Color))
			      void))
	 (define DrawTextureEx
	   (foreign-procedure #f "DrawTextureEx"
			      ((& Texture2D)
			       (& Vector2)
			       float float
			       (& Color))
			      void))
	 (define DrawTextureRec
	   (foreign-procedure #f "DrawTextureRec"
			      ((& Texture2D)
			       (& Rectangle)
			       (& Vector2)
			       (& Color))
			      void))
	 (define DrawTextureQuad
	   (foreign-procedure #f "DrawTextureQuad"
			      ((& Texture2D)
			       (& Vector2)
			       (& Vector2)
			       (& Rectangle)
			       (& Color))
			      void))
	 (define DrawTextureTiled
	   (foreign-procedure #f "DrawTextureTiled"
			      ((& Texture2D)
			       (& Rectangle)
			       (& Rectangle)
			       (& Vector2)
			       float float
			       (& Color))
			      void))
	 (define DrawTexturePro
	   (foreign-procedure #f "DrawTexturePro"
			      ((& Texture2D)
			       (& Rectangle)
			       (& Rectangle)
			       (& Vector2)
			       float
			       (& Color))
			      void))
	 (define DrawTextureNPatch
	   (foreign-procedure #f "DrawTextureNPatch"
			      ((& Texture2D)
			       (& NPatchInfo)
			       (& Rectangle)
			       (& Vector2)
			       float
			       (& Color))
			      void))
	 (define DrawTexturePoly
	   (foreign-procedure #f "DrawTexturePoly"
			      ((& Texture2D)
			       (& Vector2)
			       (* Vector2)
			       (* Vector2)
			       int
			       (& Color))
			      void))
	 (define Fade
	   (foreign-procedure #f "Fade"
			      ((& Color)
			       float)
			      (& Color)))
	 (define ColorToInt
	   (foreign-procedure #f "ColorToInt"
			      ((& Color))
			      int))
	 (define ColorNormalize
	   (foreign-procedure #f "ColorNormalize"
			      ((& Color))
			      (& Vector4)))
	 (define ColorFromNormalized
	   (foreign-procedure #f "ColorFromNormalized"
			      ((& Vector4))
			      (& Color)))
	 (define ColorToHSV
	   (foreign-procedure #f "ColorToHSV"
			      ((& Color))
			      (& Vector3)))
	 (define ColorFromHSV
	   (foreign-procedure #f "ColorFromHSV"
			      (float float float)
			      (& Color)))
	 (define ColorAlpha
	   (foreign-procedure #f "ColorAlpha"
			      ((& Color)
			       float)
			      (& Color)))
	 (define ColorAlphaBlend
	   (foreign-procedure #f "ColorAlphaBlend"
			      ((& Color)
			       (& Color)
			       (& Color))
			      (& Color)))
	 (define GetColor
	   (foreign-procedure #f "GetColor"
			      (unsigned-int)
			      (& Color)))
	 (define GetPixelColor
	   (foreign-procedure #f "GetPixelColor"
			      (void* int)
			      (& Color)))
	 (define SetPixelColor
	   (foreign-procedure #f "SetPixelColor"
			      (void*
			       (& Color)
			       int)
			      void))
	 (define GetPixelDataSize
	   (foreign-procedure #f "GetPixelDataSize"
			      (int int int)
			      int))
	 (define GetFontDefault
	   (foreign-procedure #f "GetFontDefault" ()
			      (& Font)))
	 (define LoadFont
	   (foreign-procedure #f "LoadFont"
			      (string)
			      (& Font)))
	 (define LoadFontEx
	   (foreign-procedure #f "LoadFontEx"
			      (string int
				      (* int)
				      int)
			      (& Font)))
	 (define LoadFontFromImage
	   (foreign-procedure #f "LoadFontFromImage"
			      ((& Image)
			       (& Color)
			       int)
			      (& Font)))
	 (define LoadFontFromMemory
	   (foreign-procedure #f "LoadFontFromMemory"
			      (string
			       (* unsigned-8)
			       int int
			       (* int)
			       int)
			      (& Font)))
	 (define LoadFontData
	   (foreign-procedure #f "LoadFontData"
			      ((* unsigned-8)
			       int int
			       (* int)
			       int int)
			      (* GlyphInfo)))
	 (define UnloadFontData
	   (foreign-procedure #f "UnloadFontData"
			      ((* GlyphInfo)
			       int)
			      void))
	 (define UnloadFont
	   (foreign-procedure #f "UnloadFont"
			      ((& Font))
			      void))
	 (define DrawFPS
	   (foreign-procedure #f "DrawFPS"
			      (int int)
			      void))
	 (define DrawText
	   (foreign-procedure #f "DrawText"
			      (string int int int
				      (& Color))
			      void))
	 (define DrawTextEx
	   (foreign-procedure #f "DrawTextEx"
			      ((& Font)
			       string
			       (& Vector2)
			       float float
			       (& Color))
			      void))
	 (define DrawTextPro
	   (foreign-procedure #f "DrawTextPro"
			      ((& Font)
			       string
			       (& Vector2)
			       (& Vector2)
			       float float float
			       (& Color))
			      void))
	 (define DrawTextCodepoint
	   (foreign-procedure #f "DrawTextCodepoint"
			      ((& Font)
			       int
			       (& Vector2)
			       float
			       (& Color))
			      void))
	 (define MeasureText
	   (foreign-procedure #f "MeasureText"
			      (string int)
			      int))
	 (define MeasureTextEx
	   (foreign-procedure #f "MeasureTextEx"
			      ((& Font)
			       string float float)
			      (& Vector2)))
	 (define GetGlyphIndex
	   (foreign-procedure #f "GetGlyphIndex"
			      ((& Font)
			       int)
			      int))
	 (define GetGlyphInfo
	   (foreign-procedure #f "GetGlyphInfo"
			      ((& Font)
			       int)
			      (& GlyphInfo)))
	 (define GetGlyphAtlasRec
	   (foreign-procedure #f "GetGlyphAtlasRec"
			      ((& Font)
			       int)
			      (& Rectangle)))
	 (define LoadCodepoints
	   (foreign-procedure #f "LoadCodepoints"
			      (string
			       (* int))
			      (* int)))
	 (define UnloadCodepoints
	   (foreign-procedure #f "UnloadCodepoints"
			      ((* int))
			      void))
	 (define GetCodepointCount
	   (foreign-procedure #f "GetCodepointCount"
			      (string)
			      int))
	 (define GetCodepoint
	   (foreign-procedure #f "GetCodepoint"
			      (string
			       (* int))
			      int))
	 (define CodepointToUTF8
	   (foreign-procedure #f "CodepointToUTF8"
			      (int
			       (* int))
			      (* char)))
	 (define DrawLine3D
	   (foreign-procedure #f "DrawLine3D"
			      ((& Vector3)
			       (& Vector3)
			       (& Color))
			      void))
	 (define DrawPoint3D
	   (foreign-procedure #f "DrawPoint3D"
			      ((& Vector3)
			       (& Color))
			      void))
	 (define DrawCircle3D
	   (foreign-procedure #f "DrawCircle3D"
			      ((& Vector3)
			       float
			       (& Vector3)
			       float
			       (& Color))
			      void))
	 (define DrawTriangle3D
	   (foreign-procedure #f "DrawTriangle3D"
			      ((& Vector3)
			       (& Vector3)
			       (& Vector3)
			       (& Color))
			      void))
	 (define DrawTriangleStrip3D
	   (foreign-procedure #f "DrawTriangleStrip3D"
			      ((* Vector3)
			       int
			       (& Color))
			      void))
	 (define DrawCube
	   (foreign-procedure #f "DrawCube"
			      ((& Vector3)
			       float float float
			       (& Color))
			      void))
	 (define DrawCubeV
	   (foreign-procedure #f "DrawCubeV"
			      ((& Vector3)
			       (& Vector3)
			       (& Color))
			      void))
	 (define DrawCubeWires
	   (foreign-procedure #f "DrawCubeWires"
			      ((& Vector3)
			       float float float
			       (& Color))
			      void))
	 (define DrawCubeWiresV
	   (foreign-procedure #f "DrawCubeWiresV"
			      ((& Vector3)
			       (& Vector3)
			       (& Color))
			      void))
	 (define DrawCubeTexture
	   (foreign-procedure #f "DrawCubeTexture"
			      ((& Texture2D)
			       (& Vector3)
			       float float float
			       (& Color))
			      void))
	 (define DrawCubeTextureRec
	   (foreign-procedure #f "DrawCubeTextureRec"
			      ((& Texture2D)
			       (& Rectangle)
			       (& Vector3)
			       float float float
			       (& Color))
			      void))
	 (define DrawSphere
	   (foreign-procedure #f "DrawSphere"
			      ((& Vector3)
			       float
			       (& Color))
			      void))
	 (define DrawSphereEx
	   (foreign-procedure #f "DrawSphereEx"
			      ((& Vector3)
			       float int int
			       (& Color))
			      void))
	 (define DrawSphereWires
	   (foreign-procedure #f "DrawSphereWires"
			      ((& Vector3)
			       float int int
			       (& Color))
			      void))
	 (define DrawCylinder
	   (foreign-procedure #f "DrawCylinder"
			      ((& Vector3)
			       float float float int
			       (& Color))
			      void))
	 (define DrawCylinderEx
	   (foreign-procedure #f "DrawCylinderEx"
			      ((& Vector3)
			       (& Vector3)
			       float float int
			       (& Color))
			      void))
	 (define DrawCylinderWires
	   (foreign-procedure #f "DrawCylinderWires"
			      ((& Vector3)
			       float float float int
			       (& Color))
			      void))
	 (define DrawCylinderWiresEx
	   (foreign-procedure #f "DrawCylinderWiresEx"
			      ((& Vector3)
			       (& Vector3)
			       float float int
			       (& Color))
			      void))
	 (define DrawPlane
	   (foreign-procedure #f "DrawPlane"
			      ((& Vector3)
			       (& Vector2)
			       (& Color))
			      void))
	 (define DrawRay
	   (foreign-procedure #f "DrawRay"
			      ((& Ray)
			       (& Color))
			      void))
	 (define DrawGrid
	   (foreign-procedure #f "DrawGrid"
			      (int float)
			      void))
	 (define LoadModel
	   (foreign-procedure #f "LoadModel"
			      (string)
			      (& Model)))
	 (define LoadModelFromMesh
	   (foreign-procedure #f "LoadModelFromMesh"
			      ((& Mesh))
			      (& Model)))
	 (define UnloadModel
	   (foreign-procedure #f "UnloadModel"
			      ((& Model))
			      void))
	 (define UnloadModelKeepMeshes
	   (foreign-procedure #f "UnloadModelKeepMeshes"
			      ((& Model))
			      void))
	 (define GetModelBoundingBox
	   (foreign-procedure #f "GetModelBoundingBox"
			      ((& Model))
			      (& BoundingBox)))
	 (define DrawModel
	   (foreign-procedure #f "DrawModel"
			      ((& Model)
			       (& Vector3)
			       float
			       (& Color))
			      void))
	 (define DrawModelEx
	   (foreign-procedure #f "DrawModelEx"
			      ((& Model)
			       (& Vector3)
			       (& Vector3)
			       float
			       (& Vector3)
			       (& Color))
			      void))
	 (define DrawModelWires
	   (foreign-procedure #f "DrawModelWires"
			      ((& Model)
			       (& Vector3)
			       float
			       (& Color))
			      void))
	 (define DrawModelWiresEx
	   (foreign-procedure #f "DrawModelWiresEx"
			      ((& Model)
			       (& Vector3)
			       (& Vector3)
			       float
			       (& Vector3)
			       (& Color))
			      void))
	 (define DrawBoundingBox
	   (foreign-procedure #f "DrawBoundingBox"
			      ((& BoundingBox)
			       (& Color))
			      void))
	 (define DrawBillboard
	   (foreign-procedure #f "DrawBillboard"
			      ((& Camera)
			       (& Texture2D)
			       (& Vector3)
			       float
			       (& Color))
			      void))
	 (define DrawBillboardRec
	   (foreign-procedure #f "DrawBillboardRec"
			      ((& Camera)
			       (& Texture2D)
			       (& Rectangle)
			       (& Vector3)
			       (& Vector2)
			       (& Color))
			      void))
	 (define DrawBillboardPro
	   (foreign-procedure #f "DrawBillboardPro"
			      ((& Camera)
			       (& Texture2D)
			       (& Rectangle)
			       (& Vector3)
			       (& Vector3)
			       (& Vector2)
			       (& Vector2)
			       float
			       (& Color))
			      void))
	 (define UploadMesh
	   (foreign-procedure #f "UploadMesh"
			      ((* Mesh)
			       boolean)
			      void))
	 (define UpdateMeshBuffer
	   (foreign-procedure #f "UpdateMeshBuffer"
			      ((& Mesh)
			       int void* int int)
			      void))
	 (define UnloadMesh
	   (foreign-procedure #f "UnloadMesh"
			      ((& Mesh))
			      void))
	 (define DrawMesh
	   (foreign-procedure #f "DrawMesh"
			      ((& Mesh)
			       (& Material)
			       (& Matrix))
			      void))
	 (define DrawMeshInstanced
	   (foreign-procedure #f "DrawMeshInstanced"
			      ((& Mesh)
			       (& Material)
			       (* Matrix)
			       int)
			      void))
	 (define ExportMesh
	   (foreign-procedure #f "ExportMesh"
			      ((& Mesh)
			       string)
			      boolean))
	 (define GetMeshBoundingBox
	   (foreign-procedure #f "GetMeshBoundingBox"
			      ((& Mesh))
			      (& BoundingBox)))
	 (define GenMeshTangents
	   (foreign-procedure #f "GenMeshTangents"
			      ((* Mesh))
			      void))
	 (define GenMeshBinormals
	   (foreign-procedure #f "GenMeshBinormals"
			      ((* Mesh))
			      void))
	 (define GenMeshPoly
	   (foreign-procedure #f "GenMeshPoly"
			      (int float)
			      (& Mesh)))
	 (define GenMeshPlane
	   (foreign-procedure #f "GenMeshPlane"
			      (float float int int)
			      (& Mesh)))
	 (define GenMeshCube
	   (foreign-procedure #f "GenMeshCube"
			      (float float float)
			      (& Mesh)))
	 (define GenMeshSphere
	   (foreign-procedure #f "GenMeshSphere"
			      (float int int)
			      (& Mesh)))
	 (define GenMeshHemiSphere
	   (foreign-procedure #f "GenMeshHemiSphere"
			      (float int int)
			      (& Mesh)))
	 (define GenMeshCylinder
	   (foreign-procedure #f "GenMeshCylinder"
			      (float float int)
			      (& Mesh)))
	 (define GenMeshCone
	   (foreign-procedure #f "GenMeshCone"
			      (float float int)
			      (& Mesh)))
	 (define GenMeshTorus
	   (foreign-procedure #f "GenMeshTorus"
			      (float float int int)
			      (& Mesh)))
	 (define GenMeshKnot
	   (foreign-procedure #f "GenMeshKnot"
			      (float float int int)
			      (& Mesh)))
	 (define GenMeshHeightmap
	   (foreign-procedure #f "GenMeshHeightmap"
			      ((& Image)
			       (& Vector3))
			      (& Mesh)))
	 (define GenMeshCubicmap
	   (foreign-procedure #f "GenMeshCubicmap"
			      ((& Image)
			       (& Vector3))
			      (& Mesh)))
	 (define LoadMaterials
	   (foreign-procedure #f "LoadMaterials"
			      (string
			       (* int))
			      (* Material)))
	 (define LoadMaterialDefault
	   (foreign-procedure #f "LoadMaterialDefault" ()
			      (& Material)))
	 (define UnloadMaterial
	   (foreign-procedure #f "UnloadMaterial"
			      ((& Material))
			      void))
	 (define SetMaterialTexture
	   (foreign-procedure #f "SetMaterialTexture"
			      ((* Material)
			       int
			       (& Texture2D))
			      void))
	 (define SetModelMeshMaterial
	   (foreign-procedure #f "SetModelMeshMaterial"
			      ((* Model)
			       int int)
			      void))
	 (define LoadModelAnimations
	   (foreign-procedure #f "LoadModelAnimations"
			      (string
			       (* unsigned-int))
			      (* ModelAnimation)))
	 (define UpdateModelAnimation
	   (foreign-procedure #f "UpdateModelAnimation"
			      ((& Model)
			       (& ModelAnimation)
			       int)
			      void))
	 (define UnloadModelAnimation
	   (foreign-procedure #f "UnloadModelAnimation"
			      ((& ModelAnimation))
			      void))
	 (define UnloadModelAnimations
	   (foreign-procedure #f "UnloadModelAnimations"
			      ((* ModelAnimation)
			       unsigned-int)
			      void))
	 (define IsModelAnimationValid
	   (foreign-procedure #f "IsModelAnimationValid"
			      ((& Model)
			       (& ModelAnimation))
			      boolean))
	 (define CheckCollisionSpheres
	   (foreign-procedure #f "CheckCollisionSpheres"
			      ((& Vector3)
			       float
			       (& Vector3)
			       float)
			      boolean))
	 (define CheckCollisionBoxes
	   (foreign-procedure #f "CheckCollisionBoxes"
			      ((& BoundingBox)
			       (& BoundingBox))
			      boolean))
	 (define CheckCollisionBoxSphere
	   (foreign-procedure #f "CheckCollisionBoxSphere"
			      ((& BoundingBox)
			       (& Vector3)
			       float)
			      boolean))
	 (define GetRayCollisionSphere
	   (foreign-procedure #f "GetRayCollisionSphere"
			      ((& Ray)
			       (& Vector3)
			       float)
			      (& RayCollision)))
	 (define GetRayCollisionBox
	   (foreign-procedure #f "GetRayCollisionBox"
			      ((& Ray)
			       (& BoundingBox))
			      (& RayCollision)))
	 (define GetRayCollisionModel
	   (foreign-procedure #f "GetRayCollisionModel"
			      ((& Ray)
			       (& Model))
			      (& RayCollision)))
	 (define GetRayCollisionMesh
	   (foreign-procedure #f "GetRayCollisionMesh"
			      ((& Ray)
			       (& Mesh)
			       (& Matrix))
			      (& RayCollision)))
	 (define GetRayCollisionTriangle
	   (foreign-procedure #f "GetRayCollisionTriangle"
			      ((& Ray)
			       (& Vector3)
			       (& Vector3)
			       (& Vector3))
			      (& RayCollision)))
	 (define GetRayCollisionQuad
	   (foreign-procedure #f "GetRayCollisionQuad"
			      ((& Ray)
			       (& Vector3)
			       (& Vector3)
			       (& Vector3)
			       (& Vector3))
			      (& RayCollision)))
	 (define InitAudioDevice
	   (foreign-procedure #f "InitAudioDevice" () void))
	 (define CloseAudioDevice
	   (foreign-procedure #f "CloseAudioDevice" () void))
	 (define IsAudioDeviceReady
	   (foreign-procedure #f "IsAudioDeviceReady" () boolean))
	 (define SetMasterVolume
	   (foreign-procedure #f "SetMasterVolume"
			      (float)
			      void))
	 (define LoadWave
	   (foreign-procedure #f "LoadWave"
			      (string)
			      (& Wave)))
	 (define LoadWaveFromMemory
	   (foreign-procedure #f "LoadWaveFromMemory"
			      (string
			       (* unsigned-8)
			       int)
			      (& Wave)))
	 (define LoadSound
	   (foreign-procedure #f "LoadSound"
			      (string)
			      (& Sound)))
	 (define LoadSoundFromWave
	   (foreign-procedure #f "LoadSoundFromWave"
			      ((& Wave))
			      (& Sound)))
	 (define UpdateSound
	   (foreign-procedure #f "UpdateSound"
			      ((& Sound)
			       void* int)
			      void))
	 (define UnloadWave
	   (foreign-procedure #f "UnloadWave"
			      ((& Wave))
			      void))
	 (define UnloadSound
	   (foreign-procedure #f "UnloadSound"
			      ((& Sound))
			      void))
	 (define ExportWave
	   (foreign-procedure #f "ExportWave"
			      ((& Wave)
			       string)
			      boolean))
	 (define ExportWaveAsCode
	   (foreign-procedure #f "ExportWaveAsCode"
			      ((& Wave)
			       string)
			      boolean))
	 (define PlaySound
	   (foreign-procedure #f "PlaySound"
			      ((& Sound))
			      void))
	 (define StopSound
	   (foreign-procedure #f "StopSound"
			      ((& Sound))
			      void))
	 (define PauseSound
	   (foreign-procedure #f "PauseSound"
			      ((& Sound))
			      void))
	 (define ResumeSound
	   (foreign-procedure #f "ResumeSound"
			      ((& Sound))
			      void))
	 (define PlaySoundMulti
	   (foreign-procedure #f "PlaySoundMulti"
			      ((& Sound))
			      void))
	 (define StopSoundMulti
	   (foreign-procedure #f "StopSoundMulti" () void))
	 (define GetSoundsPlaying
	   (foreign-procedure #f "GetSoundsPlaying" () int))
	 (define IsSoundPlaying
	   (foreign-procedure #f "IsSoundPlaying"
			      ((& Sound))
			      boolean))
	 (define SetSoundVolume
	   (foreign-procedure #f "SetSoundVolume"
			      ((& Sound)
			       float)
			      void))
	 (define SetSoundPitch
	   (foreign-procedure #f "SetSoundPitch"
			      ((& Sound)
			       float)
			      void))
	 (define WaveFormat
	   (foreign-procedure #f "WaveFormat"
			      ((* Wave)
			       int int int)
			      void))
	 (define WaveCopy
	   (foreign-procedure #f "WaveCopy"
			      ((& Wave))
			      (& Wave)))
	 (define WaveCrop
	   (foreign-procedure #f "WaveCrop"
			      ((* Wave)
			       int int)
			      void))
	 (define LoadWaveSamples
	   (foreign-procedure #f "LoadWaveSamples"
			      ((& Wave))
			      (* float)))
	 (define UnloadWaveSamples
	   (foreign-procedure #f "UnloadWaveSamples"
			      ((* float))
			      void))
	 (define LoadMusicStream
	   (foreign-procedure #f "LoadMusicStream"
			      (string)
			      (& Music)))
	 (define LoadMusicStreamFromMemory
	   (foreign-procedure #f "LoadMusicStreamFromMemory"
			      (string
			       (* unsigned-8)
			       int)
			      (& Music)))
	 (define UnloadMusicStream
	   (foreign-procedure #f "UnloadMusicStream"
			      ((& Music))
			      void))
	 (define PlayMusicStream
	   (foreign-procedure #f "PlayMusicStream"
			      ((& Music))
			      void))
	 (define IsMusicStreamPlaying
	   (foreign-procedure #f "IsMusicStreamPlaying"
			      ((& Music))
			      boolean))
	 (define UpdateMusicStream
	   (foreign-procedure #f "UpdateMusicStream"
			      ((& Music))
			      void))
	 (define StopMusicStream
	   (foreign-procedure #f "StopMusicStream"
			      ((& Music))
			      void))
	 (define PauseMusicStream
	   (foreign-procedure #f "PauseMusicStream"
			      ((& Music))
			      void))
	 (define ResumeMusicStream
	   (foreign-procedure #f "ResumeMusicStream"
			      ((& Music))
			      void))
	 (define SeekMusicStream
	   (foreign-procedure #f "SeekMusicStream"
			      ((& Music)
			       float)
			      void))
	 (define SetMusicVolume
	   (foreign-procedure #f "SetMusicVolume"
			      ((& Music)
			       float)
			      void))
	 (define SetMusicPitch
	   (foreign-procedure #f "SetMusicPitch"
			      ((& Music)
			       float)
			      void))
	 (define GetMusicTimeLength
	   (foreign-procedure #f "GetMusicTimeLength"
			      ((& Music))
			      float))
	 (define GetMusicTimePlayed
	   (foreign-procedure #f "GetMusicTimePlayed"
			      ((& Music))
			      float))
	 (define LoadAudioStream
	   (foreign-procedure #f "LoadAudioStream"
			      (unsigned-int unsigned-int unsigned-int)
			      (& AudioStream)))
	 (define UnloadAudioStream
	   (foreign-procedure #f "UnloadAudioStream"
			      ((& AudioStream))
			      void))
	 (define UpdateAudioStream
	   (foreign-procedure #f "UpdateAudioStream"
			      ((& AudioStream)
			       void* int)
			      void))
	 (define IsAudioStreamProcessed
	   (foreign-procedure #f "IsAudioStreamProcessed"
			      ((& AudioStream))
			      boolean))
	 (define PlayAudioStream
	   (foreign-procedure #f "PlayAudioStream"
			      ((& AudioStream))
			      void))
	 (define PauseAudioStream
	   (foreign-procedure #f "PauseAudioStream"
			      ((& AudioStream))
			      void))
	 (define ResumeAudioStream
	   (foreign-procedure #f "ResumeAudioStream"
			      ((& AudioStream))
			      void))
	 (define IsAudioStreamPlaying
	   (foreign-procedure #f "IsAudioStreamPlaying"
			      ((& AudioStream))
			      boolean))
	 (define StopAudioStream
	   (foreign-procedure #f "StopAudioStream"
			      ((& AudioStream))
			      void))
	 (define SetAudioStreamVolume
	   (foreign-procedure #f "SetAudioStreamVolume"
			      ((& AudioStream)
			       float)
			      void))
	 (define SetAudioStreamPitch
	   (foreign-procedure #f "SetAudioStreamPitch"
			      ((& AudioStream)
			       float)
			      void))
	 (define SetAudioStreamBufferSizeDefault
	   (foreign-procedure #f "SetAudioStreamBufferSizeDefault"
			      (int)
			      void))
	 ))
