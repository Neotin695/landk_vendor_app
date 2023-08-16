import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:sizer/sizer.dart';
import 'package:vendor_app/core/theme/colors/landk_colors.dart';
import 'package:vendor_app/core/theme/fonts/landk_fonts.dart';
import 'package:vendor_app/core/tools/tools_widget.dart';

import '../../../core/constances/media_const.dart';
import '../cubit/auth_cubit.dart';

class LocateLocationWidget extends StatefulWidget {
  const LocateLocationWidget({
    super.key,
  });

  @override
  State<LocateLocationWidget> createState() => _LocateLocationWidgetState();
}

late AuthCubit cubit;

class _LocateLocationWidgetState extends State<LocateLocationWidget> {
  @override
  void initState() {
    cubit = context.read<AuthCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          iPana,
          width: 30.w,
          height: 30.h,
        ),
        vSpace(5),
        Text(trans(context).locateVendorAdress,
            style: bold.copyWith(fontSize: 16.sp)),
        vSpace(2),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Text(
            trans(context).unableAddress,
            textAlign: TextAlign.center,
          ),
        ),
        vSpace(3),
        const _UseCurrentLocation(),
        vSpace(3),
        const _CreateStore(),
        vSpace(3),
        const _SetCurrentLocation()
      ],
    );
  }
}

class _SetCurrentLocation extends StatelessWidget {
  const _SetCurrentLocation();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        await cubit.setLocationOnMap(context);
      },
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        side: BorderSide(color: orange),
      ),
      child: Text(trans(context).setLocationFromMap),
    );
  }
}

class _UseCurrentLocation extends StatelessWidget {
  const _UseCurrentLocation();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == FormzSubmissionStatus.success) {
          showBottomSheet(
            context: context,
            elevation: 5,
            builder: (_) {
              return _bottomSheetWidget(context);
            },
          );
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () async {
            await cubit.getCurrentLocation();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: orange,
              foregroundColor: white,
              maximumSize: Size(92.w, 7.5.h),
              padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              )),
          child: state.status == FormzSubmissionStatus.inProgress
              ? loadingWidget()
              : Text(trans(context).useCurrentLocation),
        );
      },
    );
  }

  SizedBox _bottomSheetWidget(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(color: grey2),
              child: Center(
                child: Text(
                  trans(context).yourLocation,
                  style: h3,
                ),
              ),
            ),
            vSpace(2),
            Text(
              'Place Name: ${cubit.placeDatals['name'].toString()}',
              style: h4,
            ),
            vSpace(1),
            Text(
              'Street: ${cubit.placeDatals['street'].toString()}',
              style: h4,
            ),
            vSpace(1),
            Text(
              'Postal Code: ${cubit.placeDatals['postalcode'].toString()}',
              style: h4,
            ),
            vSpace(3),
          ],
        ),
      ),
    );
  }
}

class _CreateStore extends StatefulWidget {
  const _CreateStore();

  @override
  State<_CreateStore> createState() => _CreateStoreState();
}

class _CreateStoreState extends State<_CreateStore> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () async {
            if (mounted) {
              await cubit.createStore();
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: orange,
              foregroundColor: white,
              maximumSize: Size(92.w, 7.5.h),
              padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              )),
          child: state.status == FormzSubmissionStatus.inProgress
              ? loadingWidget()
              : Text(trans(context).createAccount),
        );
      },
    );
  }
}
