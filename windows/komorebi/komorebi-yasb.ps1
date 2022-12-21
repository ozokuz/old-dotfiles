$folder = "$env:LocalAppData\Programs\yasb"

cd $folder

& $folder\env\Scripts\Activate.ps1

pythonw.exe src\main.py
