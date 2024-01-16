import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:vendor_app/core/constances/media_const.dart';
import 'package:vendor_app/core/shared/phone_num_field.dart';
import 'package:vendor_app/core/shared/pick_personal_photo.dart';
import 'package:vendor_app/core/tools/tools_widget.dart';

import '../../../../core/shared/txt_field.dart';
import '../../../../core/theme/colors/landk_colors.dart';
import '../../../../core/theme/fonts/landk_fonts.dart';
import '../bloc/auth_bloc.dart';

class AuthSignUpView extends StatefulWidget {
  const AuthSignUpView({
    super.key,
  });

  @override
  State<AuthSignUpView> createState() => _AuthSignUpViewState();
}

late AuthBloc bloc;

class _AuthSignUpViewState extends State<AuthSignUpView> {
  @override
  void initState() {
    bloc = context.read<AuthBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStates.success) {
            CoolAlert.show(
              context: context,
              type: CoolAlertType.warning,
              text: 'You can sign in when the admin accepts you',
              onConfirmBtnTap: () {
                context.pop();
              },
            );
          } else if (state.status == AuthStates.failure) {
            CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              text: state.message,
              onConfirmBtnTap: () {},
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                vSpace(3),
                vSpace(2),
                const AvatarPhoto(),
                vSpace(8),
                _FullName(),
                vSpace(2),
                _Email(),
                vSpace(2),
                _PhoneNum(),
                vSpace(2),
                _Password(),
                vSpace(2),
                _ConfirmPassword(),
                vSpace(3),
                const _SignUp(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AvatarPhoto extends StatelessWidget {
  const AvatarPhoto({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return bloc.photoPath.path.isEmpty
            ? PickPersonalPhoto(
                onTap: () async {
                  showPickImageBottomSheet(
                    context,
                    () async {
                      bloc.add(
                          const PickPhoto(imageSource: ImageSource.camera));
                      Navigator.pop(context);
                    },
                    () async {
                      bloc.add(
                          const PickPhoto(imageSource: ImageSource.gallery));
                      Navigator.pop(context);
                    },
                  );
                },
                radius: 40.sp,
                src: AssetImage(iPersonPng),
              )
            : PickPersonalPhoto(
                onTap: () async {
                  showPickImageBottomSheet(
                    context,
                    () async {
                      bloc.add(
                          const PickPhoto(imageSource: ImageSource.camera));
                      Navigator.pop(context);
                    },
                    () async {
                      bloc.add(
                          const PickPhoto(imageSource: ImageSource.gallery));
                      Navigator.pop(context);
                    },
                  );
                },
                radius: 40.sp,
                src: FileImage(bloc.photoPath),
              );
      },
    );
  }
}

class _SignUp extends StatelessWidget {
  const _SignUp();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () => bloc.add(SignUpEvent()),
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
                  trans(context).signUp,
                  style: btnFont.copyWith(fontWeight: FontWeight.bold),
                ),
        );
      },
    );
  }
}

class _FullName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, next) => previous.name != next.name,
      builder: (context, state) {
        return TxtField(
          onChange: (fullName) => bloc.add(NameChangeEvent(value: fullName)),
          icon: const Icon(Icons.person),
          label: trans(context).fullName,
          errorTxt:
              state.name.displayError != null ? 'invalid full name' : null,
        );
      },
    );
  }
}

class _PhoneNum extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, next) => previous.name != next.name,
      builder: (context, state) {
        return PhoneNumField(
          onChange: (String number) =>
              bloc.add(PhoneNumChangeEvent(value: number)),
        );
      },
    );
  }
}

class _Password extends StatefulWidget {
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
              bloc.add(PasswordChangeEvent(value: password)),
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

class _ConfirmPassword extends StatefulWidget {
  @override
  State<_ConfirmPassword> createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<_ConfirmPassword> {
  bool obsecure = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, next) =>
          previous.passwordConfirm != next.passwordConfirm,
      builder: (context, state) {
        return TxtField(
          inputType: TextInputType.visiblePassword,
          onChange: (password) =>
              bloc.add(PasswordConfirmChangeEvent(value: password)),
          icon: InkWell(
            onTap: () => setState(() => obsecure = !obsecure),
            child: Icon(obsecure ? Icons.visibility : Icons.visibility_off),
          ),
          obsecureTxt: obsecure,
          label: trans(context).confirmPassword,
          errorTxt:
              state.password.displayError != null ? 'password not match' : null,
        );
      },
    );
  }
}

class _Email extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, next) => previous.email != next.email,
      builder: (context, state) {
        return TxtField(
          onChange: (email) => bloc.add(EmailChangeEvent(value: email)),
          icon: const Icon(Icons.email),
          label: trans(context).email,
          inputType: TextInputType.emailAddress,
          errorTxt: state.email.displayError != null ? 'invalid email' : null,
        );
      },
    );
  }
}
