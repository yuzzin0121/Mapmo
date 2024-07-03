# 맵모 - 위치 기반 추억 메모장
<br>
<div>
<Image src= "https://github.com/yuzzin0121/Mapmo/assets/77273340/b33491d7-25d7-42a1-b514-c7e0db7e106d" width=120 height=120></Image> <br><br>
<img alt="Static Badge" src="https://img.shields.io/badge/version-1.0.3-green">
</div>
<br>

## 한줄 소개
> 맵모는 방문했던 위치에 대해 이미지, 날짜, 메모를 남겨 차트, 캘린더, 지도를 통해 탐색할 수 있는 앱입니다.
<img src=https://github.com/yuzzin0121/Mapmo/assets/77273340/8094f6f3-b705-479b-a1b1-ff4d956a163a width=650 height=350>

## 프로젝트 개발
- iOS 1인 개발
- 개발 기간: 2주 (2024.03.10 ~ 2024.03.24)
- 환경: 최소 버전 16.0 / 세로 모드 / 아이폰용 / 다크모드
<br>

## 스크린샷

### 🔍 메모
|지도 탐색|좋아요한 맵모|캘린더 탐색|맵모 상세화면|메모 생성|메모 수정|메모 삭제|메모 좋아요|카테고리 수정|
|-----|---|---|---|---|---|---|---|---|
|<img src= width=150 height=330>|<img src= width=150 height=330>|<img src= width=150 height=330>|<img src= width=150 height=330>|<img src= width=150 height=330>|<img src= width=150 height=330>|<img src= width=150 height=330>|<img src= width=150 height=330>|<img src= width=150 height=330>|<img src= width=150 height=330>|<img src= width=150 height=330>|<img src= width=150 height=330>|
<br>

## 핵심 기능
- **메모 |** 생성 / 수정 / 삭제 / 조회 / 좋아요
- **장소 검색**
- **탐색 |** 지도 화면 / 캘린더 화면 / 좋아요
- **카테고리 추가**

<br>

## 주요 기술
**Framework** - UIKit <br>
**Pattern** - MVVM / Singleton / Delegate / Repository <br>
**Network** - Alamofire / Codable <br>
**Database** - Realm <br>
**OpenSource** - SnapKit, ToastSwift, TapMan, FSCalendar, IQKeyboardManagerSwift, Naver Map SDK, FloatingPanel, Firebase Analytics, Firebase Crashlytics <br>
**Etc** - Custom Observable, CoreLocation <br>

<br>

## 기술 설명
**Alamofire**
- Alamofire에 Router 패턴과 Generic을 통해 네트워크 통신의 구조화 및 확장성 있는 네트워킹 구현
**Realm**
- writeAsync를 사용하여 쓰기 트랜잭션을 비동기적으로 수행
**Etc**
- 공통적인 디자인의 뷰를 재사용하기 위해 커스텀 뷰로 구성
- 이미지 및 컬러 등 반복적으로 사용되는 에셋을 enum을 통해 네임스페이스화하여 관리
- NotificationCenter를 활용해 다른 계층에 있는 뷰에 데이터 갱신
- NetworkMonitor를 통해 네트워크 단절 상황 대응
- weak 키워드를 통해 객체를 약한 참조를 해줌으로써 메모리 누수 해결
<br>

## 트러블슈팅
### 1. 많은 realm 트랙잭션을 처리할 때 UI반응성이 저하
**해결방안**
- writeAsync를 사용하여 비동기적으로 쓰기 작업을 수행
<img width="700" alt="image" src="https://github.com/yuzzin0121/Mapmo/assets/77273340/79a97c3e-7774-41ab-acf4-96dc20dffe42">
<br><br>


### 2. **Naver Map SDK는 마커의 모양을 UIImage 타입만 가능하기 때문에 커스텀뷰로 마커를 사용하는 방법에 대한 고민**
**해결 방안** 
- UIGraphicsImageRenderer의 image 메서드를 사용하여 Custom View를 UIImage 객체로 변환
  
<img width="500" alt="image" src="https://github.com/yuzzin0121/Mapmo/assets/77273340/726b68fc-62d3-42bb-9d50-e1ad3daee84c"><br>
<img width="500" alt="image" src="https://github.com/yuzzin0121/Mapmo/assets/77273340/c1d2edf1-c8c0-4f94-b508-f2c3e672132d">
<br><br>


### 3. **강한 참조로 인한 메모리 누수 문제 발생**
- 메모리 그래프를 통해 메모리가 누수되는 문제 확인 <br>
**해결 방안**
- weak 키워드를 통해 객체를 약한 참조 해줌으로써 메모리 누수 해결

|해결 전|해결 후|
|-----|------|
|<img src=https://github.com/yuzzin0121/Mapmo/assets/77273340/dd7a2945-8fc3-4ebc-8872-d7427e8d9b03 width=300 height=300>|<img src=https://github.com/yuzzin0121/Mapmo/assets/77273340/fb948b93-9678-48ed-9933-5bd8d6b83206 width=300 height=300>
