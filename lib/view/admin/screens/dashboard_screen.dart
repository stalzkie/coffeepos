import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/hor_listitems.dart';
import 'package:coffee_inventory_app/viewmodels/sale_record_vm.dart';
import 'package:provider/provider.dart';
import '../widgets/drop_down.dart';

// class DashboardScreenNew extends StatelessWidget {
//   const DashboardScreenNew({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final Box<SaleRecord> salesBox = Hive.box<SaleRecord>('salesBox');

//     double _todayTotal = 0;
//     Map<String, double> weeklySales = {
//       'Mon': 0,
//       'Tue': 0,
//       'Wed': 0,
//       'Thu': 0,
//       'Fri': 0,
//       'Sat': 0,
//       'Sun': 0,
//     };

//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);

//     for (var sale in salesBox.values) {
//       DateTime saleDate = DateTime(sale.date.year, sale.date.month, sale.date.day);
//       if (saleDate == today) {
//         _todayTotal += sale.totalPrice;
//       }
//       String weekday = DateFormat.E().format(sale.date);
//       if (weeklySales.containsKey(weekday)) {
//         weeklySales[weekday] = (weeklySales[weekday] ?? 0) + sale.totalPrice;
//       }
//     }

//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: ListView(
//         children: [
//           const Text(
//             'Today\'s Sales',
//             style: TextStyle(color: Colors.white70, fontSize: 16),
//           ),
//           const SizedBox(height: 8),
//           Container(
//             padding: const EdgeInsets.all(20),
//             decoration: _glassBoxDecoration(),
//             child: Text(
//               "PHP ${_todayTotal.toStringAsFixed(2)}",
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 28,
//                 color: Colors.greenAccent,
//               ),
//             ),
//           ),
//           const SizedBox(height: 24),
//           const Text(
//             'Weekly Sales Graph',
//             style: TextStyle(color: Colors.white70, fontSize: 16),
//           ),
//           const SizedBox(height: 12),
//           Container(
//             height: 250,
//             decoration: _glassBoxDecoration(),
//             padding: const EdgeInsets.all(12),
//             child: buildBarChart(weeklySales),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildBarChart(Map<String, double> weeklySales) {
//     final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     double maxY = weeklySales.values.fold(0.0, (prev, value) => value > prev ? value : prev) + 20;

//     return BarChart(
//       BarChartData(
//         alignment: BarChartAlignment.spaceAround,
//         maxY: maxY,
//         borderData: FlBorderData(show: false),
//         titlesData: FlTitlesData(
//           leftTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               reservedSize: 40,
//               getTitlesWidget: (value, meta) {
//                 if (value % 20 == 0) {
//                   return Text(
//                     value.toInt().toString(),
//                     style: const TextStyle(color: Colors.white70, fontSize: 10),
//                   );
//                 }
//                 return const SizedBox.shrink();
//               },
//             ),
//           ),
//           rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//           topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: (value, meta) {
//                 final index = value.toInt();
//                 if (index >= 0 && index < days.length) {
//                   return Padding(
//                     padding: const EdgeInsets.only(top: 8.0),
//                     child: Text(
//                       days[index],
//                       style: const TextStyle(color: Colors.white70, fontSize: 12),
//                     ),
//                   );
//                 }
//                 return const SizedBox.shrink();
//               },
//             ),
//           ),
//         ),
//         barGroups: List.generate(days.length, (index) {
//           final value = weeklySales[days[index]] ?? 0;
//           return BarChartGroupData(
//             x: index,
//             barRods: [
//               BarChartRodData(
//                 toY: value,
//                 width: 18,
//                 borderRadius: BorderRadius.circular(4),
//                 color: Colors.greenAccent,
//               ),
//             ],
//           );
//         }),
//         gridData: FlGridData(show: false),
//       ),
//     );
//   }

//   BoxDecoration _glassBoxDecoration() {
//     return BoxDecoration(
//       color: Colors.white.withOpacity(0.05),
//       borderRadius: BorderRadius.circular(20),
//       border: Border.all(color: Colors.white.withOpacity(0.1)),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.08),
//           blurRadius: 10,
//           offset: const Offset(0, 4),
//         ),
//       ],
//     );
//   }
// }

class Dashboard extends StatefulWidget{
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardScreenState();
}


class _DashboardScreenState extends State<Dashboard>{
  
  @override
  void initState(){
    super.initState();

    Future.microtask((){
      final salesVm = context.read<SaleRecordViewModel>();
      salesVm.getTodayTotal();
      salesVm.getAllTimeTotal();
      salesVm.getWeeklySales();
      salesVm.getLeastPopularProduct();
      salesVm.getMostPopularProduct();
    });
  }

  @override
  Widget build(BuildContext context){
    Map<String, double> weeklySales = {
      'Mon': 0.5,
      'Tue': 0.5,
      'Wed': 0.5,
      'Thu': 0.5,
      'Fri': 0.5,
      'Sat': 0.5,
      'Sun': 0.5,
    };
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 231, 233),
      body: Consumer<SaleRecordViewModel>(
        builder: (context, viewModel, child) {
          weeklySales = viewModel.weeklySales;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropDown(),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                        Text(
                          "Weekly Sales",
                          style: TextStyle(fontSize: 36),
                        ),
                        Container(
                          height: 250,
                          decoration: _glassBoxDecoration(),
                          padding: const EdgeInsets.all(12),
                          child: buildBarChart(weeklySales),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Daily Sales",
                          style: TextStyle(fontSize: 36),
                        ),
                        Container(
                          height: 55,
                          width: 800,
                          padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                          decoration: _glassBoxDecoration(),
                          child: Text(
                            "10,000,000",
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        SizedBox(height: 30),
                        SizedBox(
                          height: 200,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              ListItem.number(
                                numToDisplay: viewModel.todayTotal.toInt().toString(),
                                message: "Products\nSold Today",
                              ),
                              SizedBox(width: 15),
                              ListItem.number(
                                numToDisplay: viewModel.allTimeTotal.toInt().toString(),
                                message: "Total\nProducts Sold",
                              ),
                              SizedBox(width: 15),
                              ListItem.product(
                                numToDisplay: viewModel.popularAmount,
                                message: "Most\nPopular Product",
                                prod_name: viewModel.popular,
                              ),
                              SizedBox(width: 15),
                              ListItem.product(
                                numToDisplay: viewModel.notPopularArmount,
                                message: "Least\nPopular Product",
                                prod_name: viewModel.notPopular,
                              ),
                            ],
                          ),
                        ),
                    ],
                  )
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<String> getChartDates(){
    List<String> dates = [];

    return dates;
  }

  Widget buildBarChart(Map<String, dynamic> weeklySales) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']; // change to dynamic dates ui
    double maxY = weeklySales.values.fold(0.0, (prev, value) => value > prev ? value : prev)+ 20;
    print("maxY: $maxY");

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY,
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                if (value % 20 == 0) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 10),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < days.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      days[index],
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        barGroups: List.generate(days.length, (index) {
          final value = weeklySales[days[index]] ?? 0;
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: value,
                width: 18,
                borderRadius: BorderRadius.circular(4),
                color: Colors.greenAccent,
              ),
            ],
          );
        }),
        gridData: FlGridData(show: false),
      ),
    );
  }

  BoxDecoration _glassBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}