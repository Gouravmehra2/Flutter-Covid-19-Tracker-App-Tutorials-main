import 'dart:convert';

import 'package:covid_tracker/View/Model/worldApiModel.dart';
import 'package:covid_tracker/app_url.dart';
import 'package:covid_tracker/countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> with TickerProviderStateMixin{

  Future<WorldApiModel> getApidata()async{
    final respone = await http.get(Uri.parse(AppUrl.worldApi));
    var data =jsonDecode(respone.body.toString());
    if(respone.statusCode == 200){
      return WorldApiModel.fromJson(data);
    }else{
      throw Exception('error');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 42, 40, 40),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .01),
                FutureBuilder(
                  future: getApidata(),
                   builder: (context , AsyncSnapshot<WorldApiModel>snapshot){
                      if(!snapshot.hasData){
                        return Center(
                          child: SpinKitFadingCircle(
                            color: Colors.white,

                          ),
                        );
                      }
                      else{
                        return Column(
                          children: [
                            PieChart(
                  dataMap: {
                    'Total' : double.parse(snapshot.data!.cases.toString()),
                    'Recoverd':double.parse(snapshot.data!.recovered.toString()),
                    'Death' : double.parse(snapshot.data!.deaths.toString())
                  },
                  chartValuesOptions: ChartValuesOptions(showChartValuesInPercentage: true),
                  chartType:ChartType.ring,
                  animationDuration:Duration(seconds: 3),
                  chartRadius: 150,
                  legendOptions: LegendOptions(legendPosition: LegendPosition.left),
                  ),
                  SizedBox(height: 10,),
                  Card(
                    child: Column(
                      children: [
                        Reuseable(title: 'Total', value: snapshot.data!.cases.toString()),
                        Reuseable(title: 'Recoverd', value: snapshot.data!.recovered.toString()),
                        Reuseable(title: 'Death', value: snapshot.data!.deaths.toString()),
                        Reuseable(title: 'ActiveCases', value: snapshot.data!.active.toString()),
                        Reuseable(title: 'Population', value: snapshot.data!.population.toString()),
                        Reuseable(title: 'AffectedCountries', value: snapshot.data!.affectedCountries.toString()),
                        Reuseable(title: 'TodayDeaths', value: snapshot.data!.todayDeaths.toString()),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => CountriesList()));
                    },
                    child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 8, 136, 74),
                        borderRadius: BorderRadius.circular(10)
                         ),
                         child: Center(child: Text('Track')),
                      ),
                  )
                          ],
                        );
                      }
                   }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class Reuseable extends StatelessWidget {
  String title,value;
   Reuseable({Key? key,required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
      child: Column(
       children: [
        Row(
          children: [
            Expanded(flex: 5,child: Text(title)),
            Expanded(flex: 5,child: Text(value)),
          ],
        ),
        SizedBox(height: 10,),
        Divider(thickness: 2,)
       ],
      ),
    );
  }
}