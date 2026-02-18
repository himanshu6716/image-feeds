import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_feed/app/view/dashboard/bloc/dashboard_bloc.dart';
import 'package:image_feed/app/view/dashboard/dashboard_screen.dart';
import 'package:image_picker/image_picker.dart';

void main()async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MultiBlocProvider(
              providers: [
                BlocProvider<DashboardBloc>(
                  create: (_) => DashboardBloc(
                    ImagePicker(),
                    GetStorage(),
                  )
                ),
              ],
            child:MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Image View',
              home: DashboardScreen(),
            )
          );
        }
        );
  }
}


