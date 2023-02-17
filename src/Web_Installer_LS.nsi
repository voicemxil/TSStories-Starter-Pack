Unicode True ;Support Unicode format in the installer

;Include header files
!include "MUI2.nsh"
!include "x64.nsh"
!include ".\Downloader.nsh"
!include ".\Language-r.nsh"
!include ".\Touchup-er.nsh"

Var DXVKVER

# Names the built installer
Name "The Sims Stories Starter Pack"
# Building to:
OutFile "..\bin\Web Installer\TSStoriesStarterPack.WebInstaller-v11.exe"
# Administrator Privileges 
RequestExecutionLevel admin
# Default Installation Directory
InstallDir "$PROGRAMFILES32\The Sims Stories Starter Pack"

!define LANGID '0x7'

!macro installDXVK folderName
		DetailPrint "Placing x32 d3d9.dll in TSBin..."
		CopyFiles "$INSTDIR\temp\dxvk-2.1\x32\d3d9.dll" "$INSTDIR\${folderName}\TSBin\d3d9.dll"
		Pop $0
		DetailPrint "File copy result: $0"
		DetailPrint "Placing dxvk.conf in TSBin..."
		CopyFiles "$INSTDIR\temp\dxvk.conf" "$INSTDIR\${folderName}\TSBin\dxvk.conf"
		Pop $0
		DetailPrint "File copy result: $0"
!macroend

Function .OnInit
	Dialer::AttemptConnect
	StrCpy $DXVKVER "2.1"
	System::Call 'kernel32::GetSystemDefaultLangID() i .r7'  
FunctionEnd

###########################
brandingText "osab Web Installer v11"
!define MUI_ABORTWARNING
!define MUI_HEADERIMAGE_BITMAP_STRETCH AspectFitHeight
!define MUI_HEADERIMAGE_BITMAP "..\assets\header.bmp"
!define MUI_ICON "..\assets\NewInstaller.ico"
!define MUI_PAGE_HEADER_TEXT "TSS: Starter Pack - Web Installer"
!define MUI_PAGE_HEADER_SUBTEXT "The Sims Stories repacked by osab!"

!define MUI_WELCOMEPAGE_TITLE "osab's Sims Stories Starter Pack"
!define MUI_WELCOMEPAGE_TEXT "Welcome to the Sims Stories Starter Pack Web Installer (v11). Please ensure you have downloaded the latest version from the GitHub! Helpful log messages will be shown in the 'More Details' box."

!define MUI_LICENSEPAGE_TEXT_TOP "License Information:"

!define MUI_WELCOMEFINISHPAGE_BITMAP "..\assets\InstallerImage.bmp"
!define MUI_FINISHPAGE_SHOWREADME "https://docs.google.com/document/d/1UT0HX3cO4xLft2KozGypU_N7ZcGQVr-54QD9asFsx5U/edit#heading=h.6jnaz4t6d3vx"
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Open the next step of the guide (Graphics Setup)?"
!define MUI_FINISHPAGE_NOREBOOTSUPPORT
!define MUI_FINISHPAGE_LINK "TS2 Community Discord Server!"
!define MUI_FINISHPAGE_LINK_LOCATION "https://discord.gg/invite/ts2-community-912700195249197086"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "..\LICENSE.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_COMPONENTS
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "English"
################################

Section
	WriteUninstaller "$INSTDIR\Uninstall The Sims Stories Starter Pack.exe"	
SectionEnd

Section "TS Life Stories Starter Pack" Section1

SetOutPath "$INSTDIR\The Sims Life Stories"
SetOverwrite on
InitPluginsDir
AddSize 2500000

!insertmacro downloadPack "The Sims Life Stories" https://www.github.com/mintalien/The-Puppets-2-Definitive-Edition/releases/download/v11/SFX_LifeStories.v11.exe SFX_LifeStories.exe "77263efcea8d73d38c4284815ea88f971c534f5d3569cd5a4cdce3fe534b4696"

# Touchup
DetailPrint "Touching Up LS..."
!insertmacro touchup "The Sims Life Stories" "Electronic Arts\The Sims Life Stories" "{DA932D71-E52A-43D5-009E-395A1AEC1474}" "SimsLS.exe"

!insertmacro setLanguage "Electronic Arts\The Sims Life Stories"

