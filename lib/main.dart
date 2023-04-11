import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;
  Locale _locale = Locale('en');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color surfaceColor = Color(0x0dffffff);
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      theme: _themeMode == ThemeMode.dark
          ? MyAppThemeConfig.dark().getTheme(_locale.languageCode)
          : MyAppThemeConfig.light().getTheme(_locale.languageCode),
      home: MyHomePage(
        toggleThemeMode: () {
          setState(() {
            if (_themeMode == ThemeMode.dark)
              _themeMode = ThemeMode.light;
            else
              _themeMode = ThemeMode.dark;
          });
        },
        selectedLanguageChanged: (_Language newSelectedLanguageByUser) {
          setState(() {
            _locale = newSelectedLanguageByUser == _Language.en
                ? Locale('en')
                : Locale('fa');
          });
        },
      ),
    );
  }
}

class MyAppThemeConfig {
  static const String faPrimaryFontFamily = 'B-Titr-Bold';
  final Color primaryColor = Colors.pink.shade400;
  final Color primaryTextColor;
  final Color secondraryTextColor;
  final Color surfaceColor;
  final Color backgroundColor;
  final Color appBarColor;
  final Brightness brightness;

  MyAppThemeConfig.dark()
      : primaryTextColor = Colors.white,
        secondraryTextColor = Colors.white70,
        surfaceColor = Color(0x0dffffff),
        backgroundColor = Color.fromARGB(255, 30, 30, 30),
        appBarColor = Colors.black,
        brightness = Brightness.dark;

  MyAppThemeConfig.light()
      : primaryTextColor = Colors.grey.shade900,
        secondraryTextColor = Colors.grey.shade900.withOpacity(0.8),
        surfaceColor = Color(0x0d000000),
        backgroundColor = Colors.white,
        appBarColor = Color.fromARGB(255, 235, 235, 235),
        brightness = Brightness.light;

  ThemeData getTheme(String languageCode) {
    return ThemeData(
      // This is the theme of your application.
      //
      // Try running your application with "flutter run". You'll see the
      // application has a blue toolbar. Then, without quitting the app, try
      // changing the primarySwatch below to Colors.green and then invoke
      // "hot reload" (press "r" in the console where you ran "flutter run",
      // or simply save your changes to "hot reload" in a Flutter IDE).
      // Notice that the counter didn't reset back to zero; the application
      // is not restarted.
      primarySwatch: Colors.pink,
      primaryColor: primaryColor,
      brightness: brightness,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primaryColor))),
      dividerColor: surfaceColor,
      dividerTheme: DividerThemeData(
          color: Colors.white, indent: 32, endIndent: 32, thickness: 0.5),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: appBarColor,
          foregroundColor: primaryTextColor),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: surfaceColor,
      ),
      textTheme: languageCode == 'en' ? enPrimaryTextTheme : faPrimaryTextTheme,
    );
  }

  TextTheme get enPrimaryTextTheme => GoogleFonts.latoTextTheme(
        TextTheme(
            bodyText2: TextStyle(
              fontSize: 15,
              color: primaryTextColor,
            ),
            bodyText1: TextStyle(fontSize: 13, color: secondraryTextColor),
            headline6:
                TextStyle(fontWeight: FontWeight.w900, color: primaryTextColor),
            subtitle1: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryTextColor)),
      );

  TextTheme get faPrimaryTextTheme => TextTheme(
      bodyText2: TextStyle(
        fontSize: 15,
        color: primaryTextColor,
      ),
      bodyText1: TextStyle(
          fontSize: 13,
          height: 1.5,
          color: secondraryTextColor,
          fontFamily: faPrimaryFontFamily),
      headline6: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900,
          color: primaryTextColor,
          fontFamily: faPrimaryFontFamily),
      subtitle1: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: primaryTextColor,
          fontFamily: faPrimaryFontFamily),
      button: TextStyle(fontFamily: faPrimaryFontFamily));
}

class MyHomePage extends StatefulWidget {
  final Function() toggleThemeMode;
  final Function(_Language _language) selectedLanguageChanged;

  const MyHomePage(
      {super.key,
      required this.toggleThemeMode,
      required this.selectedLanguageChanged});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _SkillType _skill = _SkillType.photoshop;
  _Language _language = _Language.en;
  void _updateSelectedSkill(_SkillType skillType) {
    setState(() {
      this._skill = skillType;
    });
  }

