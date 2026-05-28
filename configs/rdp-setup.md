# Windows Server 2022 RDP 원격 관리 구성 및 네트워크 연동 확인

## 1. 개요
* VMware 가상화 환경에서 Windows Server 2022의 원격 데스크톱(RDP) 기능 활성화 진행
* 호스트 PC에서 가상 머신으로 원격 접속이 정상적으로 이루어지는지 확인
* RDP 활성화 이후 네트워크 연결 및 방화벽 동작 방식 함께 확인
- **테스트 환경**:
  - **Host OS**: Windows 11 Home
  - **Guest OS**: Windows Server 2022 Standard Evaluation (Desktop Experience)
  - **Host IP 대역 (VMnet8)**: `192.168.58.xxx`
  - **Guest IP**: `192.168.58.xxx`

---

## 2. Windows Server RDP 활성화 단계

### [Step 1] 원격 데스크톱 기능 활성화
1. Windows Server 내부의 `Server Manager → Local Server` 메뉴로 이동
2. 기본값으로 비활성화되어 있던 `Remote Desktop` 항목 선택
3. 시스템 속성 창에서 `Allow remote connections to this computer` 옵션 활성화
4. 외부 PC에서 원격 접속이 가능하도록 설정 적용

### [Step 2] 방화벽 규칙 자동 적용 확인
1. Windows Defender 고급 보안 방화벽(`Inbound Rules`) 메뉴 확인
2. 원격 데스크톱 기능 활성화 이후 `Remote Desktop - User Mode (TCP-In)` 규칙이 자동 활성화된 상태 확인
3. 기본 RDP 포트인 3389 포트가 허용 상태로 변경된 것 확인
* Windows Server는 RDP 기능 활성화 시 관련 방화벽 정책도 함께 자동 적용되는 방식 확인 가능

![RDP 원격 인프라 연동 설정](../assets/day02/06_rdp_enable_properties.png)
▲ Remote Desktop 활성화 및 시스템 속성 설정 화면
---

## 3. 호스트 PC와 Windows Server 원격 연결 확인

### [Step 3] 원격 데스크톱(RDP) 접속 확인
1. 호스트 PC에서 `원격 데스크톱 연결(Remote Desktop Connection)` 프로그램을 실행한 뒤, VMware 가상 머신의 IP 주소(`192.168.58.xxx`)를 입력해 접속을 시도했음
2. Windows Server 관리자 계정(`Administrator`)과 비밀번호를 입력해 로그인했음
3. 인증서 경고 창에서 `예`를 눌러 접속을 진행했고, 원격 창을 통해 가상 머신 서버 화면이 정상적으로 열리는 것을 확인했음

![RDP 원격 인프라 연동 성공 완료](../assets/day02/05_rdp_connected_v2.png)
*▲ 호스트 PC와 Windows Server 가상 머신 간 RDP 연결 확인 화면*

---

## 4. Lesson Learned
* Windows Server에서 원격 데스크톱 기능을 활성화하면 방화벽 규칙도 함께 자동으로 활성화되는 흐름을 직접 확인했음

* VMware NAT 환경에서도 호스트 PC와 게스트 서버 간 원격 연결이 정상적으로 동작하는 것을 확인했음

* 실제로 원격 접속을 구성해 보면서 서버를 물리적으로 직접 만지지 않아도 원격으로 관리할 수 있는 환경 구성을 경험했음
