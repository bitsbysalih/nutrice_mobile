import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:nylo_framework/theme/helper/ny_theme.dart';

import '../../app/controllers/onboarding_controller.dart';
import '../../bootstrap/helpers.dart';
import '../../resources/widgets/safearea_widget.dart';

class OnboardingPage extends NyStatefulWidget {
  final HomeController controller = HomeController();
  final String title;

  OnboardingPage({Key? key, required this.title}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends NyState<OnboardingPage> {
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  bool _darkMode = false;

  @override
  init() async {
    await _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SafeAreaWidget(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                getImageAsset("nylo_logo.png"),
                height: 100,
                width: 100,
              ),
              Text(
                getEnv("APP_NAME"),
                style: textTheme.headline2,
              ),
              Text(
                "Micro-framework for Flutter",
                style: textTheme.subtitle1!
                    .setColor(context, (color) => color.primaryAccent),
                textAlign: TextAlign.center,
              ),
              Text(
                "Build something amazing 💡️",
                style: textTheme.bodyText2,
                textAlign: TextAlign.center,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Divider(),
                  Container(
                    height: 170,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                        color: ThemeColor.get(context).surfaceBackground,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 9,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        MaterialButton(
                          child: Text(
                            "documentation".tr().capitalize(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .setColor(
                                    context, (color) => color.surfaceContent),
                          ),
                          onPressed: widget.controller.onTapDocumentation,
                        ),
                        Divider(
                          height: 0,
                        ),
                        MaterialButton(
                          child: Text(
                            "GitHub",
                            style: textTheme.bodyText1!.setColor(
                                context, (color) => color.surfaceContent),
                          ),
                          onPressed: widget.controller.onTapGithub,
                        ),
                        Divider(height: 0),
                        MaterialButton(
                          child: Text(
                            "changelog".tr().capitalize(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .setColor(
                                    context, (color) => color.surfaceContent),
                          ),
                          onPressed: widget.controller.onTapChangeLog,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Framework Version: $nyloVersion",
                    style: textTheme.bodyText2!.copyWith(color: Colors.grey),
                  ),
                  Switch(
                      value: _darkMode,
                      onChanged: (value) {
                        _darkMode = value;
                        NyTheme.set(context,
                            id: getEnv(_darkMode == true
                                ? 'DARK_THEME_ID'
                                : 'LIGHT_THEME_ID'));
                        setState(() {});
                      }),
                  Text("${_darkMode == true ? "Dark" : "Light"} Mode"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
