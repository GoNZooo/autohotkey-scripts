#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#IncludeAgain Clip.ahk

OpenOrSwitchTo(exe_name, application_path, group_name)
{
  IfWinExist, ahk_group %group_name%
    GroupActivate, %group_name%, R
  else
    Run, %application_path%
  Return
}

InsertCurrentTime()
{
  FormatTime, Time, A_Now, ddd dd-MM-yyyy HH:mm
  Clip(Time)
  Return
}

InsertCurrentTimeMachineFormat()
{
  FormatTime, Time, % A_NowUTC, yyyy_MM_dd_HHmmss
  Clip(Time)
  Return
}

AddToFGroup(ByRef processes, ByRef index)
{
  WinGet, active_id, ID, A
  processes.Push(active_id)

  Return
}

SwitchToFGroup(ByRef processes, ByRef index)
{
  index_process := processes[index]
  if WinActive("ahk_id " . index_process)
  {
    max_index := processes.MaxIndex()
    index := Mod(index, max_index) + 1
  }
  index_process := processes[index]
  WinActivate, ahk_id %index_process%

  Return
}

ClearFGroup(ByRef processes, ByRef index)
{
  processes := []
  index := 1

  Return
}

BrowserExe := "firefox.exe"
BrowserStart := "C:\Program Files\Mozilla Firefox\firefox.exe"
BrowserGroup := "Browser"

VSCodeExe := "Code.exe"
VSCodeStart := "C:\Users\ricka\AppData\Local\Programs\Microsoft VS Code\Code.exe --new-window"
VSCodeGroup := "VSCode"

TerminalExe := "WindowsTerminal.exe"
TerminalStart := "wt.exe"
TerminalGroup := "Terminal"

EmailStart := "C:\Program Files\Mozilla Thunderbird\thunderbird.exe"
EmailExe := "thunderbird.exe"
EmailGroup := "Email"

global F1Processes := []
global F1Index := 1
global F2Processes := []
global F2Index := 1
global F3Processes := []
global F3Index := 1
global F4Processes := []
global F4Index := 1

GroupAdd, %BrowserGroup%, ahk_exe %BrowserExe%
GroupAdd, %TerminalGroup%, ahk_exe %TerminalExe%
GroupAdd, %VSCodeGroup%, ahk_exe %VSCodeExe%
GroupAdd, %EmailGroup%, ahk_exe %EmailExe%

>!1:: OpenOrSwitchTo(BrowserExe, BrowserStart, BrowserGroup)
>!2:: OpenOrSwitchTo(TerminalExe, TerminalStart, TerminalGroup)
>!3:: OpenOrSwitchTo(VSCodeExe, VSCodeStart, VSCodeGroup)
>!4:: OpenOrSwitchTo(EmailExe, EmailStart, EmailGroup)
>!h:: Send, {^}{Space}
>!t:: InsertCurrentTime()
>!n:: InsertCurrentTimeMachineFormat()
>!F12:: Reload

^!1:: OpenOrSwitchTo(BrowserExe, BrowserStart, BrowserGroup)
^!2:: OpenOrSwitchTo(TerminalExe, TerminalStart, TerminalGroup)
^!3:: OpenOrSwitchTo(VSCodeExe, VSCodeStart, VSCodeGroup)
^!4:: OpenOrSwitchTo(EmailExe, EmailStart, EmailGroup)
^!h:: Send, {^}{Space}
^!t:: InsertCurrentTime()
^!n:: InsertCurrentTimeMachineFormat()
^!F12:: Reload

^!CapsLock:: Send, {CapsLock}
CapsLock:: Send, {Escape}
