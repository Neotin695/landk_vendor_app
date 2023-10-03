import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:sizer/sizer.dart';
import 'package:vendor_app/core/theme/colors/landk_colors.dart';

import '../../../core/language/l10n/l10n.dart';
import '../../../core/language/lang.dart';
import '../../../core/services/common.dart';
import '../../auth/repository/authentication_repository.dart';
import '../app.dart';

class App extends StatelessWidget {
  const App({super.key, required this.authenticationRepository});

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (context) =>
            AppBloc(authenticationRepository: authenticationRepository),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_AppViewState>()?.restartApp();
  }

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        key: key,
        debugShowCheckedModeBanner: false,
        home: FlowBuilder<AppStatus>(
          state: context.select((AppBloc bloc) => bloc.state.status),
          onGeneratePages: onGenerateAuthPage,
        ),
        theme: themeData(),
        supportedLocales: L10n.all,
        locale: Common.prefs.getString('locale') != null
            ? Locale(Common.prefs.getString('locale')!)
            : const Locale('ar'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        builder: responsiveFramework,
      ),
    );
  }

  ThemeData themeData() {
    return ThemeData(
      primarySwatch: Colors.orange,
      fontFamily: 'Tajawal',
      inputDecorationTheme: InputDecorationTheme(
        focusColor: orange,
        hoverColor: orange,
        iconColor: orange,
        activeIndicatorBorder: BorderSide(color: orange),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: orange, width: 1.5),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget responsiveFramework(context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      );
}
