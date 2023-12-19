import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../products/data/model/product_model.dart';
import '../../../products/presentation/provider/product_provider.dart';
import '../../../search/presentation/provider/search_provider.dart';
import '../../../suppliers/data/model/supplier_model.dart';
import '../../../suppliers/presentation/provider/supplier_provider.dart';

class BarChartWidget extends StatefulWidget {
  ProductModel product;

  BarChartWidget({Key? key, required this.product}) : super(key: key);

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  Widget bottomTitleWidgetsBar(double value, TitleMeta meta) {
    String supplierName = context
        .watch<SupplierProvider>()
        .suppliers
        .firstWhere((element) =>
            element.id ==
            context
                .watch<ProductProvider>()
                .products
                .firstWhere((element) => element.id == 'VLmjBwRmjtE47FdH1uXY')
                .prices[value.toInt()]
                .supplierId)
        .name;

    return Text(supplierName);
  }

  double maxPrice = 0;
  double interval = 0;

  SideTitles leftTitles(double interval) => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: interval,
        reservedSize: 40,
      );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    return Text(value.toString(), style: style, textAlign: TextAlign.center);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: 600,
      child: BarChart(
        BarChartData(
            backgroundColor: Colors.white,
            maxY: maxPrice + interval,
            minY: 0,
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: leftTitles(interval.toDouble()),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  interval: 1,
                  getTitlesWidget: bottomTitleWidgetsBar,
                ),
              ),
            ),
            barGroups: List.generate(
                context
                    .watch<SearchProvider>()
                    .selectedProduct!
                    .getLatestPrices()
                    .length, (index) {
              double price = context
                  .watch<SearchProvider>()
                  .selectedProduct!
                  .getLatestPrices()[index]
                  .price;
              SupplierModel supplierModel = context
                  .read<SupplierProvider>()
                  .suppliers
                  .firstWhere((element) =>
                      element.id ==
                      context
                          .watch<ProductProvider>()
                          .products
                          .firstWhere(
                              (element) => element.id == widget.product.id)
                          .prices[index]
                          .supplierId);
              String supplierName = supplierModel.name;
              List<int> color =
                  List.generate(3, (index) => Random().nextInt(255));
              Color colorSupplier =
                  Color.fromRGBO(color[0], color[1], color[2], 1);

              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    borderRadius: const BorderRadius.all(Radius.circular(0)),
                    width: 20,
                    toY: price,
                    rodStackItems: [
                      BarChartRodStackItem(0, price, colorSupplier),
                    ],
                  ),
                ],
              );
            })),
        swapAnimationDuration: Duration(milliseconds: 150), // Optional
        swapAnimationCurve: Curves.linear, // Optional
      ),
    );
  }
}
