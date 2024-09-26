# Tractian Selection Process

Hello, I'm Matheus, and I'd like to share my experience with the selection process for Tractian. The main challenge involves rendering a tree of asset components, which can range from energy and vibration sensors to statuses indicating normal operation or a critical (alert) state. Additionally, it's crucial to ensure speed, performance, and efficiency when applying filters to these components.

## Important

This application was built in `Flutter 3.24.3` version

>
     Flutter 3.24.3 • channel stable • https://github.com/flutter/flutter.git
     Framework • revision 2663184aa7 (2 weeks ago) • 2024-09-11 16:27:48 -0500
     Engine • revision 36335019a8
     Tools • Dart 3.5.3 • DevTools 2.37.3
>


* I implemented the functionality to efficiently expand each child item in the widget tree, ensuring excellent performance in the recursion algorithm.
  
* I have also integrated all the requested filters, such as the **Energy Sensor** filter, the **Critical** status filter, the **Text Input** filter, and the combination of **Text Input** with either **Energy Sensor** or **Critical** status.
  
* To achieve this goal, focusing on performance, speed, and especially a good user experience without causing bottlenecks or UI freezes, we utilized isolates for processing in separate threads, parallel programming practices, and a custom algorithm that checks if each child widget is within the user's field of view. If a widget is visible, it is built; otherwise, it is not created. This approach conserves memory for our application while ensuring optimal performance, preventing UI overload, and maintaining good speed.

  > Note: It is worth noting that in `Parallel Programming`, I used an approach with `sync*` and `yield`. As soon as the data is processed and ready, it is sent to the `Cubit` to be displayed in the UI. This process continues gradually until all items are fully visible. This is particularly important because we have a recursive algorithm, and depending on the number of children and grandchildren, we don't want the display to take too long. With this approach, we ensure a better user experience.
  
* Click [here](https://drive.google.com/file/d/1nqz2alE9C_o0ns_aY7YkOGc1Xa_P_07_/view?usp=sharing) to watch the video of the application running with high performance
* Click [here](https://drive.google.com/file/d/18oJcWzjeirXz1TzO_T6qfGlvxRb07hQc/view?usp=sharing) to download the APK.
  
* The video below showcases the functionality where, upon clicking an item, it expands to reveal its respective children.
  > Note: The test images below were carried out in all available companies

https://github.com/user-attachments/assets/9ff794e0-f3b3-40b3-9833-c757a38d4137

<p align="left">
  <img src="https://github.com/user-attachments/assets/b50a0987-c5d6-4328-b480-4a09fd083596" width="15%" />
  <img src="https://github.com/user-attachments/assets/c1d5d2c7-2410-4031-94b7-fbbc900e1878" width="15%" />
  <img src="https://github.com/user-attachments/assets/c68d6dfc-da69-459b-b612-a0a3214a0795" width="15%" />
  <img src="https://github.com/user-attachments/assets/debd1ffd-e884-4dce-9f4c-f53a8972c1b4" width="15%" />
  <img src="https://github.com/user-attachments/assets/28d62e00-da44-43bd-bd44-ab189b645d91" width="15%" />
</p>


## Technical Information

* In my applications, I always strive to create a dedicated Flutter module or plugin for the design system, and this project was no exception. I prefer this approach because, if a new application arises that utilizes the same styling, we can implement it with minimal effort, saving time in the development of future apps. Additionally, if a redesign is necessary in the future, we will also have reduced effort to adapt the application to the new styling. With this well-applied practice, we can achieve, depending on the case, even 0% changes in our business logic. This strategy has greatly assisted me during my time working in a software factory and also in my current company, where a screen had to be completely redesigned.

  <img width="186" alt="Captura de Tela 2024-09-26 às 00 31 25" src="https://github.com/user-attachments/assets/7c879d92-ef03-464d-9523-292cc43c94b9">

* For the project architecture, **Clean Architecture** was utilized. This approach enables a clear separation of responsibilities, facilitating the maintenance and scalability of the system. By following the principles of **Clean Architecture**, we ensure that the presentation, domain, and data layers are independent, promoting a modular and testable design.
  
* For state management, `Cubit` (a variant of the BloC pattern) was utilized. This approach simplifies state management in a reactive manner, allowing for a clear separation between business logic and the user interface. By using Cubit, we ensure better code organization and a more responsive experience for users
  
* I developed a class to manage the results of requests, which captures both exceptions and the returned data. With this implementation, we have enhanced control over data handling and ensure the integrity of our information.
  >
       factory Result.success(T data) => Result<T, E>(data: data);
       factory Result.failure(E error) => Result<T, E>(error: error);
  > 
* For the routing and navigation architecture, I used `GetX` due to its simplicity in configuration and management. This library streamlines the implementation of routes, allowing for more intuitive and efficient navigation between different screens of the application. With `GetX`, we can optimize the navigation flow and reduce code complexity.
  
* For routing, I used `dio`. This library stands out for its robustness and flexibility in making HTTP requests, allowing for efficient management of routes and response handling. With Dio, we can implement features such as request interception, error handling, and timeout configuration, ensuring more effective communication with APIs.
  
* For testing, I used the `mocktail` and `integration_test` libraries. `mocktail` allowed me to create mocks to simulate dependencies and test units in isolation, while `integration_test` enabled the execution of integration tests, ensuring that different parts of the application work together correctly. Together, these tools ensure code quality.

### TaskManager

* I created a class called `TaskManager` to manage isolate tasks. I anticipated that if the user typed a lot of text, the application could accumulate multiple simultaneous isolate tasks, potentially impacting the performance of the interface. The `TaskManager` controls how many tasks in separate threads are being executed, and as these tasks are completed, the next ones in the queue are activated.
>
    void addTask(Function task) {
      _checkOverflow();
      _tasks.add(task);
      _processTasks();
    }

    void releaseTask() {
      _currentTasks--;
      _processTasks();
    }
    
    void _processTasks() {
      while (_tasks.isNotEmpty && _currentTasks < _maxTasks) {
        final task = _tasks.removeFirst();
        _currentTasks++;
        task();
      }
    }
>  

### UI Development: Advanced and Innovative Approaches

* In Flutter, as widgets are built, there is an increase in memory and processing usage. In our application, we have widgets that contain N children, and these, in turn, also have N children, creating a complex hierarchy. When we expand these children, the widgets are generated recursively. In cases of extremely large lists, this can lead to memory leaks or memory overflow, causing the application to freeze or even crash, especially when numerous calculations are required to render N widgets.

* To prevent this issue, I implemented an algorithm on the screen that checks if a widget is within the user's field of view. This way, only the visible widgets are built, optimizing memory usage and enhancing the application's performance.


>
      bool _isVisible() {
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        final size = renderBox.size;
        final screenHeight = MediaQuery.of(context).size.height;
        return position.dy + size.height > 0 && position.dy < screenHeight;
      }
> 

* However, when the return value of this algorithm is `true`, the `StreamController` triggers an event notifying the build system that it can render that widget. This ensures that only the necessary widgets are created, contributing to the application's efficiency
