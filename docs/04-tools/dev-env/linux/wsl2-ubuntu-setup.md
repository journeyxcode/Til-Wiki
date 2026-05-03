---
sidebar_position: 1
title: WSL2 + Ubuntu 설치 완전 가이드 (Windows 11)
description: Windows 11에서 WSL2를 설치하고 Ubuntu를 설정하는 단계별 튜토리얼
tags: [WSL2, Ubuntu, Windows, 개발환경]
---

# WSL2 + Ubuntu 설치 완전 가이드 (Windows 11)

> 직접 삽질하며 정리한 WSL2 설치 튜토리얼입니다.  
> C 드라이브 용량이 부족한 경우 외부 드라이브에 설치하는 방법까지 다룹니다.

---

## 🛠️ Step 1. 사전 준비 (WSL 설치 전 필수)

WSL 설치 전에 Windows 기능을 먼저 활성화해야 합니다.

### 방법 A. GUI (제어판)

**`Windows 키 + R`** → `optionalfeatures` 입력 → Enter

또는

**제어판** → 프로그램 → **Windows 기능 켜기/끄기**

아래 두 항목을 체크 후 **확인** → 재부팅:
- ✅ Linux용 Windows 하위 시스템
- ✅ 가상 머신 플랫폼

### 방법 B. PowerShell (관리자 권한)

> ⚠️ **왜 관리자 권한이 필요한가요?**  
> WSL 설치와 Windows 기능 변경은 시스템 레벨 작업입니다.  
> 일반 권한으로 실행하면 `Access Denied` 오류가 발생하므로 반드시 관리자 권한으로 실행해야 합니다.  
> `Windows 키 + X` → **터미널(관리자)** 클릭으로 열 수 있습니다.

아래 명령어는 **DISM(Deployment Image Servicing and Management)** 도구를 사용합니다.  
DISM은 Windows의 시스템 기능을 켜고 끄는 내장 도구입니다.

```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

실행 후 **재부팅** 필수!

### ✔️ 활성화 여부 확인

```powershell
Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
Get-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
```

둘 다 `State: Enabled` 이면 다음 단계로 진행합니다.

---

## ✅ Step 2. WSL 설치 상태 확인

PowerShell을 **관리자 권한**으로 열고 아래 명령어를 실행합니다.

```powershell
wsl --status
```

**정상 출력 예시:**
```
기본 버전: 2
```

`기본 버전: 2` 가 출력되면 Step 3으로 넘어갑니다.  
오류가 뜬다면 아래 **WSL 재설치** 단계를 먼저 진행하세요.

### WSL 재설치 (오류 발생 시)

```powershell
winget uninstall Microsoft.WSL
winget install Microsoft.WSL
```

> `Wsl/CallMsi/Install/REGDB_E_CLASSNOTREG` 오류가 발생한 경우 이 방법으로 해결할 수 있습니다.

재설치 후 다시 확인:

```powershell
wsl --status
# 기본 버전: 2 → 정상
```

---

## 🐧 Step 3. Ubuntu 설치

### C 드라이브 여유 공간 먼저 확인

```powershell
Get-PSDrive C | Select-Object Used, Free
```

결과값은 **bytes 단위**로 출력됩니다.

**변환 예시:**
```
Used              Free
----              ----
75432570880       172894126080
```
- `172894126080 bytes` ÷ 1,073,741,824 ≈ **약 161GB 여유**

- **Free가 3GB(3,221,225,472 bytes) 이상** → 방법 A (C 드라이브 바로 설치)
- **Free가 부족** → 방법 B (외부 드라이브 설치)

---

### 방법 A. C 드라이브에 바로 설치 (기본)

```powershell
wsl --install -d Ubuntu-24.04
```

설치 완료 후 Ubuntu 터미널이 자동으로 열리며 username/password 설정 화면이 나타납니다.

---

### 방법 B. 외부 드라이브에 설치

WSL은 설치 시 무조건 C 드라이브를 먼저 거쳐야 합니다.  
따라서 **C에 설치 → export → 외부 드라이브로 import** 순서로 진행합니다.

> ⚠️ **export / unregister / import 가 왜 필요한가요?**  
> WSL은 `ext4.vhdx` 라는 가상 디스크 파일 형태로 저장되며, 기본적으로 C 드라이브에만 생성됩니다.  
> 이를 다른 드라이브로 옮기려면 tar 파일로 내보낸(export) 후, 원하는 위치에 다시 등록(import)해야 합니다.  
> `--unregister` 는 C 드라이브의 기존 등록을 **삭제**하는 명령어입니다.  
> 반드시 export를 먼저 완료한 후 실행하세요. 순서가 바뀌면 데이터가 손실됩니다.

**Step 3-1.** Ubuntu 설치

```powershell
wsl --install -d Ubuntu-24.04
```

**Step 3-2.** C 드라이브에 export (백업)

```powershell
wsl --export Ubuntu-24.04 C:\WSL\ubuntu.tar
```

**Step 3-3.** 기존 등록 해제

```powershell
# ⚠️ 이 명령어는 C 드라이브의 Ubuntu 데이터를 삭제합니다.
# Step 3-2의 export가 완료된 후에만 실행하세요.
wsl --unregister Ubuntu-24.04
```

**Step 3-4.** 원하는 드라이브로 import

```powershell
# 예시: D 드라이브에 설치하는 경우
wsl --import Ubuntu-24.04 D:\WSL\Ubuntu D:\WSL\ubuntu.tar
```

> 💡 `D:\WSL\Ubuntu` 폴더는 자동으로 생성됩니다. 미리 만들 필요 없어요.

---

## ✔️ Step 4. 설치 확인

```powershell
wsl --list --verbose
```

**정상 출력 예시:**
```
  NAME            STATE           VERSION
