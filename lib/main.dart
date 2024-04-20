import 'package:flutter/material.dart';
import 'package:yemeksiparis/ui/cubit/anasayfa_cubit.dart';
import 'package:yemeksiparis/ui/cubit/detaysayfa_cubit.dart';
import 'package:yemeksiparis/ui/cubit/favorilersayfa_cubit.dart';
import 'package:yemeksiparis/ui/cubit/sepetsayfa_cubit.dart';
import 'package:yemeksiparis/ui/views/anasayfa.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AnaSayfaCubit(),),
        BlocProvider(create: (context) => DetaySayfaCubit(),),
        BlocProvider(create: (context) => SepetSayfaCubit(),),
        BlocProvider(create: (context) => FavorilerSayfaCubit(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: AnaSayfa(),
      ),
    );
  }
}
