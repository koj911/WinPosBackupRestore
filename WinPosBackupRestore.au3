;
;  ウィンドウ位置記憶回復ツール
;          koj
;          @koj911
;          https://www.ofug.net/koj/
;
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <WindowsConstants.au3>
#include <Array.au3>
#include <Debug.au3>
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("ウィンドウ位置回復", 615, 437, 192, 124)
GUISetFont(9, 400, 0, "ＭＳ Ｐゴシック")
GUISetOnEvent($GUI_EVENT_CLOSE, "Form1Close")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "Form1Minimize")
GUISetOnEvent($GUI_EVENT_MAXIMIZE, "Form1Maximize")
GUISetOnEvent($GUI_EVENT_RESTORE, "Form1Restore")
$lvWinInfo1 = GUICtrlCreateListView("Title|Handle|X|Y|Width|Height", 32, 16, 553, 351)
GUICtrlSetFont(-1, 10, 400, 0, "UD デジタル 教科書体 N-R")
GUICtrlSetOnEvent(-1, "lvWinInfo1Click")
$btnStore = GUICtrlCreateButton("配置記憶", 32, 376, 153, 49)
GUICtrlSetFont(-1, 12, 400, 0, "UD デジタル 教科書体 NP-R")
GUICtrlSetOnEvent(-1, "btnStoreClick")
$btnRestore = GUICtrlCreateButton("再配置", 201, 376, 153, 49)
GUICtrlSetFont(-1, 12, 400, 0, "UD デジタル 教科書体 NP-R")
GUICtrlSetOnEvent(-1, "btnRestoreClick")
$btnQuit = GUICtrlCreateButton("終了", 432, 376, 153, 49)
GUICtrlSetFont(-1, 12, 400, 0, "UD デジタル 教科書体 NP-R")
GUICtrlSetOnEvent(-1, "btnQuitClick")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

; _DebugSetup("Window Info", True);

dim $WinList[1][6]  ; Window情報を格納。後で配列サイズ再調整する

While 1
	Sleep(100)
WEnd

Func btnStoreClick() ; 配置記憶
	Local $tmp = WinList()
	Local $s = 0
	GUICtrlDelete($lvWinInfo1) ; Item消去のためにlvWinInfoごと消す^^;
	$lvWinInfo1 = GUICtrlCreateListView("Title|Handle|X|Y|Width|Height", 32, 16, 553, 351) ; 再登録

	For $i = 1 To $tmp[0][0]  ; $varp0][0]に要素数が格納されている
		; 可視で名前のあるウィンドウのみを表示する。 DeskTop（Program Manager)は除外する
        If $tmp[$i][0] <> "" And IsVisible($tmp[$i][1]) And $tmp[$i][0] <> "Program Manager" Then
            ReDim $WinList[$s + 1][6]
            $WinList[$s][0] = $tmp[$i][0] ; Window Title
            $WinList[$s][1] = $tmp[$i][1] ; Window Handle
    		Local $pos = WinGetPos($WinList[$s][1])
    		$WinList[$s][2] = $pos[0] ; X-Pos
    		$WinList[$s][3] = $pos[1] ; Y-Pos
    		$WinList[$s][4] = $pos[2] ; Width
    		$WinList[$s][5] = $pos[3] ; Height
			GUICtrlCreateListViewItem( StringFormat ("%-10s | %10d | %4d | %4d | %4d | %4d", $WinList[$s][0], $WinList[$s][1], $WinList[$s][2], $WinList[$s][3], $WinList[$s][4], $WinList[$s][5]), $lvWinInfo1 )
            $s += 1
        EndIf
    Next
	$WinList[0][0] = $s - 1  ; 格納した要素数を記憶しておく
EndFunc

Func btnRestoreClick() ; 再配置
	For $i = 1 To $WinList[0][0]
		WinMove($WinList[$i][1], "", $WinList[$i][2], $WinList[$i][3], $WinList[$i][4], $WinList[$i][5])
	Next
EndFunc

Func btnQuitClick() ; 終了
  Exit
EndFunc

Func Form1Close()
  Exit
EndFunc

Func Form1Maximize()

EndFunc
Func Form1Minimize()

EndFunc

Func Form1Restore()

EndFunc

Func lvWinInfo1Click()  ; ListViewがクリックされても特にやることなし。

EndFunc

Func IsVisible($handle)
    If BitAND(WinGetState($handle), 2) Then
        Return 1
    Else
        Return 0
    EndIf
EndFunc   ;==>IsVisible

