# 📝 Windows Server 2022 RDP 원격 관리 인프라 구성 및 연동 검증

## 1. 인프라 구축 개요
- **목적**: 로컬 가상화(Hypervisor) 환경에서 구동 중인 Windows Server 2022 가상 머신의 RDP(Remote Desktop Protocol, 포트 3389) 서비스를 활성화하고, 호스트 PC와의 원격 제어 가용성을 검증함.
- **인프라 환경 사양**:
  - **Host OS**: Windows 11
  - **Guest OS**: Windows Server 2022 Datacenter Core
  - **Host IP 대역 (VMnet8)**: `192.168.58.xxx`
  - **Guest IP**: `192.168.58.xxx`

---

## 2. Windows Server RDP 활성화 절차

### [Step 1] 시스템 원격 데스크톱 서비스 개방
1. 가상 윈도우 서버 내 `Server Manager` -> `Local Server` 메뉴로 이동.
2. 비활성화(`Disabled`) 상태인 `Remote Desktop` 항목을 클릭하여 시스템 속성 창 진입.
3. **`Allow remote connections to this computer`** 옵션을 선택하여 외부 인바운드 RDP 요청을 수신 대기 상태로 전환함.

### [Step 2] 방화벽 인바운드 허용 상태 연동 검증
1. Windows Defender 고급 보안 방화벽 정책 관리자(`Inbound Rules`)로 이동.
2. RDP 서비스 활성화에 따라 관련 시스템 내장 규칙인 **`Remote Desktop - User Mode (TCP-In)` (기본 포트 3389)** 정책이 방화벽 엔진에서 자동으로 허용(`Enabled`) 상태로 전환되었는지 연동 유무를 팩트 체크함.

---

## 3. 호스트 PC-게스트 서버 원격 제어 최종 연동

### [Step 3] RDP 클라이언트를 통한 보안 세션 수립 및 검증
1. 호스트 PC에서 원격 데스크톱 연결 프로그램을 실행한 후, 대상 가상 머신의 사설 IP(`192.168.58.xxx`)를 목적지로 지정.
2. 대상 서버의 최고 관리자 계정 자격 증명(**`Administrator`**) 및 패스워드를 사용하여 인증 단계를 수행함.
3. 사설 인증서 경고 단계를 통과한 후, 호스트 PC 환경 위에서 가상 머신 서버가 원격 세션 형태로 완벽하게 제어되는 것을 최종 검증함.

![RDP 원격 인프라 연동 성공 완료](../../assets/day02/05_rdp_connected_v2.png)
*▲ [📸 05_rdp_connected_v2.png] 호스트 PC와 가상 머신 서버 간의 RDP(3389) 보안 세션 수립 및 원격 관리 가용성 최종 검증 완료 화면*

---

## 4. Lesson Learned
- **명시적 서비스 제어와 방화벽 연동**: OS단에서 특정 원격 관리 서비스를 활성화할 때 시스템 방화벽 정책이 어떻게 자동으로 연동되어 포트(3389)를 개방하는지 메커니즘을 확인하였음.
- **원격 관리 인프라의 가치**: 인프라 운영 시 서버에 직접 물리적으로 접근하지 않고, 격리된 호스트 환경에서 원격 프로토콜을 통해 안전하고 효율적으로 인프라를 제어 및 관리하는 표준 운영 방식을 실습함.
