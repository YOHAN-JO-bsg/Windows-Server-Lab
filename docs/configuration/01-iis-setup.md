# Windows Server 2022 기반 IIS 웹 서버 구축 및 방화벽 설정

## 구축 목적
- VMware Workstation 환경에서 Windows Server 2022 기반 IIS 웹 서버 구성
- Windows 방화벽 인바운드 정책 설정을 통한 외부 HTTP 통신 허용 NAT 환경에서 Host-PC ↔ Guest OS 간 웹 통신 동작 확인
  
- **아키텍처 스펙**:
  | 분류 | 상세 사양 |
  | :--- | :--- |
  | **Host OS** | Windows 11 Home |
  | **Hypervisor** | VMware Workstation |
  | **Guest OS** | Windows Server 2022 Standard Evaluation |
  | **네트워크 모드** | NAT |
  | **서버 IP** | `192.168.0.100`|
---

## 2. IIS 웹 서버 및 관리 기능 설치

### [Step 1] Server Manager를 통한 IIS 설치
1. Windows Server 2022의 Server Manager에서 Add Roles and Features 실행
2. Web Server (IIS) 역할 선택 후 설치 진행
3. IIS 관리 기능 사용을 위해 IIS Management Console 함께 설치

![IIS 설치 프로세스 완료](../../assets/day02/01_iis_completed.png)
*▲ IIS 웹 서버 및 관리 콘솔 설치 완료 화면*

---

## 3. 네트워크 통신 테스트 및 방화벽 설정 확인

### [Step 2] 방화벽 설정에 따른 외부 접속 차단 확인
1. 게스트 OS 내부에서 `http://localhost` 접속 시 IIS 웹 서버가 정상 동작하는 것 확인
2. 호스트 PC 브라우저에서 게스트 서버 `IP(http://192.168.0.100)`로 접속 테스트 진행

**[문제 확인]**
- 호스트 PC에서 접속 시 ERR_CONNECTION_TIMED_OUT 오류 발생
- IIS 서비스는 정상 동작 중이었지만, Windows 방화벽 인바운드 정책으로 인해 외부 접속이 차단된 상태 확인

![호스트 PC 통신 타임아웃 에러 포착](../../assets/day02/02_host_timeout.png)
*▲ 방화벽 정책으로 인해 외부 접속이 차단된 상태*

---

## 4. Windows 방화벽 인바운드 규칙 설정

### [Step 3] HTTP 80 포트 허용 규칙 직접 구성
- IIS 설치 후 기본 HTTP 인바운드 규칙이 자동 생성되는 것 확인
- 방화벽 동작을 직접 확인하기 위해 기존 IIS 관련 규칙을 비활성화한 뒤, HTTP 80 포트 허용 규칙을 수동으로 생성

1. Inbound Rules → New Rule... 선택
2. 규칙 유형 Port 선택 후 TCP 80 포트 지정
3. Allow the connection 설정
4. 규칙 이름을 HTTP_80_ALLOW로 지정 후 적용

![커스텀 방화벽 규칙 적용](../../assets/day02/03_firewall_rule_applied.png)
*▲ HTTP 80 인바운드 허용 규칙 생성 및 적용 화면*

---

### [Step 4] 외부 접속 정상 동작 확인
- 방화벽 규칙 적용 후 호스트 PC 브라우저에서 게스트 서버 `IP(http://192.168.0.100)`로 다시 접속 테스트 진행
- IIS 기본 웹 페이지가 정상 출력되는 것 확인
- HTTP 80 포트 인바운드 정책 적용 후 외부 통신이 정상 동작함을 검증

![방화벽 규칙 적용 후 웹 서비스 부활](../../assets/day02/04_iis_connection_success.png)
*▲ 방화벽 규칙 적용 후 IIS 웹 페이지 정상 접속 확인*

---

## 5. Lesson Learned
- AWS 환경에서는 Security Group을 통해 외부 접근을 제어했지만, VMware 기반 온프레미스 환경에서는 Windows 방화벽 규칙까지 직접 설정해야 외부 통신이 가능했음.
- 동일한 웹 서비스라도 환경에 따라 방화벽을 제어하는 위치와 방식이 다르다는 점을 직접 확인했으며, 클라우드와 온프레미스 환경의 차이를 이해할 수 있었음.
