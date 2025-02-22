import 'package:covid_tracker/Services/stats_services.dart';
import 'package:covid_tracker/View/country_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.location_on,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 25),
                    hintText: 'Search the country',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.white30)),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: statsServices.getCountriesStats(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade600,
                            highlightColor: Colors.grey.shade100,
                            direction: ShimmerDirection.ltr,
                            child: ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                color: Colors.white,
                              ),
                              title: Container(
                                height: 10,
                                width: 50,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                  height: 10, width: 50, color: Colors.white),
                            ),
                          );
                        },
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name =
                              snapshot.data![index]['country'].toString();
                          if (searchController.text.isEmpty) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CountryDetails(
                                      name: snapshot.data![index]['country'],
                                      flag: snapshot.data![index]['countryInfo']
                                          ['flag'],
                                      active: snapshot.data![index]['active'],
                                      recovered: snapshot.data![index]
                                          ['recovered'],
                                      cases: snapshot.data![index]['cases'],
                                      deaths: snapshot.data![index]['deaths'],
                                      population: snapshot.data![index]
                                          ['population'],
                                    ),
                                  ),
                                );
                              },
                              hoverColor: Colors.white30,
                              child: Card(
                                child: ListTile(
                                  leading: Image(
                                    height: 40,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                            ['countryInfo']['flag']
                                        .toString()),
                                  ),
                                  title: Text(snapshot.data![index]['country']
                                      .toString()),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                ),
                              ),
                            );
                          } else if (name
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CountryDetails(
                                      name: snapshot.data![index]['country'],
                                      flag: snapshot.data![index]['countryInfo']
                                          ['flag'],
                                      active: snapshot.data![index]['active'],
                                      recovered: snapshot.data![index]
                                          ['recovered'],
                                      cases: snapshot.data![index]['cases'],
                                      deaths: snapshot.data![index]['deaths'],
                                      population: snapshot.data![index]
                                          ['population'],
                                    ),
                                  ),
                                );
                              },
                              hoverColor: Colors.white30,
                              child: Card(
                                child: ListTile(
                                  leading: Image(
                                    height: 40,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                            ['countryInfo']['flag']
                                        .toString()),
                                  ),
                                  title: Text(snapshot.data![index]['country']
                                      .toString()),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