DetailPrint "Creating Downloads folder..."
CreateDirectory "$Documents\Electronic Arts\The Sims Life Stories\Downloads" 
ExecShell "open" "$INSTDIR"
SectionEnd

Section "TS Pet Stories Starter Pack" Section2

SetOutPath "$INSTDIR\The Sims Pet Stories"
SetOverwrite on
InitPluginsDir
AddSize 2800000

!insertmacro downloadPack "The Sims Pet Stories" https://www.github.com/mintalien/The-Puppets-2-Definitive-Edition/releases/download/v11/SFX_PetStories.v11.exe SFX_PetStories.exe "8b42b1c985b5fe04d94de2c32e30615397bc5214c4c68f7c34ab6cf7df6bd9d5"

# Touchup
DetailPrint "Touching Up PS..."
!insertmacro touchup "The Sims Pet Stories" "Electronic Arts\The Sims Pet Stories" "{DA932D71-E52A-43D5-009E-395A1AEC1474}" "SimsPS.exe"

!insertmacro setLanguage "Electronic Arts\The Sims Pet Stories"

DetailPrint "Creating Downloads folder..."
CreateDirectory "$Documents\Electronic Arts\The Sims Pet Stories\Downloads" 
ExecShell "open" "$INSTDIR"
SectionEnd
	
Section "TS Castaway Stories Starter Pack" Section3

SetOutPath "$INSTDIR\The Sims Castaway Stories"
SetOverwrite on
InitPluginsDir
AddSize 3000000

CreateDirectory "$INSTDIR\temp"
!insertmacro downloadPack "The Sims Castaway Stories" https://www.github.com/mintalien/The-Puppets-2-Definitive-Edition/releases/download/v11/SFX_CastawayStories.v11.exe SFX_CastawayStories.exe "2E519CF30E252710CBB93CA8F2EA4BE1FCD5CA0365BF999D40D434A6B657E8DA"

# Touchup
DetailPrint "Touching Up CS..."
!insertmacro touchup "The Sims Castaway Stories" "Electronic Arts\The Sims Castaway Stories" "{DA932D71-E52A-43D5-009E-395A1AEC1474}" "SimsCS.exe"

!insertmacro setLanguage "Electronic Arts\The Sims Castaway Stories"

DetailPrint "Creating Downloads folder..."
CreateDirectory "$Documents\Electronic Arts\The Sims Castaway Stories\Downloads" 
ExecShell "open" "$INSTDIR"
SectionEnd

Section "Graphics Rules Maker" Section4
	CreateDirectory "$INSTDIR\temp"
	${If} ${RunningX64}
		inetc::get /POPUP "Downloading GRM Setup (64-bit detected)..." "https://www.simsnetwork.com/files/graphicsrulesmaker/graphicsrulesmaker-2.0.0-64bit.exe" "$INSTDIR\temp\grm_install.exe"
		Pop $0 # return value = exit code, "OK" means OK
		DetailPrint "GRM download status: $0. Executing installer..." 
	${Else}
		inetc::get /POPUP "Downloading GRM Setup (32-bit detected)..." "https://www.simsnetwork.com/files/graphicsrulesmaker/graphicsrulesmaker-2.0.0-32bit.exe" "$INSTDIR\temp\grm_install.exe"
		Pop $0 # return value = exit code, "OK" means OK
		DetailPrint "GRM download status: $0. Executing installer..." 
	${EndIf}
		Execwait $INSTDIR\temp\grm_install.exe
		Delete $INSTDIR\temp\grm_install.exe
		RMDir /r $INSTDIR\temp
		Pop $0
		DetailPrint "Cleanup result: $0"
SectionEnd

