import 'package:bk_compare_price_mvc/src/core/helper/date_helper.dart';
import 'package:bk_compare_price_mvc/src/features/line_chart/presentation/provider/line_chart_provider.dart';
import 'package:bk_compare_price_mvc/src/features/suppliers/presentation/provider/supplier_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../products/data/model/price_model.dart';
import '../../../search/presentation/provider/search_provider.dart';
import '../../../suppliers/data/model/supplier_model.dart';

class LineChartWidget extends StatefulWidget {
  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: 600,
      child: LineChart(
        lineChartData,
        swapAnimationDuration: const Duration(milliseconds: 250),
      ),
    );
  }

  LineChartData get lineChartData => LineChartData(
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                String supplierId = context
                    .read<SearchProvider>()
                    .suppliers[barSpot.barIndex.toInt()];
                SupplierModel supplier = context
                    .read<SupplierProvider>()
                    .suppliers
                    .firstWhere((element) => element.id == supplierId);
                PriceModel price = context
                    .read<SearchProvider>()
                    .selectedProduct!
                    .prices
                    .firstWhere((element) =>
                        element.supplierId == supplierId &&
                        DateHelper.getDayNumberInYear(element.dateTime) ==
                            barSpot.x.toInt());

                return LineTooltipItem(
                  supplier.name,
                  TextStyle(color: supplier.color),
                  children: <TextSpan>[
                    TextSpan(
                      text: '\n\$${price.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    TextSpan(
                      text:
                          '\n${DateHelper.getFormattedDate(price.dateTime).toString()}\n',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                );
              }).toList();
            },
            tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
          ),
        ),
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: List.generate(
            context.watch<SearchProvider>().suppliers.length, (index1) {
          String supplierId = context.watch<SearchProvider>().suppliers[index1];
          SupplierModel supplier = context
              .watch<SupplierProvider>()
              .suppliers
              .firstWhere((element) => element.id == supplierId);
          List<PriceModel> lstPrices = context
              .watch<SearchProvider>()
              .selectedProduct!
              .prices
              .where((element) => element.supplierId == supplierId)
              .toList();

          return LineChartBarData(
            isCurved: false,
            color: supplier.color,
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(
              show: false,
              color: supplier.color.withOpacity(0),
            ),
            spots: List.generate(lstPrices.length, (index2) {
              PriceModel price = lstPrices[index2];
              return FlSpot(
                  double.parse(
                      DateHelper.getDayNumberInYear(price.dateTime).toString()),
                  price.price);
            }),
          );
        }),
        minX: 1,
        maxX: double.parse(context
            .watch<LineChartProvider>()
            .numberOfDaysInSelectedYear
            .toString()),
        maxY: context.watch<SearchProvider>().lineMaxPrice,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text = value.toString();

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: context.watch<SearchProvider>().lineInterval,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    List<int> firstDayOfMonth =
        context.watch<LineChartProvider>().firstDayOfMonth;

    // -15 because we want to display the month in the middle of the month
    if (firstDayOfMonth.contains(value.toInt() - 15)) {
      if (isMobile) {
        text = Text(
          DateHelper.getMonthName(value.toInt(),
                  context.watch<LineChartProvider>().selectedYear)
              .substring(0, 1)
              .toUpperCase(),
          style: style,
          textAlign: TextAlign.center,
        );
      } else {
        text = Text(
          DateHelper.getMonthName(
              value.toInt(), context.watch<LineChartProvider>().selectedYear),
          style: style,
          textAlign: TextAlign.center,
        );
      }
    } else {
      text = const Text('');
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: false,
        verticalInterval: 30,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.withOpacity(0.5),
            strokeWidth: 1.5,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.grey.withOpacity(0.5),
            strokeWidth: 1.5,
          );
        },
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.5),
          left: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.5),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );
}
