import 'package:app_mobile/core/app_color.dart';
import 'package:app_mobile/core/app_string.dart';
import 'package:app_mobile/features/login/presentation/provider/user_provider.dart';
import 'package:app_mobile/features/login/presentation/widget/button.dart';
import 'package:app_mobile/features/login/presentation/widget/inputtext.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

final switchSignUp = StateProvider<bool>((ref) => false);

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(userProvider.notifier).loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final switchPage = ref.watch(switchSignUp);
    final state = ref.watch(userProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            switchPage
                ? Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppString.createAccount,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  )
                : Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppString.loginString,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
            const SizedBox(height: 24),
            switchPage
                ? Inputtext(
                    controller: userNameController,
                    label: AppString.enterUserName,
                  )
                : const SizedBox(),
            switchPage ? const SizedBox(height: 12) : const SizedBox(),
            Inputtext(controller: emailController, label: AppString.enterEmail),
            const SizedBox(height: 12),
            Inputtext(
              controller: passwordController,
              label: AppString.enterPassword,
            ),
            const SizedBox(height: 12),
            switchPage ? SizedBox() : Text(AppString.forgotPassword),
            const SizedBox(height: 12),
            Button(
              onTap: () async {
                if (switchPage) {
                  await ref
                      .read(userProvider.notifier)
                      .saveUser(
                        userName: userNameController.text.trim(),
                        userEmail: emailController.text.trim(),
                        userPassword: passwordController.text.trim(),
                      );
                } else {
                  final success = await ref
                      .read(userProvider.notifier)
                      .loginUser(
                        userEmail: emailController.text.trim(),
                        userPassword: passwordController.text.trim(),
                      );

                  if (success && state.status == UserStatus.success) {
                    context.go('/home');
                  } else {
                    toastification.show(
                      title: Text('Invalid email or password'),
                      autoCloseDuration: const Duration(seconds: 5),
                    );
                  }
                }
              },
              color: AppColor.slate,
              label: state.status == UserStatus.loading
                  ? CircularProgressIndicator()
                  : Text(AppString.loginToContinue),
            ),
            const SizedBox(height: 12),
            RichText(
              text: TextSpan(
                text: AppString.dontHaveAccount,
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: ' ${AppString.signUp}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        ref.read(switchSignUp.notifier).state = !switchPage;
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