Section /o "DXVK" Section5
	CreateDirectory "$INSTDIR\temp"
	inetc::get /POPUP "Preparing Vulkan Test..." "https://github.com/skeeto/vulkan-test/releases/download/1.0.2/vulkan_test.exe" "temp\vulkan_test.exe"
	ExecWait "$INSTDIR\temp\vulkan_test.exe"
	Delete "$INSTDIR\temp\vulkan_test.exe"
	RMDir "$INSTDIR\temp"
	MessageBox MB_YESNO "DXVK requires Vulkan support. If the message box said it successfully created a Vulkan instance, click Yes. Otherwise, click NO." IDYES true IDNO false
	true:
		DetailPrint "Downloading DXVK $DXVKVER ..."
		inetc::get /POPUP "Downloading DXVK..." "https://github.com/doitsujin/dxvk/releases/download/v2.1/dxvk-2.1.tar.gz" "$INSTDIR\temp\dxvk.tar.gz"
		Pop $0 # return value = exit code, "OK" means OK
		DetailPrint "DXVK download status: $0. Extracting..." 

		inetc::get /POPUP "Downloading DXVK.conf..." "https://raw.githubusercontent.com/doitsujin/dxvk/v2.1/dxvk.conf" "$INSTDIR\temp\dxvk.conf"
		Pop $0
		DetailPrint "DXVK.conf download status: $0." 

		untgz::extract -h -u -d "$INSTDIR\temp" -zgz "$INSTDIR\temp\dxvk.tar.gz"
		Pop $0 
		DetailPrint "DXVK extraction status: $0. Deleting archive..." 
		Delete "$INSTDIR\temp\dxvk.tar.gz"
		Pop $0
		DetailPrint "Cleanup result: $0"
	${If} ${SectionIsSelected} ${Section1}
		!insertmacro installDXVK "The Sims Life Stories"
	${EndIf}
	${If} ${SectionIsSelected} ${Section2}
		!insertmacro installDXVK "The Sims Pet Stories"
	${EndIf}
	${If} ${SectionIsSelected} ${Section3}
		!insertmacro installDXVK "The Sims Castaway Stories"
	${EndIf}
		RMDir /r "$INSTDIR\temp\dxvk-2.1"
		RMDir /r "$INSTDIR\temp"
		Pop $0
		DetailPrint "Cleanup result: $0"
	false:
		DetailPrint "Vulkan is unsupported, DXVK will be skipped."
	next:
		DetailPrint "DXVK section complete."
		RMDir /r "$INSTDIR\temp"
SectionEnd
	
Section "Visual C++ Redist" Section6
	CreateDirectory "$INSTDIR\temp"	
	inetc::get /POPUP "Downloading VC Redist..." "https://aka.ms/vs/17/release/vc_redist.x86.exe" "temp\vc_redist.x86.exe"
	Pop $0
	DetailPrint "VC Redist download status: $0"
	ExecWait "$INSTDIR\temp\vc_redist.x86.exe /q /norestart"
	Delete "$INSTDIR\temp\vc_redist.x86.exe"
	RMDir /r "$INSTDIR\temp"
		Pop $0
		DetailPrint "Cleanup result: $0"	
SectionEnd
	
	
Section "Sim Shadow Fix" Section7
	SetOutPath "$INSTDIR\temp"
	inetc::get /POPUP "Downloading SimNopke's Shadow Fix" "https://github.com/voicemxil/TS2-Starter-Pack/raw/v11/components/simNopke-simShadowFix0.3reallyNotMisty.package" "simNopke-simShadowFix0.3reallyNotMisty.package"
	Pop $0
	DetailPrint "Shadow Fix download status: $0"
	${If} ${SectionIsSelected} ${Section1}
		CopyFiles "simNopke-simShadowFix0.3reallyNotMisty.package" "$Documents\Electronic Arts\The Sims Life Stories\Downloads\simNopke-simShadowFix0.3reallyNotMisty.package"
	${EndIf}
	${If} ${SectionIsSelected} ${Section2}
		CopyFiles "simNopke-simShadowFix0.3reallyNotMisty.package" "$Documents\Electronic Arts\The Sims Pet Stories\Downloads\simNopke-simShadowFix0.3reallyNotMisty.package"
	${EndIf}
	${If} ${SectionIsSelected} ${Section3}
		CopyFiles "simNopke-simShadowFix0.3reallyNotMisty.package" "$Documents\Electronic Arts\The Sims Pet Stories\Downloads\simNopke-simShadowFix0.3reallyNotMisty.package"
	${EndIf}
	Delete "simNopke-simShadowFix0.3reallyNotMisty.package"
	SetOutPath $INSTDIR
	RMDir "$INSTDIR\temp"
SectionEnd

