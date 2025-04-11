import '/exporter/exporter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../widgets/error_widget_with_retry.dart';
import '../../widgets/network_resources.dart';

class SplashScreen extends StatefulWidget {
  static const String path = "/splash-screen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void>? future;

  @override
  void initState() {
    super.initState();
    // fetchRegistrationState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: NetworkResource(
        future,
        error: (error) => ErrorWidgetWithRetry(
          exception: error,
          retry: () {
            // setState(() {
            //   future = null;
            // });
            // fetchRegistrationState();
          },
        ),
        success: (data) => const SizedBox(),
        loading: Center(
          child: Container(
            padding: const EdgeInsets.all(CustomPadding.paddingLarge),
            width: 140,
            height: 140,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: const Placeholder(),
          )
              .animate()
              .scaleXY(
                begin: 1.5,
                end: 1,
                duration: const Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
              )
              .then()
              .scaleXY(
                begin: 1,
                end: 10,
                duration: const Duration(seconds: 2),
                curve: Curves.fastOutSlowIn,
              )
              .fadeOut(),
        ),
      ),
    );
  }

//   void fetchRegistrationState() async {
//     setState(() {
//       future = Future.wait([
//         // DataRepository.i.fetchRegistrationState(),
//         Future.delayed(const Duration(seconds: 3)),
//       ]).then((value) {
//         // throw DioException(requestOptions: RequestOptions());
//         RegistrationState state = RegistrationState.completed;
//         // RegistrationState.fromString(value.first.data["state"]);
//         switch (state) {
//           case RegistrationState.basicDetails:
//           // Navigator.pushNamedAndRemoveUntil(
//           //     context, BasicDetailsForm.path, (route) => false);
//           // break;
//           case RegistrationState.programSelection:
//           // Navigator.pushNamedAndRemoveUntil(
//           //     context, ProgramSelectionForm.path, (route) => false);
//           // break;
//           case RegistrationState.completed:
//             Navigator.pushNamedAndRemoveUntil(
//               context,
//               NavigationScreen.path,
//               (route) => false,
//             );
//             break;
//         }
//       });
//     });
//   }
// }
}
