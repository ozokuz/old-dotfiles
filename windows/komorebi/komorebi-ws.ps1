$komorebic = "C:\Users\$env:username\scoop\apps\komorebi\current\komorebic.exe"

for ($i = 0; $i -lt 9; $i++) {
  & $komorebic workspace-padding 0 $i 8
  & $komorebic container-padding 0 $i 8
}

& $komorebic workspace-name 0 0 "`u{fb6e} "
& $komorebic workspace-name 0 1 "`u{f26b} "
& $komorebic workspace-name 0 2 "`u{f668} "
& $komorebic workspace-name 0 3 "`u{e615} "
& $komorebic workspace-name 0 4 "`u{f6e6} "
& $komorebic workspace-name 0 5 "`u{f962} "
& $komorebic workspace-name 0 6 "`u{f1b6} "
& $komorebic workspace-name 0 7 "`u{f232} "
& $komorebic workspace-name 0 8 "`u{f1bc} "
 
# & $komorebic workspace-name 0 0 💬
# & $komorebic workspace-name 0 1 🌍
# & $komorebic workspace-name 0 2 📝
# & $komorebic workspace-name 0 3 🔧
# & $komorebic workspace-name 0 4 📚
# & $komorebic workspace-name 0 5 🚀
# & $komorebic workspace-name 0 6 🎮
# & $komorebic workspace-name 0 7 💬
# & $komorebic workspace-name 0 8 🎵

