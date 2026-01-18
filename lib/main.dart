import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_routes.dart';
import 'views/product_list_view.dart';
import 'views/product_detail_view.dart';
import 'views/add_product_view.dart';
import 'bindings/product_binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? p_key}) : super(key: p_key);

  @override
  Widget build(BuildContext p_context) {
    return GetMaterialApp(
      title                     : 'Flutter GetX Products',
      debugShowCheckedModeBanner: false,
      initialBinding            : ProductBinding(),
      theme: ThemeData(
        colorScheme   : ColorScheme.fromSeed(
          seedColor   : Colors.blue,
          brightness  : Brightness.light,
        ),
        useMaterial3  : true,
        appBarTheme   : const AppBarTheme(
          centerTitle : true,
          elevation   : 0,
        ),
        cardTheme: CardThemeData(
          elevation   : 2,
          shape       : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            padding  : const EdgeInsets.symmetric(
              horizontal: 24,
              vertical  : 12,
            ),
          ),
        ),
      ),
      initialRoute: AppRoutes.v_productList,
      getPages    : [
        GetPage(
          name: AppRoutes.v_productList,
          page: () => const ProductListView(),
        ),
        GetPage(
          name: AppRoutes.v_productDetail,
          page: () => const ProductDetailView(),
        ),
        GetPage(
          name: AppRoutes.v_addProduct,
          page: () => const AddProductView(),
        ),
      ],
    );
  }
}