* Ubuntu-24.04    Stopped         2
```

| 항목 | 의미 |
|------|------|
| `VERSION 2` | WSL2로 정상 설치됨 |
| `* 표시` | 기본 배포판으로 설정됨 |
| `Stopped` | 현재 실행 중이 아님 (정상) |

---

## 🚀 Step 5. Ubuntu 실행 및 초기 설정

```powershell
wsl -d Ubuntu-24.04
```

처음 실행 시 username과 password를 설정합니다.

> ⚠️ **username 규칙**  
> Linux username은 아래 규칙을 따라야 합니다. 규칙을 어기면 오류가 발생합니다.
> - ✅ 소문자 영문 (a-z)
> - ✅ 숫자 (0-9)
> - ✅ 하이픈 (-), 언더스코어 (_)
> - ❌ 대문자 사용 불가
> - ❌ 공백, 특수문자 사용 불가
> - ❌ 숫자로 시작 불가

**설정 예시:**
```
Enter new UNIX username: myuser
Enter new password: ********
Retype new password: ********
```

> 💡 password 입력 시 화면에 아무것도 표시되지 않는 것이 정상입니다. 그냥 입력하고 Enter를 누르세요.

설정 완료 후 아래와 같은 프롬프트가 뜨면 성공입니다:
```
myuser@DESKTOP:~$
```

---

## 📦 Step 6. 기본 패키지 업데이트

Ubuntu 터미널에서 아래 명령어를 실행합니다:

```bash
sudo apt update && sudo apt upgrade -y
```

비밀번호 입력 후 진행되며, 완료되면 개발 환경 준비가 끝납니다! 🎉

---

## 🔄 Step 7. 설치 후 WSL 다시 시작하는 방법

:::tip 🔄 WSL 다시 시작하는 방법
모든 창을 닫은 후 WSL을 다시 실행하는 방법은 아래 4가지가 있습니다.
:::

---

### 방법 1. 시작 메뉴에서 Ubuntu 아이콘으로 실행 (가장 간편) ⭐

1. **Windows 키** 누르기
2. 검색창에 `Ubuntu` 입력
3. **Ubuntu 24.04** 앱 클릭

> 💡 자주 사용한다면 **작업 표시줄에 고정**해두면 편리합니다.  
> Ubuntu 앱 우클릭 → **작업 표시줄에 고정**

---

### 방법 2. Windows Terminal에서 실행

Windows Terminal이 설치되어 있다면 탭에서 바로 Ubuntu를 선택할 수 있습니다.

1. **Windows Terminal** 실행 (`Windows 키 + X` → 터미널)
2. 상단 탭의 **`∨` (드롭다운)** 클릭
3. **Ubuntu-24.04** 선택

---

### 방법 3. PowerShell에서 명령어로 실행

PowerShell 또는 명령 프롬프트(CMD)에서:

```powershell
# 기본 배포판 실행
wsl

