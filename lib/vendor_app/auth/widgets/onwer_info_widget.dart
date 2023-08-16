import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:sizer/sizer.dart';
import 'package:vendor_app/core/constances/media_const.dart';
import 'package:vendor_app/core/tools/tools_widget.dart';

import '../../../core/theme/colors/landk_colors.dart';
import '../../../core/theme/fonts/landk_fonts.dart';
import '../cubit/auth_cubit.dart';

class OnwerInfoWidget extends StatefulWidget {
  const OnwerInfoWidget({
    super.key,
  });

  @override
  State<OnwerInfoWidget> createState() => _OnwerInfoWidgetState();
}

late AuthCubit cubit;

class _OnwerInfoWidgetState extends State<OnwerInfoWidget> {
  @override
  void initState() {
    cubit = context.read<AuthCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          vSpace(3),
          Text(
            trans(context).onwerInfo,
            style: h3,
          ),
          vSpace(2),
          const AvatarPhoto(),
          vSpace(8),
          const _FullName(),
          vSpace(2),
          const _Email(),
          vSpace(2),
          const _Password(),
          vSpace(2),
          const _ConfirmPassword(),
          vSpace(3),
          const _NextBtn(),
        ],
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
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: orange,
          foregroundImage: AssetImage(iPersonPng),
        ),
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(300), color: white),
          child: InkWell(
            onTap: () {},
            child: Icon(
              Icons.camera,
              color: orange,
            ),
          ),
        )
      ],
    );
  }
}

class _NextBtn extends StatelessWidget {
  const _NextBtn();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () => cubit.controller.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut),
          style: ButtonStyle(
            alignment: Alignment.center,
            minimumSize: MaterialStateProperty.all(
              Size(90.w, 7.5.h),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(orange),
          ),
          child: state.status == FormzSubmissionStatus.inProgress
              ? SizedBox(
                  width: 5.w,
                  height: 5.h,
                  child: const Center(child: CircularProgressIndicator()))
              : Text(
                  trans(context).next,
                  style: btnFont.copyWith(fontWeight: FontWeight.bold),
                ),
        );
      },
    );
  }
}

class _FullName extends StatefulWidget {
  const _FullName();

  @override
  State<_FullName> createState() => _FullNameState();
}

class _FullNameState extends State<_FullName> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, next) => previous.fullName != next.fullName,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          child: TextField(
            onChanged: (fullName) =>
                mounted ? cubit.fullNameChanged(fullName) : null,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person),
              labelText: trans(context).fullName,
              errorText: state.fullName.displayError != null
                  ? 'invalid full name'
                  : null,
            ),
          ),
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, next) => previous.password != next.password,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          child: TextField(
            keyboardType: TextInputType.visiblePassword,
            key: const Key('password-input'),
            onChanged: (password) =>
                mounted ? cubit.passwordChanged(password) : null,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.password),
              labelText: trans(context).password,
              errorText: state.password.displayError != null
                  ? 'invalid password'
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class _ConfirmPassword extends StatefulWidget {
  const _ConfirmPassword();

  @override
  State<_ConfirmPassword> createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<_ConfirmPassword> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, next) =>
          previous.confirmedPassword != next.confirmedPassword,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          child: TextField(
            keyboardType: TextInputType.visiblePassword,
            key: const Key('password-input'),
            onChanged: (password) =>
                mounted ? cubit.confirmedPasswordChanged(password) : null,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.password),
              labelText: trans(context).password,
              errorText: state.confirmedPassword.displayError != null
                  ? 'password not match'
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class _Email extends StatefulWidget {
  const _Email();

  @override
  State<_Email> createState() => _EmailState();
}

class _EmailState extends State<_Email> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, next) => previous.email != next.email,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          child: TextField(
            key: const Key('email-input'),
            onChanged: (email) => mounted ? cubit.emailChanged(email) : null,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email),
              labelText: trans(context).email,
              errorText:
                  state.email.displayError != null ? 'invalid email' : null,
            ),
          ),
        );
      },
    );
  }
}