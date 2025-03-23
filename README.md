# flutter_bindings_example
Примеры использования биндингов во Flutter.

# Bindings

Связь между движком движком и фреймворком. Связь PlatformDispatcher из dart:ui и более высокоуровневыми слоями фреймворка, своего рода набор фасадов над PlatformDispatcher.

Базовый класс для всех биндингов BindingBase. 
Все биндинги синглтоны.

Всего во Flutter 9 наследников класса `BindingBase`:
- [`SchedulerBinding`](https://api.flutter.dev/flutter/scheduler/SchedulerBinding-mixin.html);
- [`ServicesBinding`](https://api.flutter.dev/flutter/services/ServicesBinding-mixin.html);
- [`GestureBinding`](https://api.flutter.dev/flutter/gestures/GestureBinding-mixin.html);
- [`RendererBinding`](https://api.flutter.dev/flutter/rendering/RendererBinding-mixin.html);
- [`SemanticsBinding`](https://api.flutter.dev/flutter/semantics/SemanticsBinding-mixin.html);
- [`PaintingBinding`](https://api.flutter.dev/flutter/painting/PaintingBinding-mixin.html);
- [`WidgetsBinding`](https://api.flutter.dev/flutter/widgets/WidgetsBinding-mixin.html);
- [`WidgetsFlutterBinding`](https://api.flutter.dev/flutter/widgets/WidgetsFlutterBinding-class.html);
- [`TestWidgetsFlutterBinding`](https://api.flutter.dev/flutter/flutter_test/TestWidgetsFlutterBinding-class.html).

### SchedulerBinding

Doc: https://api.flutter.dev/flutter/scheduler/SchedulerBinding-mixin.html

Планировка задач, связанных с отрисовкой кадра.
1. Вызовы преходящих задач (`transientCallbacks`), например, события тикеров и контроллеров анимации. Обычно такие колбеки отвечают за обновление объектов до новых состояний анимации.
2. Задачи (микротаски) которые должны быть выполнены между отрисовкой кадров.midFrameMicrotasks
3. Вызовы непрерывных задач (`persistentCallbacks`). Используются для запуска рендеринга. Например, метод `build` у виджета.
4. Задачи, вызываемые после отрисовки кадра (`postFrameCallbacks`). Обычно их нельзя выполнить в процессе рендеринга (очистка кеша изображений).
5. С помощью `SchedulerBinding` можно управлять стратегией работы сборщика мусора.


Таким образом можно выполнять задачи: 
- **до** отрисовки,
- **между** отрисовкой, 
- **для** отрисовки,
- **после** отрисовки.

Пример: получение размера виджета после отрисовки.
https://github.com/AndrewVorotyntsev/flutter_bindings_example/blob/main/lib/scheduler_binding_example.dart

### ServicesBinding

Doc: https://api.flutter.dev/flutter/services/ServicesBinding-mixin.html

1. Прослушивание и перенаправление платформенных сообщений в [`BinaryMessenger`](https://api.flutter.dev/flutter/services/BinaryMessenger-class.html), сервис, к которому по умолчанию привязываются платформенные каналы: каналы методов ([`MethodChannel`](https://api.flutter.dev/flutter/services/MethodChannel-class.html)) и событий ([`EventChannel`](https://api.flutter.dev/flutter/services/EventChannel-class.html)).
2. Сбор и регистрация лицензий пакетов, которые были в приложении в качестве зависимостей.
3. Сохранение ссылки на токен главного изолята. Он необходим для того чтобы общаться через платформенные каналы из сторонних изолятов. 
4. Обработка системных событий, которые идут от платформы. Например, запрос на выход из приложения, жизненный цикл приложения, событие out of memory, нажатия клавиатуры и др.
5. Создание [`RestorationManager`](https://api.flutter.dev/flutter/services/RestorationManager-class.html) — это сущность, которая отвечает за восстановление состояния приложения.

Пример: отслеживание событий клавиатуры
https://github.com/AndrewVorotyntsev/flutter_bindings_example/blob/main/lib/services_binding_example.dart

### RendererBinding

Doc: https://api.flutter.dev/flutter/rendering/RendererBinding-mixin.html

Cвязывает RenderObject и Flutter engine. 
- Прослушивает событий от engine которые связаны с изменением настроек устройства, которые влияют на отображение (например, тёмная тема или размер текста).
- Передает во Flutter engine изменения на экране drawFrame().
- В специфичных ситуациях или при оптимизации работы приложения `RendererBinding` для более точного контроля над рендерингом.
Метод drawFrame() автоматически запускается движком, когда приходит время расположить и отрисовать кадр.

Пример: отложенная отрисовка
https://github.com/AndrewVorotyntsev/flutter_bindings_example/blob/main/lib/rendering_binding_example.dart


### WidgetsBinding

Doc: https://api.flutter.dev/flutter/widgets/WidgetsBinding-mixin.html
https://api.flutter.dev/flutter/widgets/WidgetsBindingObserver-class.html

Связывает engine и виджеты.
- управляет процессом перестроения структуры дерева элементов (для этого используется [`BuildOwner`](https://api.flutter.dev/flutter/widgets/BuildOwner-class.html));
- производит отрисовку в ответ на изменения структуры дерева.

Пример: отслеживание локализации устройства
https://github.com/AndrewVorotyntsev/flutter_bindings_example/blob/main/lib/widgets_binding_example.dart

### Связь между собой
Одни биндинги являются обертками (миксинами) над другими:
Самый высокоуровневый WidgetsBinding, а самый низкоуровневый SchedulerBinding.
WidgetsBinding -> RendererBinding -> ServicesBindings -> SchedulerBinding

### Источники
https://education.yandex.ru/handbook/flutter/article/bindings
