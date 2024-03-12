import 'package:aqua_assignment/core/resources/data_state.dart';
import 'package:aqua_assignment/features/home/data/data_sources/remote/api_service.dart';
import 'package:aqua_assignment/features/home/data/repositry_impl/product_repositry_impl.dart';
import 'package:aqua_assignment/features/home/domain/entity/product_entity.dart';
import 'package:aqua_assignment/features/home/domain/repositry/product_repositry.dart';
import 'package:aqua_assignment/features/home/domain/usecases/get_product_usecase.dart';
import 'package:aqua_assignment/splash.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
  a();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

Future<List<ProductEntity>> a() async {
  final instance = GetProductsUseCase(ProductRepositryImpl(ApiService(Dio())));
  final b = await instance.call();
  if (b is DataSuccess) {
    return b.data!;
  } else {
    return [];
  }
  // print(b);
}
