import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:vendor_app/core/constances/media_const.dart';
import 'package:vendor_app/core/shared/offline_widget.dart';
import 'package:vendor_app/core/shared/txt_field.dart';
import 'package:vendor_app/vendor_app/auth/presentation/bloc/auth_bloc.dart';
import '../../../../core/theme/colors/landk_colors.dart';
import '../../../../core/theme/fonts/landk_fonts.dart';
import '../../../../core/tools/tools_widget.dart';

class AuthSignInView extends StatefulWidget {
  const AuthSignInView({super.key});

  @override
  State<AuthSignInView> createState() => _AuthSignInViewState();
}

late AuthBloc bloc;

class _AuthSignInViewState extends State<AuthSignInView> {
  @override
  void initState() {
    bloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStates.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message.isEmpty
                    ? 'Authentication Failure'
                    : state.message),
              ),
            );
        } else if (state.status == AuthStates.success) {
          context.go('/home');
        }
      },
      child: OfflineWidget(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  vSpace(5),
                  SvgPicture.asset(iLogoOrange),
                  vSpace(5),
                  Text(
                    trans(context).welcome,
                    style: h3,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Text(
                      trans(context).welcomeMessage,
                      textAlign: TextAlign.center,
                      style: h6,
                    ),
                  ),
                  vSpace(5),
                  const _Email(),
                  vSpace(2),
                  const _Password(),
                  vSpace(2),
                  const _ForgotPassword(),
                  vSpace(2),
                  const _SignInBtn(),
                  vSpace(1),
                  const _CreateAccount(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ForgotPassword extends StatelessWidget {
  const _ForgotPassword();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: autoAlignCenter(context),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Text(
          trans(context).forgotPassword,
          style: const TextStyle(decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}

class _CreateAccount extends StatelessWidget {
  const _CreateAccount();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: autoAlignCenter(context),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Row(
          children: [
            Text(
              trans(context).dontHaveAccount,
              style: bold,
            ),
            TextButton(
              onPressed: () {
                context.go('/signup');
              },
              style: TextButton.styleFrom(
                foregroundColor: orange,
              ),
              child: Text(
                trans(context).signUp,
                style: h5.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SignInBtn extends StatelessWidget {
  const _SignInBtn();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () => bloc.add(SignInEvent()),
          style: ButtonStyle(
            alignment: Alignment.center,
            minimumSize: MaterialStateProperty.all(
              Size(90.w, 7.5.h),
            ),
            maximumSize: MaterialStateProperty.all(
              Size(90.w, 7.5.h),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(orange),
          ),
          child: state.status == AuthStates.loading
              ? loadingWidget()
              : Text(
                  trans(context).signIn,
                  style: btnFont,
                ),
        );
      },
    );
  }
}

class _Email extends StatelessWidget {
  const _Email();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, next) => previous.email != next.email,
      builder: (context, state) {
        return TxtField(
          onChange: (email) => bloc.add(EmailChangeSignInEvent(value: email)),
          icon: const Icon(Icons.email),
          label: trans(context).email,
          inputType: TextInputType.emailAddress,
          errorTxt: state.email.displayError != null ? 'invalid email' : null,
        );
      },
    );
  }
}

class _Password extends StatefulWidget {
  const _Password();

  @override
  State<_Password> createState() => _PasswordState();
}

class _PasswordState extends State<_Password> {
  bool obsecure = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, next) => previous.password != next.password,
      builder: (context, state) {
        return TxtField(
          inputType: TextInputType.visiblePassword,
          onChange: (password) =>
              bloc.add(PasswordChangeSignInEvent(value: password)),
          icon: InkWell(
            onTap: () => setState(() => obsecure = !obsecure),
            child: Icon(obsecure ? Icons.visibility : Icons.visibility_off),
          ),
          obsecureTxt: obsecure,
          label: trans(context).password,
          errorTxt:
              state.password.displayError != null ? 'invalid password' : null,
        );
      },
    );
  }
}
