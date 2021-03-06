#define MyAppName "Godot Engine"
#define MyAppVersion "4.0.dev"
#define MyAppPublisher "Godot Engine contributors"
#define MyAppURL "https://hugo.pro/projects/godot-builds/"
#define MyAppExeName "godot.exe"

[Setup]
AppId={{757DA64B-400E-40F5-B073-A796C34D9D78}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
; Don't add "version {version}" to the installed app name in the Add/Remove Programs menu
AppVerName={#MyAppName}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL=https://godotengine.org/
AppUpdatesURL={#MyAppURL}
AppComments=Unofficial Godot Engine editor build
ChangesEnvironment=yes
DefaultDirName={localappdata}\Godot
DefaultGroupName=Godot Engine
AllowNoIcons=yes
UninstallDisplayIcon={app}\{#MyAppExeName}
#ifdef App32Bit
  OutputBaseFilename=godot-setup-nightly-x86
#else
  OutputBaseFilename=godot-setup-nightly-x86_64
  ArchitecturesAllowed=x64
  ArchitecturesInstallIn64BitMode=x64
#endif
Compression=lzma
SolidCompression=yes
PrivilegesRequired=lowest

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "modifypath"; Description: "Add Godot to PATH environment variable"

[Files]
Source: "{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[Code]
const
    ModPathName = 'modifypath';
    ModPathType = 'user';

function ModPathDir(): TArrayOfString;
begin
    setArrayLength(Result, 1)
    Result[0] := ExpandConstant('{app}');
end;

#include "modpath.pas"
