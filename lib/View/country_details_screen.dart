import 'package:covid_tracker/View/world_stats_screen.dart';
import 'package:flutter/material.dart';

class CountryDetails extends StatefulWidget {
  final String name;
  final String flag;
  final int cases, deaths, recovered, active, population;
  const CountryDetails(
      {super.key,
      required this.name,
      required this.flag,
      required this.active,
      required this.recovered,
      required this.cases,
      required this.deaths,
      required this.population});

  @override
  State<CountryDetails> createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          widget.name,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.08),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        ReuseRow(
                            title: 'Cases', value: widget.cases.toString()),
                        ReuseRow(
                            title: 'Active', value: widget.active.toString()),
                        ReuseRow(
                            title: 'Recovered',
                            value: widget.recovered.toString()),
                        ReuseRow(
                            title: 'Deaths', value: widget.deaths.toString()),
                        ReuseRow(
                            title: 'Population',
                            value: widget.population.toString()),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 3,
                  shape:
                      const CircleBorder(side: BorderSide(color: Colors.white)),
                  child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.flag), radius: 55),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
