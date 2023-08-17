import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:vendor_app/core/theme/colors/landk_colors.dart';
import 'package:vendor_app/core/theme/fonts/landk_fonts.dart';
import 'package:vendor_app/core/tools/tools_widget.dart';

class MenuPage extends StatefulWidget {
  static Page page() => const MaterialPage(child: MenuPage());
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<String> titles = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    titles = [
      trans(context).yourLocation,
      trans(context).language,
      trans(context).view,
      trans(context).termsAndConditions,
      trans(context).complaintsAndSuggestions,
      trans(context).aboutLandk,
    ];
    return Scaffold(
      body: ListView.builder(
        itemCount: titles.length,
        itemBuilder: (context, index) {
          final e = titles[index];
          return Column(
            children: [
              if (index == 0) vSpace(1),
              ListTile(
                onTap: () {
                  _itemClick(index, context);
                },
                title: Text(e),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const Divider(thickness: 3),
            ],
          );
        },
      ),
    );
  }

  void _itemClick(int index, BuildContext context) {
    switch (index) {
      case 0:
        break;
      case 1:
        _showBottomSheet(context);
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
      case 5:
        break;
    }
  }

  PersistentBottomSheetController<dynamic> _showBottomSheet(
      BuildContext context) {
    return showBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: orange, width: 5)),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  trans(context).selectLanguage,
                  style: h4,
                ),
                dropDownButtonLang(context),
              ],
            ),
          );
        });
  }
}
