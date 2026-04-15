import 'dart:math';

// База с киберспортсменами
final List<String> _proPlayers = [
  'Yatoro', 'Miracle-', 'Topson', 'Collapse', 'Nisha', 'Puppey', 'KuroKy',
  'SumaiL', 'Arteezy', 'Miposhka', 'TORONTOTOKYO', 'Nightfall', 'RAMZES666',
  'No[o]ne', 'Dendi', 's1mple', 'donk', 'ZywOo', 'NiKo', 'm0NESY', 'device',
  'ropz', 'sh1ro', 'electroNic', 'Perfecto', 'Boombl4', 'jL', 'iM', 'Aleksib'
];

// Абсурдные суффиксы
final List<String> _absurdSuffixes = [
  '228', '1337', '1488', '322', '0_3', '666', '69', '420',
  '_пиво', '_чипсы', '_семки', '_майонез', '_кефир', '_дошик',
  '_сникерс', '_баунти', '_печенька', '_гречка', '_сало', '_борщ',
  'zxc', 'qwe', 'asd', 'fgh', 'xdd', 'kekw', 'POGGERS',
  '_в_танке', '_на_паузе', '_спит', '_бомбит', '_тильтует',
  '2281337', 'xXx', '___', '007', '123', '_на_рейдене'
];

// Приставки-модификаторы
final List<String> _prefixes = [
  'XaXa', 'LOL', 'KEP', 'NUGA', 'BOT', 'TOP', 'PRO', 'NOOB',
  'PoMogite', 'Zachem', 'Kuda', 'Pochemu', 'Kogda', 'Gde'
];

// Случайные слова-вставки
final List<String> _randomInserts = [
  'loh', 'kek', 'cheburek', 'salo', 'pivo', 'morkovka',
  'batya', 'ded', 'babka', 'kot', 'pes', 'hamster'
];

// Функция для генерации абсурдного ника
String generateAbsurdNickend({
  bool addPrefix = false,
  bool addInsert = false,
  bool addSuffix = true,
  int chaosLevel = 1, // 1-3 уровень безумия
}) {
  final random = Random();
  final basePlayer = _proPlayers[random.nextInt(_proPlayers.length)];

  String result = basePlayer;

  // Добавляем префикс
  if (addPrefix || (chaosLevel >= 2 && random.nextBool())) {
    final prefix = _prefixes[random.nextInt(_prefixes.length)];
    result = '$prefix${random.nextInt(9) + 1}_$result';
  }

  // Добавляем вставку в середину
  if (addInsert || (chaosLevel >= 3 && random.nextBool())) {
    final insert = _randomInserts[random.nextInt(_randomInserts.length)];
    final insertPos = random.nextInt(2); // 0 - после первой буквы, 1 - после второй
    if (insertPos == 0 && result.length > 1) {
      result = '${result[0]}_$insert${result.substring(1)}';
    } else if (result.length > 2) {
      result = '${result.substring(0, 2)}_$insert${result.substring(2)}';
    }
  }

  // Добавляем суффикс
  if (addSuffix) {
    final suffix = _absurdSuffixes[random.nextInt(_absurdSuffixes.length)];
    result = '$result$suffix';
  }

  // Экстра хаос - множественные суффиксы
  if (chaosLevel >= 3 && random.nextBool()) {
    final extraSuffix = _absurdSuffixes[random.nextInt(_absurdSuffixes.length)];
    result = '$result$extraSuffix';
  }

  return result;
}

// Упрощенная версия для быстрого использования
String getRandomProPlayer() {
  final random = Random();
  return _proPlayers[random.nextInt(_proPlayers.length)];
}

// Супер-абсурдная генерация
String generateSuperAbsurdNickname() {
  final random = Random();
  final player = _proPlayers[random.nextInt(_proPlayers.length)];
  final suffix1 = _absurdSuffixes[random.nextInt(_absurdSuffixes.length)];
  final suffix2 = _absurdSuffixes[random.nextInt(_absurdSuffixes.length)];

  final variants = [
    '${player}_${suffix1}',
    '${player}${suffix1}',
    '${player}_$suffix1$suffix2',
    'xXx_${player}_${suffix1}_xXx',
    '${_randomInserts[random.nextInt(_randomInserts.length)]}_$player$suffix1',
    '$player${random.nextInt(1000)}',
  ];

  return variants[random.nextInt(variants.length)];
}

// Ещё более безумная версия с регистрами
String generateCrazyNickname() {
  final random = Random();
  String nickname = generateSuperAbsurdNickname();

  // Случайно меняем регистр букв
  if (random.nextBool()) {
    nickname = nickname.split('').map((char) {
      return random.nextBool() ? char.toUpperCase() : char.toLowerCase();
    }).join();
  }

  // Добавляем смайлики для полного абсурда
  final emotes = ['😎', '🔥', '💀', '🤡', '🎮', '⚡', '🐧', '🍺', '🥒', '🍆'];
  if (random.nextBool()) {
    nickname = '$nickname ${emotes[random.nextInt(emotes.length)]}';
  }

  return nickname;
}