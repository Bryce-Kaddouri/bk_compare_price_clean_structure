import 'package:bk_compare_price_mvc/src/features/suppliers/data/model/supplier_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../products/data/model/price_model.dart';
import '../../../search/presentation/provider/search_provider.dart';
import '../../../suppliers/presentation/provider/supplier_provider.dart';

class BarChartWidget extends StatefulWidget {
  BarChartWidget({Key? key}) : super(key: key);

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
                .watch<SearchProvider>()
                .selectedProduct!
                .getLatestPrices()[value.toInt()]
                .supplierId)
        .name;

    return Text(supplierName);
  }

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
            maxY: context.watch<SearchProvider>().barMaxPrice +
                context.watch<SearchProvider>().barInterval,
            minY: 0,
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles:
                    leftTitles(context.watch<SearchProvider>().barInterval),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
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
              /*double price = context
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
                          .watch<SearchProvider>()
                          .selectedProduct!
                          .getLatestPrices()[index]
                          .supplierId);
              String supplierName = supplierModel.name;*/
              PriceModel priceModel = context
                  .watch<SearchProvider>()
                  .selectedProduct!
                  .getLatestPrices()[index];
              double price = priceModel.price;
              String supplierId = priceModel.supplierId;
              SupplierModel supplierModel = context
                  .read<SupplierProvider>()
                  .suppliers
                  .firstWhere((element) => element.id == supplierId);
              Color colorSupplier = supplierModel.color;

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
