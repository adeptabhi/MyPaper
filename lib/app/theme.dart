import 'package:flutter/material.dart';
import 'package:mypaper/app/app_colors.dart';

TextStyle textStyle({double? fontSize, FontWeight? fontWeight, Color? color}) {
  return TextStyle(
    fontSize: fontSize ?? 15,
    fontWeight: fontWeight ?? FontWeight.w400,
    color: color ?? Color(0xFF545454),
  );
}

ThemeData lightTheme = ThemeData(
  fontFamily: 'Poppins',
  appBarTheme: AppBarTheme(
    toolbarHeight: 65,
    backgroundColor: AppColors.blue,
    centerTitle: false,
    iconTheme: const IconThemeData(color: AppColors.white, size: 25),
    titleSpacing: 0,
    titleTextStyle: textStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
    ),
  ),
  dividerTheme: const DividerThemeData(thickness: 0.5, space: 10.0),
  tabBarTheme: TabBarThemeData(
    //  dividerColor: AppColorss.blue1,
    unselectedLabelColor: AppColors.blue,
    labelColor: AppColors.white,
    indicatorSize: TabBarIndicatorSize.tab,
    // indicatorColor: AppColors.quaternary,
    indicator: const BoxDecoration(
      color: AppColors.blue,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(6),
        topRight: Radius.circular(6),
        bottomLeft: Radius.circular(2.5),
        bottomRight: Radius.circular(2.5),
      ),
    ),
    labelStyle: textStyle(fontSize: 14, color: AppColors.blue),
    unselectedLabelStyle: textStyle(fontSize: 14, color: AppColors.blue),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.grey50,
    primary: AppColors.blue,
    secondary: AppColors.green50,
    tertiary: AppColors.blue50,
  ),
  cardTheme: CardThemeData(
    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    color: AppColors.grey15,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 2,
    surfaceTintColor: AppColors.blue15,
    shadowColor: AppColors.blue50,
  ),

  listTileTheme: ListTileThemeData(
    tileColor: AppColors.grey15,
    selectedTileColor: AppColors.red,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    iconColor: AppColors.grey,
    textColor: AppColors.grey,
    titleTextStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    subtitleTextStyle: const TextStyle(fontSize: 12, color: Colors.grey),
  ),
  sliderTheme: SliderThemeData(
    trackHeight: 2,
    overlayColor: AppColors.red,
    thumbColor: AppColors.red,
    inactiveTrackColor: AppColors.red,
    activeTrackColor: AppColors.red,
    secondaryActiveTrackColor: AppColors.red,
    thumbShape: SliderComponentShape.noThumb,
    disabledActiveTrackColor: AppColors.red,
    overlayShape: SliderComponentShape.noOverlay,
    disabledInactiveTrackColor: AppColors.red50,
  ),
  iconTheme: const IconThemeData(color: AppColors.blue),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all(0),
      padding: WidgetStateProperty.all(EdgeInsets.zero),
      minimumSize: WidgetStateProperty.all(Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
      ),
    ),
  ),
  useMaterial3: true,
  dialogTheme: DialogThemeData(
    actionsPadding: const EdgeInsets.all(5),
    surfaceTintColor: AppColors.white,
    backgroundColor: AppColors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.black15,
  ),
  inputDecorationTheme: InputDecorationTheme(
    suffixIconColor: AppColors.blue,
    prefixIconColor: AppColors.blue,
    hintStyle: textStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: AppColors.grey15,
    ),
    labelStyle: const TextStyle(color: Color.fromARGB(114, 0, 0, 0)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(color: AppColors.blue50, width: 0.7),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(color: AppColors.blue50, width: 0.7),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(color: AppColors.blue50, width: 0.7),
    ),
  ),
);

// AdeptTextFieldTheme textFieldTheme = AdeptTextFieldTheme(
//   fieldPadding: EdgeInsets.only(top: 15),
//   labelPadding: EdgeInsets.only(left: 3),
//   labelTextStyle: style(
//     fontSize: 15,
//     fontWeight: FontWeight.w500,
//     color: Color(0xFF222F36),
//   ),
//   hintTextStyle: style(
//     fontSize: 14,
//     fontWeight: FontWeight.w300,
//     color: Color(0xFF8E8E93),
//   ),
//   valueTextStyle: style(fontSize: 14, color: Color(0xFF222F36)),
//   inputDecoration: InputDecoration(
//     filled: true,
//     fillColor: Colors.white,
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(5.0),
//       borderSide: const BorderSide(color: AppColors.blue2, width: 0.1),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(5.0),
//       borderSide: const BorderSide(color: AppColors.blue2, width: 0.1),
//     ),
//     disabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(5.0),
//       borderSide: const BorderSide(color: AppColors.blue2, width: 0.1),
//     ),
//   ),
// );
// AdeptDropDownTheme dropDownTheme = AdeptDropDownTheme(
//   boxDecoration: BoxDecoration(
//     color: Colors.white,
//     borderRadius: BorderRadius.circular(5),
//     border: Border.all(color: Color(0xFFE2E6F1), width: 0.8),
//   ),
//   fieldPadding: EdgeInsets.only(top: 5),
//   labelPadding: EdgeInsets.only(left: 2),
//   labelTextStyle: style(fontSize: 15, color: Color(0xFF222F36)),
//   hintTextStyle: style(
//     fontSize: 14,
//     fontWeight: FontWeight.w400,
//     color: Color(0xFF8E8E93),
//   ),
//   valueTextStyle: style(
//     fontSize: 14,
//     fontWeight: FontWeight.w400,
//     color: Color(0xFF545454),
//   ),
//   suffixWidget: PrefixSuffixWidget(
//     isPrefix: false,
//     icon: Icons.keyboard_arrow_down,
//   ),
//   multiSelectItemBgColor: Color(0xFF1D4380).withValues(alpha: 0.15),
// );
