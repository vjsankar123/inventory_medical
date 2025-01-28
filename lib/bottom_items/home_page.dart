import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin-cards/home_cards.dart';
import 'package:syncfusion_flutter_charts/charts.dart'; // Import Syncfusion charts package

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildStatusCards(context),
    );
  }
}

Widget buildStatusCards(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    CustomCard(
                      title: "Sale Amount",
                      data: "1234567",
                      gradient: LinearGradient(
                        colors: [Color(0xFF82f4b1), Color(0xFF30c67c)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      icon: Icons.currency_rupee,
                    ),
                    CustomCard(
                      title: "Product",
                      data: "4567",
                      gradient: LinearGradient(
                        colors: [Color(0xFFff930f), Color(0xFFfff95b)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      icon: Icons.shopping_cart,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 2),
              Expanded(
                child: Column(
                  children: [
                    CustomCard(
                      title: "Orders",
                      data: "23456",
                      gradient: LinearGradient(
                        colors: [Color(0xFFf9655b), Color(0xFFee821a)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      icon: Icons.check_circle,
                    ),
                    CustomCard(
                      title: "Customer",
                      data: "5678",
                      gradient: LinearGradient(
                        colors: [Color(0xFF456fe8), Color(0xFF19b0ec)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      icon: Icons.support_agent,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Overview',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(width: 8),
            ],
          ),
          SizedBox(height: 10),
          // Adding the Pie Chart
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SfCircularChart(
              legend: Legend(
                isVisible: true,
                overflowMode: LegendItemOverflowMode.wrap,
              ),
              tooltipBehavior:
                  TooltipBehavior(enable: true, format: 'point.x: point.y%'),
              series: <PieSeries<OverviewData, String>>[
                PieSeries<OverviewData, String>(
                  dataSource: [
                    OverviewData('Product', 40, 30, 20, 10, Colors.blue),
                    OverviewData('User', 400, 300, 200, 100, Colors.green),
                    OverviewData('Order', 600, 500, 400, 300, Colors.orange),
                    OverviewData('Out of Stock', 300, 200, 100, 50, Colors.red),
                  ],
                  xValueMapper: (OverviewData data, _) => data.category,
                  yValueMapper: (OverviewData data, _) => data.product,
                  dataLabelMapper: (OverviewData data, _) =>
                      '${data.category}\n${data.product}%',
                  pointColorMapper: (OverviewData data, _) =>
                      data.color, // Map colors
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  explode: true, // Explode the slices for better visualization
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// Data model for the chart
class OverviewData {
  OverviewData(this.category, this.product, this.user, this.order,
      this.outOfStock, this.color);

  final String category;
  final double product;
  final double user;
  final double order;
  final double outOfStock;
  final Color color; // Added color property
}
