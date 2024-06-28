# 맵모 - 위치 기반 추억 메모장
<br>
<div>
<Image src= "https://github.com/yuzzin0121/Mapmo/assets/77273340/b33491d7-25d7-42a1-b514-c7e0db7e106d" width=120 height=120></Image> <br><br>
<img alt="Static Badge" src="https://img.shields.io/badge/version-1.0.0-green">
</div>
<br>

## 한줄 소개
> 맵모는 방문했던 위치에 대해 이미지, 날짜, 메모를 남겨 차트, 캘린더, 지도를 통해 탐색할 수 있는 앱입니다.
<img src=https://github.com/yuzzin0121/Mapmo/assets/77273340/37e18ec0-1873-4637-9f30-e59356f2abbc width=650 height=350>

## 프로젝트 개발
- iOS 1인 개발
- 개발 기간: 2주 (2024.03.10 ~ 2024.03.24)
- 환경: 최소 버전 16.0 / 세로 모드 / 아이폰용 / 다크모드
<br>

## 스크린샷


<br>

## 핵심 기능
- **메모 |** 생성 / 수정 / 삭제 / 조회 / 좋아요
- **장소 검색**
- **탐색 |** 지도 화면 / 캘린더 화면 / 좋아요
- **카테고리 추가**

<br>

## 주요 기술
**Platform** - UIKit <br>
**Pattern** - MVVM / Singleton / Delegate / Repository <br>
**Network** - Alamofire <br>
**Database** - Realm <br>
**OpenSource** - SnapKit, ToastSwift, TapMan, FSCalendar, IQKeyboardManagerSwift, Naver Map SDK, FloatingPanel, Firebase Analytics, Firebase Crashlytics <br>
**Etc** - Custom Observable, CoreLocation <br>

<br>

## 기술 설명
**Alamofire**
- Alamofire에 Router 패턴과 Generic을 통해 네트워크 통신의 구조화 및 확장성 있는 네트워킹 구현

**Etc**
- 공통적인 디자인의 뷰를 재사용하기 위해 커스텀 뷰로 구성
- 이미지 및 컬러 등 반복적으로 사용되는 에셋을 enum을 통해 네임스페이스화하여 관리
- NotificationCenter를 활용해 다른 계층에 있는 뷰에 데이터 갱신
- NetworkMonitor를 통해 네트워크 단절 상황 대응
- weak 키워드를 통해 객체를 약한 참조를 해줌으로써 메모리 누수 해결

<br>

## 트러블슈팅
### 1. 많은 realm 트랙잭션을 처리할 때 UI반응성이 저하
<img width="700" alt="image" src="https://github.com/yuzzin0121/Mapmo/assets/77273340/79a97c3e-7774-41ab-acf4-96dc20dffe42">


### 2. 이미지 마커로 커스텀
<img width="500" alt="image" src="https://github.com/yuzzin0121/Mapmo/assets/77273340/726b68fc-62d3-42bb-9d50-e1ad3daee84c"><br>
<img width="500" alt="image" src="https://github.com/yuzzin0121/Mapmo/assets/77273340/c1d2edf1-c8c0-4f94-b508-f2c3e672132d">
