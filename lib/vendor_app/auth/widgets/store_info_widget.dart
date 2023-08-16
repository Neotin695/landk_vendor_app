import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:vendor_app/core/services/image_picker/image_picker_mixin.dart';
import 'package:vendor_app/core/tools/tools_widget.dart';

import '../../../core/shared/pick_image_widget.dart';
import '../../../core/theme/colors/landk_colors.dart';
import '../../../core/theme/fonts/landk_fonts.dart';
import '../cubit/auth_cubit.dart';

class StoreInfoWidget extends StatefulWidget {
  const StoreInfoWidget({
    super.key,
  });

  @override
  State<StoreInfoWidget> createState() => _StoreInfoWidgetState();
}

late AuthCubit cubit;

class _StoreInfoWidgetState extends State<StoreInfoWidget> with PickMediaMixin {
  @override
  void initState() {
    cubit = context.read<AuthCubit>();
    if (mounted) {
      cubit.fetchAllCategories();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(trans(context).pleaseSelectImages),
                ),
              );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            vSpace(3),
            Text(
              trans(context).storeInfo,
              style: h3,
            ),
            vSpace(2),
            _imageSection(context),
            vSpace(8),
            const _Name(),
            vSpace(2),
            const _Address(),
            vSpace(2),
            const _PhoneNum(),
            vSpace(3),
            _dropDownButton(context),
            vSpace(3),
            const _NextBtn(),
          ],
        ),
      ),
    );
  }

  BlocBuilder<AuthCubit, AuthState> _dropDownButton(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return DropdownButton(
          hint: Text(
              locale(context) ? cubit.category.nameAr : cubit.category.nameEn),
          items: cubit.categories
              .map<DropdownMenuItem<String>>(
                (e) => DropdownMenuItem(
                  value: e.id,
                  child: Text(locale(context) ? e.nameAr : e.nameEn),
                ),
              )
              .toList(),
          onChanged: (value) {
            cubit.category =
                cubit.categories.firstWhere((element) => element.id == value);
            setState(() {});
          },
        );
      },
    );
  }

  Row _imageSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        PickImageWidget(
          label: trans(context).logo,
          width: 30,
          height: 15,
          onTap: () async {
            _showBottomSheet(
              context,
              () async {
                cubit.logoPath = await pickSingleImage(ImageSource.camera);

                setState(() {
                  Navigator.pop(context);
                });
              },
              () async {
                cubit.logoPath = await pickSingleImage(ImageSource.gallery);
                setState(() {
                  Navigator.pop(context);
                });
              },
            );
          },
          source: File(cubit.logoPath ?? ''),
        ),
        PickImageWidget(
          label: trans(context).imageCover,
          width: 50,
          height: 15,
          onTap: () {
            _showBottomSheet(
              context,
              () async {
                cubit.coverPath = await pickSingleImage(ImageSource.camera);
                setState(() {
                  Navigator.pop(context);
                });
              },
              () async {
                cubit.coverPath = await pickSingleImage(ImageSource.gallery);
                setState(() {
                  Navigator.pop(context);
                });
              },
            );
          },
          source: File(cubit.coverPath ?? ''),
        ),
      ],
    );
  }

  _showBottomSheet(BuildContext context, cameraMethod, galleryMethod) {
    return showBottomSheet(
        context: context,
        builder: (context) {
          return Row(
            children: [
              IconButton(
                  onPressed: cameraMethod, icon: const Icon(Icons.camera)),
              IconButton(
                  onPressed: galleryMethod,
                  icon: const Icon(Icons.photo_album)),
            ],
          );
        });
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

class _Name extends StatelessWidget {
  const _Name();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, next) => previous.name != next.name,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          child: TextField(
            textDirection: directionField(context),
            onChanged: (name) => cubit.nameChanged(name),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email),
              labelText: trans(context).vendorName,
              errorText:
                  state.name.displayError != null ? 'invalid name' : null,
            ),
          ),
        );
      },
    );
  }
}

class _PhoneNum extends StatelessWidget {
  const _PhoneNum();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, next) => previous.phone != next.phone,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          child: TextField(
            onChanged: (phoneNum) => cubit.phoneChanged(phoneNum),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.phone),
              labelText: trans(context).phoneNum,
              errorText: state.phone.displayError != null
                  ? 'invalid Phone Number'
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class _Address extends StatelessWidget {
  const _Address();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, next) => previous.address != next.address,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          child: TextField(
            textDirection: directionField(context),
            onChanged: (address) => cubit.addressChanged(address),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.location_city),
              labelText: trans(context).vendorAddress,
              errorText:
                  state.address.displayError != null ? 'invalid address' : null,
            ),
          ),
        );
      },
    );
  }
}