# 특정 배포판 지정 실행
wsl -d Ubuntu-24.04
```

---

### 방법 4. 파일 탐색기에서 WSL 경로로 접근

파일 탐색기 주소창에 아래 경로 입력:

```
\\wsl$\Ubuntu-24.04
```

또는

```
\\wsl.localhost\Ubuntu-24.04
```

> 💡 WSL 파일을 Windows 탐색기에서 직접 확인하거나 파일을 복사할 때 유용합니다.

---

### WSL 종료 방법

Ubuntu 터미널에서:

```bash
exit
```

또는 PowerShell에서 강제 종료:

```powershell
wsl --shutdown
```

> ⚠️ `wsl --shutdown` 은 실행 중인 모든 WSL 배포판을 종료합니다.

---

## 💾 WSL 저장 구조 이해하기

WSL의 실제 데이터는 **`ext4.vhdx`** 라는 가상 디스크 파일 형태로 저장됩니다.

| 항목 | 내용 |
|------|------|
| 파일 형식 | `ext4.vhdx` (Virtual Hard Disk) |
| 기본 저장 위치 | `C:\Users\[유저명]\AppData\Local\Packages\...` |
| 외부 드라이브 설치 시 | `D:\WSL\Ubuntu\ext4.vhdx` |

**용량 관리 및 백업 시 알아두면 유용한 명령어:**

```powershell
# 현재 배포판 목록과 저장 위치 확인
wsl --list --verbose

# 백업 (언제든 export로 tar 파일 생성 가능)
wsl --export Ubuntu-24.04 D:\backup\ubuntu-backup.tar

# 백업에서 복원
wsl --import Ubuntu-24.04 D:\WSL\Ubuntu D:\backup\ubuntu-backup.tar
```

---

## ⚠️ 자주 겪는 오류

| 오류 코드 | 원인 | 해결 방법 |
|-----------|------|-----------|
| `Wsl/CallMsi/Install/REGDB_E_CLASSNOTREG` | WSL COM 클래스 손상 | `winget uninstall` 후 재설치 |
| `Wsl/Service/WSL_E_DISTRO_NOT_FOUND` | Ubuntu가 등록되지 않은 상태 | `wsl --install -d Ubuntu-24.04` 먼저 실행 |
| `0x80370102` | BIOS 가상화 비활성화 | BIOS → Virtualization Technology 활성화 |
| `Access Denied` | 관리자 권한 없이 실행 | PowerShell을 관리자 권한으로 다시 실행 |

### 오류 발생 시 Windows 기능 활성화 확인

WSL 관련 오류가 발생했다면 Windows 기능이 제대로 켜져 있는지 먼저 확인하세요.

**`Windows 키 + R`** → `optionalfeatures` 입력 → Enter

또는 PowerShell에서:

```powershell
Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
Get-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
```

`State: Disabled` 로 나온다면 **Step 1** 으로 돌아가 기능을 활성화 후 재부팅하세요.

---

## 📝 참고

- Ubuntu Pro for WSL은 기업용 관리 도구로, 개인 개발 환경에는 불필요합니다.
- `wsl --install` 명령어 하나로 WSL2 + Ubuntu를 동시에 설치할 수 있습니다.
- WSL의 실제 파일은 `ext4.vhdx` 가상 디스크 형태로 저장되며, 이 파일을 백업하면 전체 환경을 복원할 수 있습니다.
- Microsoft Build Page : https://learn.microsoft.com/ko-kr/windows/wsl/install


