# Windows-Server-Lab

VMware 가상화 환경을 기반으로 Windows Server 2022 가상 인프라를 설계하고, 네트워크 제어, 방화벽 통제, RDP 원격 관리 및 IIS 웹 서비스를 구축한 프로젝트입니다. 최종적으로 운영체제 간 커널 로그 메커니즘과 서비스 수명 주기를 비교 분석하여 멀티 OS 인프라 운영 역량을 정립했습니다.

---

## 1. 가상화 인프라 스펙

- **Host OS**: Windows 11 Home
- **Guest OS**: Windows Server 2022 Standard Evaluation (Desktop Experience)
- **하이퍼바이저**: VMware Workstation Pro 26H1 (VMnet8 NAT)
- **원격 제어**: TCP 3389 RDP 활성화를 통한 호스트-게스트 간 원격 보안 세션 수립

---

## 2. 인프라 구축 및 운영 로드맵 (Index)

각 항목의 제목을 클릭하면 상세 실습 및 트러블슈팅 명세서로 바로 이동합니다.

### IIS 웹 서버 구축 및 네트워크 통신 점검
* **[IIS 역할 설치 및 운영 환경 구성](./docs/configuration/01-iis-setup.md#2-웹-서버-iis-및-관리-컴포넌트-프로비저닝)**
  - Server Manager를 활용한 IIS(Web Server) 및 관리 기능 설치
  - 웹 서비스 운영을 위한 기본 관리 환경 구성
* **[외부 통신 테스트 및 방화벽 정책 분석](./docs/configuration/01-iis-setup.md#3-네트워크-통신-검증-및-방화벽-차단-식별)**
  - 브라우저 접근 테스트 과정에서 Timeout 현상 발생 확인
  - Windows 방화벽 정책 분석을 통해 외부 접속 문제 해결

### 방화벽 정책 설정 및 외부 통신 테스트
* **[HTTP 인바운드 정책 구성](./docs/configuration/01-iis-setup.md#4-커스텀-인바운드-방화벽-규칙-지정-및-가용성-복구)**
  - Windows 방화벽에서 HTTP(80) 포트 허용 정책 직접 설정
  - PowerShell 및 고급 보안 방화벽을 활용한 외부 접속 정책 관리
* **[외부 브라우저 접속 검증](./docs/configuration/01-iis-setup.md#4-커스텀-인바운드-방화벽-규칙-지정-및-가용성-복구)**
   - 호스트 PC에서 IIS 웹 페이지 접속 테스트 수행
   - 방화벽 정책 적용 후 정상 통신 여부 확인

### 시스템 로그 분석 및 운영 자동화
* **[Event Viewer 기반 로그 분석](/architecture/01-event-viewer-log.md#2-시스템-커널-로그system-log-분석-및-진단)**
  - Event Viewer와 PowerShell을 활용하여 DNS 관련 경고(Event ID 1014) 원인 분석
  - 로그인 감사 로그(Event ID 4624)를 확인하며 Windows 보안 로그 구조 이해
* **[Task Scheduler 기반 자동화 구성](/architecture/01-event-viewer-log.md#4-작업-스케줄러task-scheduler를-통한-운영-자동화)**
  - PowerShell 스크립트를 작업 스케줄러에 등록하여 네트워크 상태 자동 기록
  - 주기적인 로그 저장 및 자동 실행 환경 구성
* **[Linux와 Windows Server 운영 방식 비교](/architecture/02-linux-vs-windows.md)**
  - Linux(Systemd)와 Windows SCM(Service Control Manager)의 서비스 관리 방식 비교
  - 방화벽 정책 구성, 로그 확인 방식, 스케줄러 구조 차이 분석 두 운영체제를 직접 운영하며 느낀 관리 방식과 운영 구조 차이 정리

---
