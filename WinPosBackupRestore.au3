;
;  �E�B���h�E�ʒu�L���񕜃c�[��
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
$Form1 = GUICreate("�E�B���h�E�ʒu��", 615, 437, 192, 124)
GUISetFont(9, 400, 0, "�l�r �o�S�V�b�N")
GUISetOnEvent($GUI_EVENT_CLOSE, "Form1Close")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "Form1Minimize")
GUISetOnEvent($GUI_EVENT_MAXIMIZE, "Form1Maximize")
GUISetOnEvent($GUI_EVENT_RESTORE, "Form1Restore")
$lvWinInfo1 = GUICtrlCreateListView("Title|Handle|X|Y|Width|Height", 32, 16, 553, 351)
GUICtrlSetFont(-1, 10, 400, 0, "UD �f�W�^�� ���ȏ��� N-R")
GUICtrlSetOnEvent(-1, "lvWinInfo1Click")
$btnStore = GUICtrlCreateButton("�z�u�L��", 32, 376, 153, 49)
GUICtrlSetFont(-1, 12, 400, 0, "UD �f�W�^�� ���ȏ��� NP-R")
GUICtrlSetOnEvent(-1, "btnStoreClick")
$btnRestore = GUICtrlCreateButton("�Ĕz�u", 201, 376, 153, 49)
GUICtrlSetFont(-1, 12, 400, 0, "UD �f�W�^�� ���ȏ��� NP-R")
GUICtrlSetOnEvent(-1, "btnRestoreClick")
$btnQuit = GUICtrlCreateButton("�I��", 432, 376, 153, 49)
GUICtrlSetFont(-1, 12, 400, 0, "UD �f�W�^�� ���ȏ��� NP-R")
GUICtrlSetOnEvent(-1, "btnQuitClick")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

; _DebugSetup("Window Info", True);

dim $WinList[1][6]  ; Window�����i�[�B��Ŕz��T�C�Y�Ē�������

While 1
	Sleep(100)
WEnd

Func btnStoreClick() ; �z�u�L��
	Local $tmp = WinList()
	Local $s = 0
	GUICtrlDelete($lvWinInfo1) ; Item�����̂��߂�lvWinInfo���Ə���^^;
	$lvWinInfo1 = GUICtrlCreateListView("Title|Handle|X|Y|Width|Height", 32, 16, 553, 351) ; �ēo�^

	For $i = 1 To $tmp[0][0]  ; $varp0][0]�ɗv�f�����i�[����Ă���
		; ���Ŗ��O�̂���E�B���h�E�݂̂�\������B DeskTop�iProgram Manager)�͏��O����
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
	$WinList[0][0] = $s - 1  ; �i�[�����v�f�����L�����Ă���
EndFunc

Func btnRestoreClick() ; �Ĕz�u
	For $i = 1 To $WinList[0][0]
		WinMove($WinList[$i][1], "", $WinList[$i][2], $WinList[$i][3], $WinList[$i][4], $WinList[$i][5])
	Next
EndFunc

Func btnQuitClick() ; �I��
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

Func lvWinInfo1Click()  ; ListView���N���b�N����Ă����ɂ�邱�ƂȂ��B

EndFunc

Func IsVisible($handle)
    If BitAND(WinGetState($handle), 2) Then
        Return 1
    Else
        Return 0
    EndIf
EndFunc   ;==>IsVisible

