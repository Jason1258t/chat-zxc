# Aether Design System

> *Тёмная дизайн-система для мобильного мессенджера.*  
> Void-эстетика, glassmorphism, violet × cyan акценты.

---

## Содержание

1. [Философия](#философия)
2. [Структура файлов](#структура-файлов)
3. [Шрифты](#шрифты)
4. [Цвета](#цвета)
5. [Пространство и размеры](#пространство-и-размеры)
6. [Скругления](#скругления)
7. [Тени и свечение](#тени-и-свечение)
8. [Движение](#движение)
9. [Компоненты мессенджера](#компоненты-мессенджера)
10. [Подключение](#подключение)

---

## Философия

**Aether** — это "пустота со структурой". Интерфейс живёт на почти-чёрном фоне с едва уловимым синим подтоном. Акценты — фиолетовые и cyan — появляются точечно, создавая ощущение свечения в темноте. Никакого overdesign: каждый элемент либо функционален, либо создаёт атмосферу.

Три принципа:

- **Void first** — фон максимально тёмный, почти чёрный. Элементы "всплывают" из темноты.
- **Glow as hierarchy** — важность элемента выражается не только размером, но и интенсивностью свечения.
- **Restraint is aesthetic** — glassmorphism и gradient применяются экономно. Когда они появляются — это момент.

---

## Структура файлов

```
lib/design_system/
├── aether.dart           # Barrel-экспорт (импортируй только его)
├── colors.dart           # Цветовые токены и градиенты
├── typography.dart       # Шрифты и текстовые стили
├── tokens.dart           # Spacing, radius, shadows, motion, opacity
├── theme.dart            # ThemeData для MaterialApp
└── component_styles.dart # Готовые декорации для виджетов
```

---

## Шрифты

### Три гарнитуры

| Роль | Семья | Характер |
|------|-------|----------|
| **Display** | [Syne](https://fonts.google.com/specimen/Syne) | Геометрический, с острыми углами и характером. Для имён, заголовков. |
| **Body / UI** | [Figtree](https://fonts.google.com/specimen/Figtree) | Мягкий гротеск. Идеально читается мелким кеглем на тёмном. |
| **Mono** | [Fira Code](https://fonts.google.com/specimen/Fira+Code) | С лигатурами. Timestamps, ссылки, код. |

### Установка (pubspec.yaml)

```yaml
dependencies:
  google_fonts: ^6.2.1

flutter:
  fonts:
    - family: Syne
      fonts:
        - asset: fonts/Syne-Regular.ttf
        - asset: fonts/Syne-SemiBold.ttf  weight: 600
        - asset: fonts/Syne-Bold.ttf      weight: 700
    - family: Figtree
      fonts:
        - asset: fonts/Figtree-Regular.ttf
        - asset: fonts/Figtree-Medium.ttf   weight: 500
        - asset: fonts/Figtree-SemiBold.ttf weight: 600
    - family: FiraCode
      fonts:
        - asset: fonts/FiraCode-Regular.ttf
        - asset: fonts/FiraCode-Medium.ttf  weight: 500
```

> Или использовать `google_fonts` пакет — он подгружает шрифты автоматически (см. `typography.dart`).

### Типографическая шкала

```
displayLarge   — Syne 32/700  — Профиль, большое имя
displayMedium  — Syne 24/700  — Заголовок экрана
displaySmall   — Syne 18/600  — Имя в шапке чата

headlineLarge  — Syne 22/600  — Секции в настройках
headlineMedium — Syne 18/600  — Подзаголовки
headlineSmall  — Syne 15/600  — Мелкие заголовки

bodyLarge      — Figtree 16/400  — Текст сообщений
bodyMedium     — Figtree 14/400  — Превью в списке
bodySmall      — Figtree 13/400  — Описания, подписи

labelLarge     — Figtree 15/600  — Кнопки
labelMedium    — Figtree 13/500  — Таббар
labelSmall     — Figtree 11/600  — Badge, chip

monoSmall      — Fira Code 10.5  — Timestamp
monoMedium     — Fira Code 13    — Ссылки
monoDisplay    — Fira Code 14    — Блоки кода
```

---

## Цвета

### Void (базовые тёмные поверхности)

| Токен | HEX | Применение |
|-------|-----|-----------|
| `void0` | `#080A0F` | Фон приложения (scaffold) |
| `void100` | `#0D0F15` | Фон панелей, навбар |
| `void200` | `#12151C` | Карточки, входящие пузыри |
| `void300` | `#191D27` | Hover / pressed состояния |
| `void400` | `#252A38` | Разделители, border |
| `void500` | `#454C61` | Иконки disabled, placeholder |

### Violet (primary accent)

| Токен | HEX | Применение |
|-------|-----|-----------|
| `violet100` | `#1A0F2E` | Subtle tint, selected фон |
| `violet200` | `#2D1E52` | Исходящие пузыри (базовый) |
| `violet400` | `#4A2F82` | Border активных элементов |
| `violet500` | `#8B5CF6` | **Основной акцент** — кнопки, FAB |
| `violet600` | `#A78BFA` | Hover состояние |
| `violet700` | `#C4B5FD` | Лёгкие highlights |

### Cyan (secondary accent)

| Токен | HEX | Применение |
|-------|-----|-----------|
| `cyan500` | `#06B6D4` | Онлайн-индикатор, ссылки |
| `cyan600` | `#22D3EE` | Glow аватаров, активные чаты |

### Rose (tertiary / alerts)

| Токен | HEX | Применение |
|-------|-----|-----------|
| `rose500` | `#F43F5E` | Уведомления, непрочитанные, ошибки |
| `rose600` | `#FB7185` | Hover на danger-элементах |

### Текст

| Токен | HEX | Применение |
|-------|-----|-----------|
| `textPrimary` | `#ECEDF5` | Основной текст |
| `textSecondary` | `#AAADB8` | Имена, метки |
| `textTertiary` | `#636779` | Timestamp, disabled |

### Градиенты

```
gradientPrimary        — Violet → Cyan (для кнопок, FAB)
gradientSubtle         — Violet dark → Cyan dark (аватары)
gradientVoid           — Void0 → Void dark (фон-переходы)
gradientOutgoingBubble — Фиолетовый пузырь (входящие сообщения)
gradientGlowViolet     — Радиальный glow для акцентов
gradientGlowCyan       — Радиальный glow для онлайн-статусов
```

---

## Пространство и размеры

Базовая единица — **4px**. Все отступы кратны ей.

| Токен | px | Применение |
|-------|----|-----------|
| `xs` | 4 | Минимальные внутренние отступы |
| `sm` | 8 | Иконки, мелкие gap |
| `md` | 12 | Паддинг чипов, мелких кнопок |
| `lg` | 16 | Стандартный horizontal padding |
| `xl` | 20 | — |
| `xl2` | 24 | Section padding |
| `xl3` | 32 | Крупные блоки |
| `xl4` | 40 | — |
| `xl5` | 48 | Высота bottom nav |

### Чат-специфичные

| Токен | px |
|-------|----|
| `bubblePaddingH` | 14 |
| `bubblePaddingV` | 10 |
| `bubbleSpacing` | 2 (между пузырями одного отправителя) |
| `threadSpacing` | 12 (между группами сообщений) |
| `avatarSize` | 40 |
| `avatarSizeLg` | 56 |
| `inputBarHeight` | 52 |

---

## Скругления

| Токен | px | Применение |
|-------|----|-----------|
| `xs` | 4 | — |
| `sm` | 8 | Мелкие элементы |
| `md` | 12 | Карточки в списках |
| `lg` | 16 | Модальные окна, кнопки |
| `xl` | 20 | Bottom sheet, FAB |
| `full` | 999 | Chips, badge, аватары, input bar |

### Пузыри сообщений

Исходящие: скруглены везде на 18px, кроме нижнего правого угла (4px — "хвост").  
Входящие: симметрично, "хвост" слева внизу.

```dart
// Исходящее (правая сторона)
BorderRadius.only(
  topLeft:     Radius.circular(18),
  topRight:    Radius.circular(18),
  bottomLeft:  Radius.circular(18),
  bottomRight: Radius.circular(4),   // ← "хвост"
)

// Входящее (левая сторона)
BorderRadius.only(
  topLeft:     Radius.circular(4),   // ← "хвост"
  topRight:    Radius.circular(18),
  bottomLeft:  Radius.circular(18),
  bottomRight: Radius.circular(18),
)
```

---

## Тени и свечение

Вместо Material elevation — кастомные `BoxShadow` с цветным glow.

| Стиль | Применение |
|-------|-----------|
| `cardSubtle` | Карточки, легкие поверхности |
| `modal` | Bottom sheet, модальные окна |
| `glowViolet` | Акцентные кнопки, FAB (двойной слой) |
| `glowCyan` | Аватары онлайн-пользователей |
| `glowRose` | Notification badge |
| `bubbleIncoming` | Тень входящего пузыря |
| `bubbleOutgoing` | Тень + violet подсвет исходящего пузыря |

```dart
// Пример использования glow на кнопке
Container(
  decoration: BoxDecoration(
    gradient: AetherColors.gradientPrimary,
    borderRadius: BorderRadius.circular(AetherRadius.lg),
    boxShadow: AetherShadows.glowViolet,
  ),
  child: ...,
)
```

---

## Движение

### Длительности

| Токен | ms | Применение |
|-------|----|-----------|
| `instant` | 80 | Ripple, очень мелкие состояния |
| `fast` | 150 | Hover, press |
| `normal` | 250 | Стандартные переходы |
| `slow` | 400 | Появление панелей |
| `xslow` | 600 | Страничные переходы, reveal |

### Кривые

| Токен | Кривая | Применение |
|-------|--------|-----------|
| `standard` | `easeInOut` | Большинство переходов |
| `enter` | `easeOut` | Появление элементов |
| `exit` | `easeIn` | Исчезновение |
| `spring` | `elasticOut` | Пузыри сообщений, уведомления |
| `decelerate` | `decelerate` | Slide-in панели |

### Пресеты

```dart
AetherMotion.messageAppear      // 200ms, easeOutBack — появление пузыря
AetherMotion.reactionPop        // 300ms, elasticOut — реакции
AetherMotion.pageTransition     // 350ms, easeOutCubic — навигация
AetherMotion.sheetSlide         // 400ms, easeOutQuart — bottom sheet
```

---

## Компоненты мессенджера

### Пузырь исходящего сообщения

```dart
Container(
  decoration: AetherBubbleStyle.outgoing,
  padding: const EdgeInsets.symmetric(
    horizontal: AetherSpacing.bubblePaddingH,
    vertical: AetherSpacing.bubblePaddingV,
  ),
  child: Text(
    message,
    style: AetherChatTextStyle.outgoingMessage,
  ),
)
```

### Пузырь входящего сообщения

```dart
Container(
  decoration: AetherBubbleStyle.incoming,
  padding: const EdgeInsets.symmetric(
    horizontal: AetherSpacing.bubblePaddingH,
    vertical: AetherSpacing.bubblePaddingV,
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(senderName, style: AetherChatTextStyle.senderName),
      Text(message, style: AetherChatTextStyle.incomingMessage),
    ],
  ),
)
```

### Онлайн-аватар

```dart
Stack(
  children: [
    Container(
      width: AetherSpacing.avatarSize,
      height: AetherSpacing.avatarSize,
      decoration: AetherAvatarStyle.online,
      child: ClipOval(child: Image.network(url)),
    ),
    Positioned(
      right: 0, bottom: 0,
      child: Container(
        width: 11, height: 11,
        decoration: AetherAvatarStyle.onlineIndicator,
      ),
    ),
  ],
)
```

### Glassmorphism overlay

```dart
ClipRRect(
  borderRadius: AetherRadius.card,
  child: BackdropFilter(
    filter: ImageFilter.blur(
      sigmaX: AetherBlur.medium,
      sigmaY: AetherBlur.medium,
    ),
    child: Container(
      decoration: AetherGlassStyle.medium,
      child: ...,
    ),
  ),
)
```

---

## Подключение

### 1. Добавь зависимость

```yaml
# pubspec.yaml
dependencies:
  google_fonts: ^6.2.1
```

### 2. Подключи тему

```dart
import 'package:your_app/design_system/aether.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Messenger',
      theme: AetherTheme.dark,
      darkTheme: AetherTheme.dark,
      themeMode: ThemeMode.dark,
      home: const HomeScreen(),
    );
  }
}
```

### 3. Используй токены

```dart
import 'package:your_app/design_system/aether.dart';

// Цвета
color: AetherColors.violet500
color: AetherColors.textPrimary

// Типография
style: AetherTypography.bodyLarge
style: AetherChatTextStyle.outgoingMessage

// Отступы
padding: EdgeInsets.all(AetherSpacing.lg)

// Декорации пузырей
decoration: AetherBubbleStyle.outgoing

// Тени
boxShadow: AetherShadows.glowViolet

// Анимации
duration: AetherMotion.messageAppear
curve: AetherMotion.messageAppearCurve
```

---

*Aether Design System — built for the dark side.*
