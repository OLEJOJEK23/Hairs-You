# Hairs & You

**Мобильное приложение для поиска и записи в салоны красоты и к мастерам**

![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?logo=firebase&logoColor=black)

## О проекте

**Hairs & You** — это удобная платформа для поиска салонов красоты, барбершопов и независимых мастеров. Приложение позволяет быстро находить услуги, просматривать портфолио мастеров, читать отзывы, записываться на приём и отслеживать свои записи.

Проект разработан как полноценное клиентское приложение с современным стеком и чистой архитектурой.

### Основные возможности

- **Авторизация** — вход по номеру телефона (OTP), Google Sign-In
- **Поиск салонов** — с фильтрами и сортировкой
- **Интерактивная карта** — поиск ближайших заведений с геолокацией
- **Подробные карточки** салонов и мастеров
- **Портфолио работ** с фотографиями
- **Отзывы и рейтинги**
- **Избранное** — сохранение салонов и мастеров
- **Запись на услуги** с выбором мастера и времени
- **Личный кабинет** и история записей
- **Тёмная / светлая тема**
- **AI-экран** (интеграция с искусственным интеллектом)

## Технологический стек

| Технология              | Назначение |
|-------------------------|----------|
| **Flutter**             | Кросс-платформенная разработка |
| **Dart**                | Основной язык |
| **Firebase**            | Авторизация, конфигурация |
| **Flutter Bloc + Cubit**| State Management |
| **GetIt**               | Dependency Injection (Service Locator) |
| **AutoRoute**           | Навигация и глубокие ссылки |
| **Dio + Retrofit**      | HTTP-клиент и генерация API |
| **google_maps_flutter** | Карты и геолокация |
| **Geolocator**          | Определение местоположения |
| **SharedPreferences**   | Локальное хранение настроек |
| **image_picker**        | Загрузка фото |
| **cached_network_image**| Кэширование изображений |
| **table_calendar**      | Календарь для записи |
| **pinput + intl_phone_number_input** | Работа с номерами телефона |

### Архитектура

- **Clean Architecture** + Feature-First структура
- Разделение на **data**, **domain** и **presentation** слои
- Использование **UseCase**-ов
- Репозитории с кэшированием (CacheManager)
- Dependency Injection через **GetIt**

## Структура проекта
lib/
├── api/              # API слой (data + domain)
├── features/         # Feature-first модули
│   ├── HomeScreen
│   ├── Salons
│   ├── MasterScreen
│   ├── BookingScreen
│   ├── ProfileScreen
│   └── ...
├── blocks/           # BLoC / Cubit
├── router/           # AutoRoute конфигурация
├── theme/            # Темизация
├── widgets/          # Общие виджеты
└── ...

###Автор
OLEJOJEK23
Flutter-разработчик | Mobile Engineer

Telegram: @@kys_bitch
Email: bashmachenkovoleg@yandex.ru