  void _updateSelectedLanguage(_Language language) {
    widget.selectedLanguageChanged(language);
    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.profileTitle),
        actions: [
          Icon(CupertinoIcons.chat_bubble),
          InkWell(
            onTap: widget.toggleThemeMode,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
              child: Icon(CupertinoIcons.ellipsis_vertical),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/image/profile_image.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localization.name,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(localization.job),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.placemark,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              size: 14,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              localization.location,
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    CupertinoIcons.heart,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
              child: Text(
                localization.summary,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(localization.selectedLanguage),
                  CupertinoSlidingSegmentedControl<_Language>(
                      groupValue: _language,
                      thumbColor: Theme.of(context).colorScheme.primary,
                      children: {
                        _Language.en: Text(
                          localization.enLanguage,
                          style: TextStyle(fontSize: 14),
                        ),
                        _Language.fa: Text(
                          localization.faLanguage,
                          style: TextStyle(fontSize: 14),
                        ),
                      },
                      onValueChanged: (value) {
                        if (value != null) _updateSelectedLanguage(value);
                      })
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    localization.skills,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Icon(CupertinoIcons.chevron_down, size: 12)
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Center(
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 8,
                runSpacing: 8,
                children: [
                  Skill(
                    type: _SkillType.photoshop,
                    title: 'Photoshop',
                    imagePath: 'assets/image/app_icon_01.png',
                    shadowColor: Colors.blue,
                    isActive: _skill == _SkillType.photoshop,
                    onTop: () {
                      _updateSelectedSkill(_SkillType.photoshop);
                    },
                  ),
                  Skill(
                    type: _SkillType.xd,
                    title: 'Adobe XD',
                    imagePath: 'assets/image/app_icon_05.png',
                    shadowColor: Colors.pink,
                    isActive: _skill == _SkillType.xd,
                    onTop: () {
                      _updateSelectedSkill(_SkillType.xd);
                    },
                  ),
                  Skill(
                    type: _SkillType.illistrator,
                    title: 'illustrator',
                    imagePath: 'assets/image/app_icon_04.png',
                    shadowColor: Colors.orange,
                    isActive: _skill == _SkillType.illistrator,
                    onTop: () {
                      _updateSelectedSkill(_SkillType.illistrator);
                    },
                  ),
                  Skill(
                    type: _SkillType.afterEffect,
                    title: 'After Effect',
                    imagePath: 'assets/image/app_icon_03.png',
                    shadowColor: Colors.blue.shade800,
                    isActive: _skill == _SkillType.afterEffect,
                    onTop: () {
                      _updateSelectedSkill(_SkillType.afterEffect);
                    },
                  ),
                  Skill(
                    type: _SkillType.lightRoom,
                    title: 'Lightroom',
                    imagePath: 'assets/image/app_icon_02.png',
                    shadowColor: Colors.blue,
                    isActive: _skill == _SkillType.lightRoom,
                    onTop: () {
                      _updateSelectedSkill(_SkillType.lightRoom);
                    },
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localization.personalInformation,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: localization.email,
                        prefixIcon: Icon(CupertinoIcons.at)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: localization.password,
                        prefixIcon: Icon(CupertinoIcons.lock)),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(localization.save),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Skill extends StatelessWidget {
  final _SkillType type;
  final String title;
  final String imagePath;
  final Color shadowColor;
  final bool isActive;
  final Function() onTop;

  const Skill({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.shadowColor,
    required this.isActive,
    required this.type,
    required this.onTop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BorderRadius defaultBorderRadius = BorderRadius.circular(12);

    return InkWell(
      borderRadius: defaultBorderRadius,
      onTap: onTop,
      child: Container(
        width: 110,
        height: 110,
        decoration: isActive
            ? BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: defaultBorderRadius,
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: isActive
                  ? BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: shadowColor.withOpacity(0.5),
                            blurRadius: 20),
                      ],
                    )
                  : null,
              child: Image.asset(
                imagePath,
                width: 40,
                height: 40,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(title)
          ],
        ),
      ),
    );
  }
}

enum _SkillType {
  photoshop,
  xd,
  illistrator,
  afterEffect,
  lightRoom,
}

enum _Language {
  en,
  fa,
}
