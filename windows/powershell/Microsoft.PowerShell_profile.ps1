# Encoding
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Imports
Import-Module posh-git
Import-Module Terminal-Icons
Import-Module cd-extras
Import-Module PSFzf

# Enable Prediction
Set-PSReadLineOption -PredictionSource History

# Fzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Custom Commands
## Java
function java8 {
  $ENV:JAVA_HOME = "C:\Users\$env:username\scoop\apps\temurin8-jdk\current"
  $ENV:PATH = "$ENV:JAVA_HOME\bin;$ENV:PATH"

  java -version
}

function java17 {
  $ENV:JAVA_HOME = "C:\Users\$env:username\scoop\apps\temurin17-jdk\current"
  $ENV:PATH = "$ENV:JAVA_HOME\bin;$ENV:PATH"

  java -version
}

## Windows Terminal - New Tab in PWD
function th {
  wt.exe -w 0 nt pwsh -nologo -wd $pwd
}

## Simplify yt-dlp usage
function ytdlm {
  yt-dlp.exe -x --audio-format mp3 --output "%(title)s.%(ext)s" $args
}

## Which
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

## z w/ fzf
function zz {
  Invoke-FuzzyZLocation
}

$editorconfig = @"
[*]
charset = utf-8
insert_final_newline = true
trim_trailing_whitespace = true
end_of_line = lf
indent_style = space
indent_size = 2
max_line_length = 80
"@

## Create EditorConfig
function ec {
  echo $editorconfig | Out-File .\.editorconfig
}

# Aliases
Set-Alias v nvim
Set-Alias l ls
Set-Alias g git
Set-Alias lg lazygit

# Completion
packwiz completion powershell | Out-String | Invoke-Expression

# Prompt
Invoke-Expression (&starship init powershell)

# z
Import-Module ZLocation

# Fix Prompt
clear

