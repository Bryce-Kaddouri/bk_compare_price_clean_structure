import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../products/data/model/price_model.dart';
import '../../../search/presentation/provider/search_provider.dart';

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
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: List.generate(
            context.watch<SearchProvider>().suppliers.length,
                (index1){
              String supplierId = context.watch<SearchProvider>().suppliers[index1];
              List<PriceModel> lstPrices= context.watch<SearchProvider>().selectedProduct!.prices.where((element) => element.supplierId == supplierId).toList();
              print(lstPrices.length);
              print(supplierId);
              return LineChartBarData(
          isCurved: false,
          color: AppColors.contentColorPink,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData:  FlDotData(show: true),
          belowBarData: BarAreaData(
            show: false,
            color: AppColors.contentColorPink.withOpacity(0),
          ),
          spots: List.generate(
              lstPrices.length,
                  (index2) {
                PriceModel price = lstPrices[index2];
                print(price.toMap());
                return FlSpot(price.dateTime.month.toDouble(), price.price);
                  }),
        );}),
        minX: 1,
        maxX: 12,
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
        rightTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
        lineChartBarData1_3,
      ];

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
    switch (value.toInt()) {
      case 1:
        text = isMobile ? const Text('J', style: style) :
        const Text('JAN', style: style);
        break;
      case 2:
        text = isMobile ? const Text('F', style: style) :
        const Text('FEB', style: style);
        break;
      case 3:
        text = isMobile ? const Text('M', style: style) :
        const Text('MAR', style: style);
        break;
      case 4:
        text = isMobile ? const Text('A', style: style) :
        const Text('APR', style: style);
        break;
      case 5:
        text = isMobile ? const Text('M', style: style) :
        const Text('MAY', style: style);
        break;
      case 6:
        text = isMobile ? const Text('J', style: style) :
        const Text('JUN', style: style);
        break;
      case 7:
        text = isMobile ? const Text('J', style: style) :
        const Text('JUL', style: style);
        break;
      case 8:
        text = isMobile ? const Text('A', style: style) :
        const Text('AUG', style: style);
        break;
      case 9:
        text = isMobile ? const Text('S', style: style) :
        const Text('SEP', style: style);
        break;
      case 10:
        text = isMobile ? const Text('O', style: style) :
        const Text('OCT', style: style);
        break;
      case 11:
        text = isMobile ? const Text('N', style: style) :
        const Text('NOV', style: style);
        break;
      case 12:
        text = isMobile ? const Text('D', style: style) :
        const Text('DEC', style: style);
        break;
      default:
        text = const Text('');
        break;
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

  FlGridData get gridData =>  FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom:
              BorderSide(color: AppColors.primary.withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: false,
        color: AppColors.contentColorGreen,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData:  FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 1.5),
          FlSpot(5, 1.4),
          FlSpot(7, 3.4),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: false,
        color: AppColors.contentColorPink,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData:  FlDotData(show: true),
        belowBarData: BarAreaData(
          show: false,
          color: AppColors.contentColorPink.withOpacity(0),
        ),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
      );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
        isCurved: false,
        color: AppColors.contentColorCyan,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData:  FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 2.8),
          FlSpot(3, 1.9),
          FlSpot(6, 3),
          FlSpot(10, 1.3),
          FlSpot(13, 2.5),
        ],
      );
}

class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}
