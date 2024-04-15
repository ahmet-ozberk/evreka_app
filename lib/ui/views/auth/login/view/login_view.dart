import 'package:evreka_app/app/constant/characters.dart';
import 'package:evreka_app/app/constant/constants.dart';
import 'package:evreka_app/app/extension/num_extension.dart';
import 'package:evreka_app/assets.dart';
import 'package:evreka_app/ui/components/buttons/app_button.dart';
import 'package:evreka_app/ui/components/text_fields/app_text_fields.dart';
import 'package:evreka_app/ui/views/auth/login/provider/login_provider.dart';
import 'package:evreka_app/ui/views/google_map/view/google_map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final read = ref.read(loginProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 132, bottom: 75),

                /// Svg resimde logoda bulunan yeşil renk gözükmediği için png formatı kullanılmıştır.
                child: Image.asset(Assets.image.imLogoPNG),
              ),
              Text(Constants.string.loginInfo, style: CharacterStyles.t2),
              56.height,

              /// TextField genişlikleri sabit verilmesi istendiği için tasarımda absürt duruyor.
              AppTextField(
                controller: read.emailController,
                label: Constants.string.username,
                keyboardType: TextInputType.emailAddress,
              ),
              43.5.height,
              AppTextField(
                controller: read.passwordController,
                label: Constants.string.password,
                obscureText: true,
              ),
              const Spacer(),
              AppButton(
                onPressed: () => read.login().then((value) => value
                    ? Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GoogleMapView(),
                        ),
                        (route) => false)
                    : null),
                text: Constants.string.login,
              ),
              28.height,
            ],
          ),
        ),
      ),
    );
  }
}