Section "Start Menu/Desktop Shortcuts" Section8
	SetShellVarContext current
	${If} ${SectionIsSelected} ${Section1}
		CreateDirectory '$SMPROGRAMS\The Sims Stories Starter Pack\'
		CreateShortCut '$SMPROGRAMS\The Sims Stories Starter Pack\The Sims Life Stories.lnk' '$INSTDIR\The Sims Life Stories\TSBin\SimsLS.exe' "" '$INSTDIR\The Sims Life Stories\TSBin\SimsLS.exe' 0
		CreateShortCut '$Desktop\The Sims Life Stories.lnk' '$INSTDIR\The Sims Life Stories\TSBin\SimsLS.exe' "" '$INSTDIR\The Sims Life Stories\TSBin\SimsLS.exe' 0
	${EndIf}
	${If} ${SectionIsSelected} ${Section2}
		CreateDirectory '$SMPROGRAMS\The Sims Stories Starter Pack\'
		CreateShortCut '$SMPROGRAMS\The Sims Stories Starter Pack\The Sims Pet Stories.lnk' '$INSTDIR\The Sims Pet Stories\TSBin\SimsPS.exe' "" '$INSTDIR\The Sims Pet Stories\TSBin\SimsPS.exe' 0
		CreateShortCut '$Desktop\The Sims Pet Stories.lnk' '$INSTDIR\The Sims Pet Stories\TSBin\SimsPS.exe' "" '$INSTDIR\The Sims Pet Stories\TSBin\SimsPS.exe' 0
	${EndIf}
	${If} ${SectionIsSelected} ${Section3}
		CreateDirectory '$SMPROGRAMS\The Sims Stories Starter Pack\'
		CreateShortCut '$SMPROGRAMS\The Sims Stories Starter Pack\The Sims Castaway Stories.lnk' '$INSTDIR\The Sims Castaway Stories\TSBin\SimsCS.exe' "" '$INSTDIR\The Sims Castaway Stories\TSBin\SimsCS.exe' 0
		CreateShortCut '$Desktop\The Sims Castaway Stories.lnk' '$INSTDIR\The Sims Castaway Stories\TSBin\SimsCS.exe' "" '$INSTDIR\The Sims Castaway Stories\TSBin\SimsCS.exe' 0
	${EndIf}
SectionEnd 

Section "Uninstall" uninstall
	SetRegView 32
	Delete "Uninstall The Sims Stories Starter Pack.exe"
	ReadRegStr $R4 HKLM32 "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\The Sims Life Stories" "FolderName" 
	RMDir /r $R4
	DeleteRegKey HKLM32 "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\The Sims Life Stories"
	DeleteRegKey HKLM32 "SOFTWARE\Electronic Arts\The Sims Life Stories"
	DeleteRegKey HKLM32 "Software\Microsoft\Windows\CurrentVersion\App Paths\SimsLS.exe"
	ReadRegStr $R4 HKLM32 "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\The Sims Pet Stories" "FolderName" 
	RMDir /r $R4
	DeleteRegKey HKLM32 "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\The Sims Pet Stories"
	DeleteRegKey HKLM32 "SOFTWARE\Electronic Arts\The Sims Pet Stories"
	DeleteRegKey HKLM32 "Software\Microsoft\Windows\CurrentVersion\App Paths\SimsPS.exe"
	ReadRegStr $R4 HKLM32 "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\The Sims Castaway Stories" "FolderName" 
	RMDir /r $R4
	DeleteRegKey HKLM32 "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\The Sims Castaway Stories"
	DeleteRegKey HKLM32 "SOFTWARE\Electronic Arts\The Sims Castaway Stories"
		DeleteRegKey HKLM32 "Software\Microsoft\Windows\CurrentVersion\App Paths\SimsCS.exe"
SectionEnd

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${Section1} "The Sims Life Stories"
  !insertmacro MUI_DESCRIPTION_TEXT ${Section2} "The Sims Pet Stories"
  !insertmacro MUI_DESCRIPTION_TEXT ${Section3} "The Sims Castaway Stories"
  !insertmacro MUI_DESCRIPTION_TEXT ${Section4} "Installs Graphics Rules Maker 2.0.0."
  !insertmacro MUI_DESCRIPTION_TEXT ${Section5} "Installs DXVK $DXVKVER. (Not recommended for beginners.)"
  !insertmacro MUI_DESCRIPTION_TEXT ${Section6} "Installs Visual C++ Redist (x86) if not already installed."
  !insertmacro MUI_DESCRIPTION_TEXT ${Section7} "Installs SimNopke's Sim Shadow Fix to your downloads folder. *Don't Use With DXVK*."
  !insertmacro MUI_DESCRIPTION_TEXT ${Section8} "Create a shortuct to launch the game in your Start Menu/Desktop."

!insertmacro MUI_FUNCTION_DESCRIPTION_END
