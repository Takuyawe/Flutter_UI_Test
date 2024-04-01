import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:study_ui/views/home.dart';

final themeMode = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system;
});

void main() {
  initializeDateFormatting()
      .then((_) => runApp(const ProviderScope(child: MyApp())));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeMode);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      themeMode: currentThemeMode,
      home: const Home(),
    );
  }
}

// class ProviderWidget extends ConsumerWidget {
//   const ProviderWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return const Home();
//   }
// }
