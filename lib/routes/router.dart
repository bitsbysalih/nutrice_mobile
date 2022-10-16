import 'package:flutter_app/resources/pages/sign_in_page.dart';

import '../resources/pages/onboarding_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

/*
|--------------------------------------------------------------------------
| App Router
|
| * [Tip] Create pages faster 🚀
| Run the below in the terminal to create new a page.
| "flutter pub run nylo_framework:main make:page my_page"
| Learn more https://nylo.dev/docs/3.x/router
|--------------------------------------------------------------------------
*/

appRouter() => nyRoutes((router) {
      router.route("/", (context) => OnboardingPage(title: "Hello World"));

      // Add your routes here
      router.route(
        "/sign_in_page",
        (context) => SignInPage(),
        transition: PageTransitionType.leftToRight,
      );

      // router.route("/new-page", (context) => NewPage(), transition: PageTransitionType.fade);
    });
