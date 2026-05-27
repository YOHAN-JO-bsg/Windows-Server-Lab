# Windows-Server-Lab

VMware 가상화 환경을 기반으로 Windows Server 2022 가상 인프라를 설계하고, 네트워크 제어, 방화벽 통제, RDP 원격 관리 및 IIS 웹 서비스를 구축한 프로젝트입니다. 최종적으로 운영체제 간 커널 로그 메커니즘과 서비스 수명 주기를 비교 분석하여 멀티 OS 인프라 운영 역량을 정립했습니다.

---

## 1. 가상화 인프라 스펙

- **Host OS**: Windows 11 Home
- **Guest OS**: Windows Server 2022 Standard Evaluation (Desktop Experience)
- **하이퍼바이저**: VMware Workstation (VMnet8 사설 NAT 대역 서브넷 매핑)
- **원격 제어**: TCP 3389 RDP 활성화를 통한 호스트-게스트 간 원격 보안 세션 수립

---

## 2. 인프라 구축 및 운영 로드맵 (Index)

각 항목의 제목을 클릭하면 상세 실습 및 트러블슈팅 명세서로 바로 이동합니다.

### 웹 서버 프로비저닝 및 가용성 검증
* **[Server Manager를 통한 IIS 역할 가동](./docs/configuration/01-iis-setup.md#2-웹-서버-iis-및-관리-컴포넌트-프로비저닝)**
  - 서버 관리자 대시보드 마법사를 통한 Web Server(IIS) 패키지 빌드.
  - 웹 서비스 관리 제어를 위한 IIS Management Console 종속성 검증 및 설치.
* **[네트워크 통신 검증 및 방화벽 차단 식별](./docs/configuration/01-iis-setup.md#3-네트워크-통신-검증-및-방화벽-차단-식별)**
  - 호스트 PC 브라우저 접근 시 Connection Timeout(외부 통신 격리 현상) 포착 및 원격 장애 원인 분석.

### 커스텀 방화벽 정책 제어 및 원격 관리
* **[커스텀 인바운드 방화벽 규칙 수립 및 외부 통신 복구](./docs/configuration/01-iis-setup.md#4-커스텀-인바운드-방화벽-규칙-지정-및-가용성-복구)**
  - 자동화된 내장 웹 트래픽 규칙에 의존하지 않고, 명시적 패킷 차단(DROP) 유도 후 파워쉘 및 고급 보안 방화벽을 통해 수동으로 `HTTP_80_ALLOW` 인바운드 정책 수립.
  - 호스트 PC 크롬 시크릿 브라우저를 통한 IIS 웰컴 메인 레이아웃 접속 및 양방향 가용성 최종 검증.

### 시스템 로그 분석, 운영 자동화 및 OS 아키텍처 비교
* **[이벤트 뷰어(Event Viewer) 커널 로그 정밀 진단](./docs/architecture/01-event-viewer-log.md#2-시스템-커널-로그system-log-분석-및-진단)**
  - Windows PowerShell을 연계하여 EventID 1014(DNS 클라이언트 경고) 원인 진단 및 InstanceId 4624(보안 로그인 성공 감사) 백엔드 데이터 흔적 역추적 검증.
* **[작업 스케줄러(Task Scheduler) 기반 무인 가동 자동화](./docs/architecture/01-event-viewer-log.md#4-작업-스케줄러task-scheduler를-통한-운영-자동화)**
  - New-ScheduledTask API들을 조합하여 정해진 주기마다 네트워크 상태를 누적 백업하는 자동화 스크립트 배치 등록 및 Ready 상태 최종 박제.
* **[Linux vs Windows Server 인프라 아키텍처 비교](./docs/architecture/02-linux-vs-windows.md)**
  - 리눅스와 윈도우 서버를 모두 다뤄보며 체감한 방화벽 규칙 할당 방식, 서비스 수명 주기 관리(Systemd vs SCM), 로그 인덱싱 및 백엔드 스케줄러의 아키텍처적 차이점 총정리 명세서 수립.

---
