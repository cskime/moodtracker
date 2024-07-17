# Moodtracker

## Features

- Authentication (Sign in, Sign up, Sign out)
- Mood journal CRUD
- Mood visualization using calendar

## Skills

- State management : Riverpod
- Navigation : GoRouter
- Firebase Authentication, Firestore
- `table_calendar` pacakge to build customized calendar

## App architecture

```
lib
ㄴ features
    ㄴ authentication
        ㄴ views
        ㄴ view_models
        ㄴ repositories
        ㄴ services
    ㄴ posts
        ㄴ models
        ㄴ views
        ㄴ view_models
        ㄴ repositories
    ㄴ settings
        ㄴ views
        ㄴ view_models
```

- MVVM pattern을 사용한다.
  - View : widget
  - ViewModel : user action handling 및 binding state data
  - Model : data model, repository, service 등
- Authentication module
  - views
    - `LoginScreen`(로그인 화면)
    - `SignUpScreen`(가입 화면)
  - view_models
    - `LoginViewModel`
    - `SignUpViewModel`
  - models
    - repositories
      - `AuthRepository`
      - Firebase authentication에 접근하여 user 생성, login/logout 관리 등 처리
    - services
      - `ValidationService`
      - user input validation busienss logic 처리
- Post module
  - views
    - `WriteScree` : 감정 일기를 작성하는 widget
    - `CalendarScreen` : 감정 일기를 calendar로 보여주는 widget
  - view_models
    - `WriteViewModel`
    - `CalendarViewModel`
  - models
    - `Emotion` : 감정 종류
    - `Post` : 감정 일기 model
  - repositories
    - `PostRepository` : Firebase Firestore에 `Post` CRUD 구현

MVVM pattern을 사용한다.

## Data modeling

위 시나리오에서 data model은 '감정 일기' data 하나만 필요하다. 이 model은 다섯 가지 field를 갖는다.

| Field       | Description                                                                                 |
| ----------- | ------------------------------------------------------------------------------------------- |
| id          | Firestore에 저장되는 document id. Data 삭제를 위해 저장한다.                                |
| userId      | 사용자 ID. Document를 사용자 별로 구분할 수 있도록 user id를 path로 사용한다.               |
| emotion     | 감정을 나타내는 key string                                                                  |
| description | 감정과 함께 저장할 memo                                                                     |
| date        | 저장한 날짜. Flutter의 `DateTime` type을 Firebase의 `Timestamp` type으로 변환해서 저장한다. |

사용자가 자신의 data에 빠르게 접근할 수 있도록  `users/:userId/posts/:postId` path에 저장한다.

```
users (collection)
ㄴ {user id} (document)
    ㄴ posts (nested collection)
        ㄴ {post id} (document)
```

## User scenario

- `LoginScreen`에서 로그인하면 `WriteScreen`으로 이동한다.
- `WriteScreen`에서 감정을 선택하고 간단한 메모와 함께 저장한다.
- `WriteScreen`과 `CalendarScreen`은 bottom navigation 방식으로 화면 전환된다.
- `CalendarScreen`에서 저장한 감정 일기들을 날짜 별로 분류해서 보여준다.
- `CalendarScreen`의 `TableCalendar`에서 선택된 날짜에 해당하는 일기들을 아래에 list로 보여준다.
- `TableCalendar`의 각 day cell은 해당 날짜에 어떤 감정들을 느꼈는지 쉽게 확인할 수 있도록 저장된 감정들의 비율을 계산하여 색깔로 시각화 한다.
- 각 화면에서 설정 버튼을 누르면 로그아웃 버튼이 있는 bottom sheet가 나타난다.

## Implementation

### Visualization

- 기록한 감정들을 월별, 일별로 한 눈에 보면서 요즘 기분이 어떤지 쉽게 확인할 수 있게 시각화
- 감정 별로 색상을 부여하고, calendar의 날짜 칸에 기록한 감정들을 색상으로 표시
- 특정 날짜에 기록한 감정들의 비율을 계산한 뒤, `Expanded` widget을 사용해서 비율에 따라 calendar의 day cell을 다른 색상을 채우도록 구현
- `table_calendar` package를 사용하여 `TableCalendar` widget을 customizing
- 비율에 따라 감정 빈도 수를 나타내는 `Expanded` widget 생성
  ```dart
  List<Widget> _dayBackgroundWidgets(Iterable<Post> posts, DateTime day) {
    // 1. Post list로부터 emption 등장 횟수 계산
    final fractions = _fractionOfEmotions(posts);
    // 2. 등장 횟수 오름차순으로 정렬
    final sortedEntries = fractions.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    // 3. 등장 횟수를 `flex`로 갖는 `Expanded` widget으로 변환
    return sortedEntries
        .map<Widget>(
          (entry) => Expanded(
            flex: entry.value,
            child: ColoredBox(color: entry.key.tintColor),
          ),
        )
        .toList();
  }
  ```