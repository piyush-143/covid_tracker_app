import 'package:covid_tracker/Services/stats_services.dart';
import 'package:covid_tracker/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({super.key});

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: statsServices.getWorldStats(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: SpinKitDualRing(
                  color: Colors.grey,
                  size: 50,
                  controller: _controller,
                ),
              );
            } else {
              return Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.09),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: PieChart(
                      dataMap: {
                        'Total': double.parse(snapshot.data!.cases.toString()),
                        'Recovered':
                            double.parse(snapshot.data!.recovered.toString()),
                        'Death': double.parse(snapshot.data!.deaths.toString()),
                      },
                      chartValuesOptions: const ChartValuesOptions(
                          showChartValuesInPercentage: true),
                      animationDuration: const Duration(seconds: 1),
                      colorList: const [
                        Colors.blueAccent,
                        Colors.green,
                        Colors.red,
                      ],
                      chartType: ChartType.ring,
                      chartRadius: 140,
                      legendOptions: const LegendOptions(
                          legendShape: BoxShape.circle,
                          legendPosition: LegendPosition.left,
                          legendTextStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.04,
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    elevation: 3,
                    child: Column(
                      children: [
                        ReuseRow(
                            title: 'Total',
                            value: snapshot.data!.cases.toString()),
                        ReuseRow(
                            title: 'Recovered',
                            value: snapshot.data!.recovered.toString()),
                        ReuseRow(
                            title: 'Active',
                            value: snapshot.data!.active.toString()),
                        ReuseRow(
                            title: 'Today Recovered',
                            value: snapshot.data!.todayRecovered.toString()),
                        ReuseRow(
                            title: 'Population',
                            value: snapshot.data!.population.toString()),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CountriesList(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      fixedSize: WidgetStateProperty.all(const Size(250, 40)),
                      elevation: const WidgetStatePropertyAll(3),
                      backgroundColor:
                          const WidgetStatePropertyAll(Colors.blueAccent),
                    ),
                    child: const Text(
                      'Track Countries',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class ReuseRow extends StatelessWidget {
  final String title, value;
  const ReuseRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 5,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          const Divider(
            height: 20,
            color: Colors.white30,
          ),
        ],
      ),
    );
  }
}
