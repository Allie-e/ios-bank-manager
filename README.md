# 🏦  은행 창구 매니저

> 여기 이자율이 왜 이래요..


</br>

**Index**

- [Preview](#Preview)
- [Ground Rule](#GroundRule)
- [Step1](#Step1)
- [Step2](#Step2)
- [Step3](#Step3)

</br>

<a name="Preview"></a>

# Preview

  Not Open                 |  Open             
:-------------------------:|:-------------------------:
<img src="https://s3.us-west-2.amazonaws.com/secure.notion-static.com/6c174d4d-bfec-49b2-a7e0-bec075964af9/Untitled.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220102%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220102T072451Z&X-Amz-Expires=86400&X-Amz-Signature=0c26577d5f299b96030b72b112a97643507d436f3e46ea2dfa105c440e13d954&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Untitled.png%22&x-id=GetObject"  width="400" height="800"/> |  ![Open](https://user-images.githubusercontent.com/70251136/147869103-de0620c4-ce76-4777-b7cb-5f695d7dad5f.gif)


</br>

<a name="GroundRule"></a>

# 🤝 Ground Rule

### **시간**

- 오전 10시 ~
- 점심 12-2시
- 저녁 6-7시
- 주말은 휴식
- 쉬고 싶으면 언제든지 말하기

### **진행 계획**

- STEP 1 → 12.21 18:00
- STEP 2 → 12.24 18:00
- STEP 3 → 12.28 18:00

### **커밋 관련**

- 단위
    - [Karma Style](http://karma-runner.github.io/latest/dev/git-commit-msg.html)
- 메세지
    - [Karma Style](http://karma-runner.github.io/latest/dev/git-commit-msg.html)

### 기타

- 구현 전 **Issue**를 생성하며 요구사항에 대해 한번 더 생각해본다.

</br>

<a name="Step1"></a>

# 1️⃣ Step 1

## **🎯** Step1 구현 내용

### LinkedList

1. 우리가 넣어줄 인덱스에 원래 위치했던 노드를 임시 변수에 저장(복사)하고, 원래 위치했던 노드에 우리가 넣어줄 노드를 넣음
2. 우리가 원하는 값을 넣은 노드를 넣고싶은 인덱스의 다음 노드로 임시 변수에 저장했던 노드를 설정 (원래 해당 인덱스에 위치했던 노드)
3. 새로운 노드가 들어갔으므로, prev와 next를 양 노드에 연결

</br>

### LinkedList removeFirst() 메소드 변경

보통의 `removeLast()`  기능을 Queue의 **FIFO 특성**에 따라 `removeFirst()`로 수정해주었음

이 과정에서 따로 조건을 만들어 주지 않은 `head = nil` 을 타게 되며 head부터 연결되어 있는 형식의 LinkedList가 전부 끊겨버리는 문제 발생 

`head.next`에 `head`를 할당하는 것이 아닌 `head`는 이제 `head.next` 인 방식을 사용 정상적으로 동작하여 문제를 해결

```swift
// before
func removeFirst() -> T? {
        guard head != nil else {
            return nil
        }

        let data = head?.data
				if head?.next != nil {
						head?.next = head
				}
				head = nil
				
        return data
    }

// after
func removeFirst() -> T? {
        guard head != nil else {
            return nil
        }
        
        let data = head?.data
        
        if head?.next != nil {
            head = head?.next
        } else {
            head = nil
        }
        
        return data
    }
```

</br>

### @discardableResult

`removeFirst()` 의 테스트를 진행하며 반환 값을 사용할 필요가 없다고 생각되어`@discardableResult` 키워드를 붙임

해당 메소드를 사용하는 Queue의 `Dequeue()`에도 맥락을 위해 `@discardableResult` 을 붙임

## **🤔 Step1 고민했던 점**

### LinkedList 양방향으로 변경

단방향으로 연결리스트를 구현하는 과정에서 리스트의 맨 마지막 노드 다음에 노드를 추가해주는 `append()`를 하려면 리스트의 끝까지 순회해야한다는 단점이 있음

이를 개선하고자 **양방향 연결리스트**로 수정 

양방향으로 연결하여 `append()`를 할 때, 모든 node를 순회하지 않고 바로 tail을 찾기때문에 단방향의 단점(많은 비용(순회))을 보완

</br>

### Node, LinkedList struct vs class

1. 노드는 타입 내부에서 같은 타입인 자신을 참조하기때문에 구조체로 구현할 수 없음
2. 노드를 클래스로 생성하여 한 노드에 대해 참조 해제를 해줄 경우, ARC로 인해 메모리에서 내려가게끔 만들어줄 수 있으므로 **클래스로 생성**
3. LinkedList는 queue타입에서 원본값(노드)이 계속 변경되어야 하기때문에 복사하는 것이 아닌, 원본을 참조하여 원본값을 변경하기 위해 **클래스로 생성**

## **🙇‍♂️** Step1 배운 점

### Mock 타입 생성

- 테스트하려는 타입의 인스턴스 프로퍼티에 접근제어를 주었는데, 이는 외부에서 사용하는 것을 막기 위해 설정하였음
- Unit Test 진행시 해당 프로퍼티에 접근하여 테스트를 해야하는데, 접근제어가 설정되어 있으므로 테스트 하지 못하는 문제가 발생
- 그럴 땐 Mock 타입 생성 후 해당 타입을 테스트만을 위해 사용하면 됨 이로써 Mock의 원본 타입은 본래 상태 유지

<a name="Step2"></a>

# **2️⃣ Step 2**

## 📊 Step2 UML

![Untitled](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/1cb2b38e-8e5a-4f6b-9f72-8de7a73ac0f3/Untitled.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220102%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220102T073010Z&X-Amz-Expires=86400&X-Amz-Signature=afaf31946d74080531165ad07877d51d37ffb02563719653d194fc879367c8d4&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Untitled.png%22&x-id=GetObject)

## **🎯** Step2 구현 내용

- Step1에서 구현한 Queue를 이용해 고객 관리
- 직원의 고객 업무처리, 업무처리 시간 구현
- 타입 추상화 및 일반화
- 역할 분리
- 상하관계로 설계하여 단방향 의존을 함으로써 순환 참조 등의 상황 방지

## **🤔** Step2 고민했던 점

### inout Parameter

```
// Bank
mutating func letClerkWork() {
    while waitingLine.isEmpty == false {
        bankClerk.work(&waitingLine)
    }
}

// Clerk
func work(_ waitingLine: inout Queue<Customer>) {
    guard let customer = waitingLine.dequeue() else {
        return
    }

    print("\(customer.waitingNumber)번 고객 업무 시작")
    Thread.sleep(forTimeInterval: 0.7)
    print("\(customer.waitingNumber)번 고객 업무 종료")
}
```

- 함수 외부의 프로퍼티를 변경하며 사용하기위해선 `inout Parameter`를 사용해야 함
- 필자들은 이로인해 가독성이 떨어져 보인다는 생각이 들었고, 각 타입의 역할을 더 분명히 한다면 이를 해결할 수 있을 것이라 생각하였고 코드 검토 결과, 기존에 은행의 일로 설계한 일을 직원이 하고있었고 이를 은행이 일을 한 뒤, 일의 결과를 직원이 받아 처리하는 로직으로 변경하였음

</br>

### **인스턴스 프로퍼티? 지역변수?**

Bank의 업무 마감을 알리는 출력문을 구현할 때, 몇 명의 고객을 받았는지 알아야 했음

생각한 두가지 방법은 다음과 같다.

1. 처음에 BankManager가 생성하여주는 랜덤한 고객의 수를 가져와 Bank 인스턴스 프로퍼티에 할당해 준 뒤 그것을 사용하는 것
    
    ```swift
    struct Bank {
    	var totalNumber = 0
    
    	mutating func setWaitingLine(with numberOfCustomer: () -> Int) {
          totalNumber = numberOfCustomer()
          for number in 1...totalNumber {
              waitingLine.enqueue(Customer(waitingNumber: number))
          }
       }
    }
    ```
    
2. Bank의 `letClerkWork()` 메소드 내부에서 초기값 0을 가진 지역 변수를 생성하여 **loop**가 한번 돌 때(`dequeue` 한번)마다 해당 지역 변수에 카운트 해주는 방식으로 값을 할당하여 사용하는 것
    
    ```swift
    struct Bank {
    	mutating func letClerkWork() {
          let taskTime = 0.7
          var numberOfCustomer = 0
            
          while waitingLine.isEmpty == false {
              let customer = dequeueWaitingLine()
              bankClerk.handleTask(of: customer, until: taskTime)
              numberOfCustomer += 1
          }
          noticeCloseDown(totalCustomer: numberOfCustomer, taskTime: taskTime)
      }
    }
    ```
    

**인스턴스 프로퍼티:** 저희가 설계한 프로그램 내에서 `Bank`라는 인스턴스는 은행이 열리는 시점부터 업무가 종료되는 시점까지 메모리에 올라가 있어 프로퍼티가 사용되지 않을 때에도 메모리 공간을 차지하고 있다.

**함수 내부의 지역변수:** 함수의 실행이 끝나면 메모리에서 해제되지만, 반복적인 연산이 일어나 처리비용이 소모된다는 단점이 있다.

**고민 결과**

인스턴스 프로퍼티를 채택하였다.

- 이유: 해당 프로퍼티를 사용하는 메소드가 단 한개라면 지역 변수가 맞겠지만, 해당 프로퍼티를 두 곳에서 사용해줘야 했으므로, 두 메소드가 반복적으로 지역변수를 메모리에 올리고 내리고의 비용보다 인스턴스가 생성될 때 한번만 올려주는 것이 더 낫겠다고 판단하였다.

## **🙇‍♂️** Step2 배운 점

### 역할 분리

- 코드 작성 전, UML과 타입의 추상화, 일반화를 통해 각 타입의 책임을 분명히 하였음

은행원이 고객을 직접 불러올지, 은행이 은행원에게 고객을 넘겨줄지 등의 각각 자신의 책임을 가지게 하여 관계를 분명히 한다면 이후 **단일 책임과 의존성 관리에 용이한 결과를 불러옴을 알게되었음**

### inout Parameter

- `in-out` 파라미터는 기존 파라미터의 값을 변경시키는 것이 아닌 기존 파라미터를 복사하여 함수 내부에서 값을 수정하고, 함수가 반환될 때 기존 파라미터 값을 복사된(수정된) 값으로 할당

### Naming 중요성

[https://www.swift.org/documentation/api-design-guidelines/#naming](https://www.swift.org/documentation/api-design-guidelines/#naming)

<a name="Step3"></a>

# 3️⃣ Step 3

## **🎯** Step3 구현 내용

### 동시성 프로그래밍

- 여러 은행원들이 동시에 일을 처리하는 로직 구현
- CustomQueue를 구현하여 특정 일을 처리하는 직원이 한명인 상황엔 Serial Queue를 사용하고, 여러명인 상황엔 Concurrent Queue를 사용하여 일을 처리하도록 구현

### 고객 대기열 오름차순 처리

- Concurrent Queue에서 작업을 처리하기 전 작업의 순서를 정하기 위해 Serial Queue에서 순서대로 일을 Concurrent Queue로 보내는 로직 구현

### 공유 자원에 접근할 수 있는 스레드 제한

- Race Codition 방지
- 2개의 스레드가 접근해도 Race Condition은 발생할 수 있으므로 순서대로 작업이 처리될 수 있도록 구현

### enum 구현

- 일의 종류, 일의 종류에 따른 처리시간을 enum으로 따로 빼주어 하드코딩 방지 및 코드 정리

### Delegate 구현

## **🤔** Step3 고민했던 점

### **semaphore.wait()의 위치**

예금 업무를 처리하는 은행원은 2명이라는 조건이 있어, 공유 자원에 접근할 수 있는 스레드의 수를 2개로 제어해주기 위해 `semaphore`를 사용하였다. 

`DispatchSemaphore`는 `semaphore`를 카운트하는 식으로 동작하는데, `semaphore.wait()`의 위치를 어느곳에 작성해주어야 하는지 고민이 되었다.

아래와 같이 두가지 방법이 있을 것 같은데, 첫번째는 비동기가 시작될 때 count -1을 해주는 방법이고 두번째는 비동기 시작 전에 count를 하는 방법이다. 

`wait()`는 값에 접근했다고 알리는 메서드라고 생각해서 비동기가 시작되는 내부에 작성해주었다.

```swift
// 1. 비동기 내부에 작성하는 방법
case .deposit:
    depositQueue.async(group: workGroup) {
       semaphore.wait()
       taskTime = BankTask.deposit.processingTime
       self.bankClerk.handleTask(of: customer, until: taskTime)
       numberOfCustomer += 1
       semaphore.signal()
    }

// 2. 비동기 시작 전에 작성하는 방법
case .deposit:
    semaphore.wait()
    depositQueue.async(group: workGroup) {
       taskTime = BankTask.deposit.processingTime
       self.bankClerk.handleTask(of: customer, until: taskTime)
       numberOfCustomer += 1
       semaphore.signal()
    }
```
</br>

### 고객 대기열 오름차순 처리

```swift
// before: 고객의 번호표 순서대로 일처리가 되지 않음.
switch customer.task {
        case .deposit:
            depositQueue.async(group: workGroup) {
                semaphore.wait()
                self.bankClerk.handleTask(of: customer, until: BankTask.deposit.processingTime)
                numberOfCustomer += 1
                semaphore.signal()
            }

// after: 고객의 번호표 순서대로 일처리
switch customer.task {
         case .deposit:
             sequenceQueue.async {
                  depositQueue.async(group: workGroup) {
                      semaphore.wait()
                      self.bankClerk.handleTask(of: customer, until: BankTask.deposit.processingTime)
                      numberOfCustomer += 1
                      semaphore.signal()
                  }
              }

/*
sequenceQueue - Serial Queue
depositQueue - Concurrent Queue
*/
```

대출(Loan)을 담당하는 직원은 한명이라 Serial Queue를 사용하여 단일 스레드로 일을 처리할 수 있도록 하였고, 순서대로 처리하는 Serial Queue의 특성으로 인해 대출하러온 고객의 순서는 정상적으로 출력

그리고 예금(Deposit)을 담당하는 직원은 두명이라 Concurrent Queue를 사용하여 다중 스레드로 일을 처리하도록 하였음

하지만, 해당 과정에서 고객의 순번대로 일이 시작되지 않는다는 문제 발생

파악한 원인으론 Concurrent Queue의 특성상 순서를 중요히 하지 않는다는 점에서 발생한 문제로 파악하여 해당 Task를 Serial Queue로 감싸주어 순서대로 Task를 Concurrent Queue에 넣어주어 처리하게 하여 순서대로 처리하도록 구현

![Untitled](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/04b9072b-855e-4fd1-9a0e-7edae0ea6486/Untitled.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220102%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220102T073142Z&X-Amz-Expires=86400&X-Amz-Signature=45baea9fefd0c8b8599fbcdf9ae95a594e94229d25f311b7786cde709e35f234&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Untitled.png%22&x-id=GetObject)

하지만 결과적으로 Task가 처리되는 건 Concurrent Queue에서 다중 스레드에 할당되어 처리되는데 위 공식문서에 명시된 Concurrent Queue의 특성상 순서를 중요히 하지 않는다는 점에도 불구하고 순서대로 출력이 잘 되는 것이 이상하단 생각이 들었고, 앞에서 Serial Queue를 거쳐 순서를 정해줘도 결과가 순서대로 출력되는 것과 상관이 없을 것 같은데 왜 정상적으로 동작하지?, 이전 코드랑 똑같은거 아닌가? 라는 생각이 들었다.

그 결과 이는 GCD의 영역이며, 우리는 `sequenceQueue.async { }` Serial하게 `depositQueue.async(group: workGroup)`코드를 실행시켜서 순서대로 처리하게 만들기만 하면 되는 것임을 알았음

</br>

### Delegate

```swift
private func finishWork(workingTime: Double) {
    delegate?.didFinishWork(totalCustomer: totalCustomer, workingTime: workingTime)
    totalCustomer = 0
}
```

은행의 일이 끝나면 은행 마감되었다고 알려주는 것은 `BankManager`의 역할이 아닐까 하는 고민을 하였고, 이를 해결하기위해 **delegation pattern**을 활용하여 은행의 업무가 끝날시 매니저에게 은행 업무가 끝났다고 알리고, 매니저가 마감 메세지를 출력해주는 방식을 채택하였음

</br>

### 구조체 내부 메소드의 클로저는 내부 프로퍼티를 수정할 수 없는 문제

Bank 타입이 구조체인 경우 내부 메소드 안의 탈출 클로저는 값을 캡처할 수 없었다.

![Untitled](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/55f97c2a-5cbb-4ff0-a9a5-439d16d49931/Untitled.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220102%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220102T073206Z&X-Amz-Expires=86400&X-Amz-Signature=82a31286af11e7ce2a3a09e6037971a5fc021cb64bdda6fae13ffb1b114d5ea2&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Untitled.png%22&x-id=GetObject)

이유는 클로저가 값을 캡처할 때 원본의 값을 캡처하는 것이 아닌 구조체 복사본을 캡처하기때문에 아무것도 변경되지 않으므로 컴파일 에러를 내는 것이다.

이러한 이유로 Bank를 클래스로 변경하여 문제를 해결하였다.

[참고링크](https://stackoverflow.com/questions/58327013/swift-5-whats-escaping-closure-captures-mutating-self-parameter-and-how-t)

## **🙇‍♂️** Step3 배운 점

- 동기(Synchronous)와 비동기(Asynchronous)의 이해
- GCD
- 스레드
- 클로저 캡쳐
