import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osce_genius/feature/presentation/blocs/prompt_bloc/prompt_bloc.dart';
import 'package:osce_genius/feature/presentation/screens/home_screen/home_screen.dart';
import 'package:osce_genius/feature/presentation/screens/osce_screen/osce_screen.dart';
import 'package:osce_genius/feature/presentation/screens/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const OSCEGenius());
}

class OSCEGenius extends StatelessWidget {
  const OSCEGenius({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PromptBloc(),
      child: MaterialApp(
        title: 'OSCE Genius',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/': (context) => const HomeScreen(),
          '/osce': (context) => const OsceScreen(),
        },
      ),
    );
  }
}
