# Linux vs Windows Server 운영 방식 비교

## 1. 개요

* VMware 환경에서 Linux와 Windows Server 2022를 직접 구축하고 사용하면서 느낀 차이점 정리
* 방화벽 설정, 서비스 관리, 자동화, 로그 확인 방식 등을 비교하며 운영 방식 차이 확인

---

## 2. 운영 방식 비교

| 항목     | Linux          | Windows Server 2022       |
| ------ | -------------- | ------------------------- |
| 원격 접속  | SSH            | RDP                       |
| 방화벽    | UFW / iptables | Windows Defender Firewall |
| 서비스 관리 | systemd        | 서비스 관리자(SCM)              |
| 로그 확인  | /var/log       | 이벤트 뷰어(Event Viewer)      |
| 자동화    | Crontab        | 작업 스케줄러                   |

---

## 3. 직접 사용하면서 느낀 차이점

### 3.1 방화벽 설정 방식

#### Linux

* UFW와 iptables 명령어로 포트 허용 및 차단 설정
* 텍스트 기반 규칙이라 빠르게 수정 가능
* SSH와 웹 서버 포트 관리가 단순한 편

#### Windows Server

* GUI 기반으로 방화벽 규칙 관리 가능
* IIS 설치 시 일부 웹 관련 규칙 자동 활성화 확인
* HTTP 80 포트 인바운드 규칙 직접 생성 후 외부 접속 테스트 진행

---

### 3.2 서비스 관리 방식

#### Linux

* systemd로 Spring Boot 서비스 등록 및 관리
* `Restart=always` 옵션으로 자동 재시작 환경 구성

#### Windows Server

* 서비스 관리자와 PowerShell 기반 서비스 제어
* 작업 스케줄러와 연계한 자동 실행 환경 구성 가능

---

### 3.3 자동화 방식

#### Linux

* Crontab으로 쉘 스크립트 주기 실행 설정
* 서버 상태 점검 스크립트 자동 실행 환경 구성

#### Windows Server

* 작업 스케줄러(Task Scheduler) 기반 예약 작업 등록
* PowerShell로 작업 생성 및 실행 상태 확인

---

### 3.4 로그 확인 방식

#### Linux

* `/var/log` 경로의 로그 파일 직접 확인
* `tail -f`, `grep` 명령어로 에러 원인 추적
* 텍스트 기반 로그라 필요한 내용 검색이 빠른 편

#### Windows Server

* 이벤트 뷰어(Event Viewer)와 PowerShell로 시스템 로그 확인
* `Get-EventLog` 명령어로 특정 이벤트 ID 조회
* 로그인 기록과 시스템 경고 로그 확인 가능

---

## 4. 정리

* Linux는 명령어와 설정 파일 중심으로 직접 제어하는 느낌이 강했음
* Windows Server는 GUI와 PowerShell을 함께 사용하는 방식이 인상적이었음
* 두 환경 모두 직접 구축하고 운영하면서 서비스 관리, 로그 확인, 방화벽 설정 방식 차이 확인 가능
