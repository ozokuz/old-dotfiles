$komorebic = "C:\Users\$env:username\scoop\apps\komorebi\current\komorebic.exe"

$screenCount = 2
$workspaceCount = 9
$padding = 8

$workspaceIcons = @{
  0 = "`u{fa9e} " <# Web #>,
      "`u{f02e} " <# Bookmark #>,
      "`u{f718} " <# Document #>,
      "`u{f668} " <# Code #>,
      "`u{e7c5} " <# Vim #>,
      "`u{f6e6} " <# Globe #>,
      "`u{f6c4} " <# Desktop #>,
      "`u{f962} " <# Rocket #>,
      "`u{f7b3} " <# Controller #>;
  1 = "`u{fb6e} " <# Discord #>,
      "`u{f26b} " <# Internet Explorer :D #>,
      "`u{f489} " <# Terminal #>,
      "`u{f121} " <# Code #>,
      "`u{e615} " <# Config #>,
      "`u{f65e} " <# Cloud #>,
      "`u{f1b6} " <# Steam #>,
      "`u{f232} " <# WhatsApp #>,
      "`u{f1bc} " <# Spotify #>
}

$workspaceRules = @{
  1 = @{ Type = "exe"; Name = "Discord.exe"; Workspace = 0 },
      @{ Type = "exe"; Name = "steam.exe"; Workspace = 6 },
      @{ Type = "exe"; Name = "WhatsApp.exe"; Workspace = 7 },
      @{ Type = "exe"; Name = "Signal.exe"; Workspace = 7 },
      @{ Type = "exe"; Name = "Spotify.exe"; Workspace = 8 },
      @{ Type = "exe"; Name = "WaveLink.exe"; Workspace = 8 }
}

for ($screen = 0; $screen -lt $screenCount; $screen++) {
  & $komorebic ensure-workspaces $screen $workspaceCount

  for ($workspace = 0; $workspace -lt $workspaceCount; $workspace++) {
    & $komorebic workspace-padding $screen $workspace $padding
    & $komorebic container-padding $screen $workspace $padding

    & $komorebic workspace-name $screen $workspace $workspaceIcons[$screen][$workspace]
  }

  $screenRules = $workspaceRules[$screen]

  for ($i = 0; $i -lt $screenRules.Length; $i++) {
    $rule = $screenRules[$i]

    & $komorebic workspace-rule $rule.Type $rule.Name $screen $rule.Workspace
  }
}

# & $komorebic workspace-rule "exe" "WhatsApp.exe" 1 7
# & $komorebic workspace-rule "exe" "Spotify.exe" 1 8
# & $komorebic workspace-rule "exe" "WaveLink.exe" 1 8

