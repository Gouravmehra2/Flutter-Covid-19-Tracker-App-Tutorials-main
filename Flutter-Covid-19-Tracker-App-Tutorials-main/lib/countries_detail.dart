import 'package:covid_tracker/demo.dart';
import 'package:flutter/material.dart';

class CountryDetail extends StatefulWidget {
  String name,image,total,recovered,deaths,active;
  CountryDetail({required this.name,required this.active,required this.deaths,
  required this.image,required this.recovered,required this.total
  });

  @override
  State<CountryDetail> createState() => _CountryDetailState();
}

class _CountryDetailState extends State<CountryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name),centerTitle: true,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top:MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      Reuseable(title: 'TotalCases', value: widget.total),
                      SizedBox(height:20 ,),
                      Reuseable(title: 'ActiveCases', value: widget.active),
                      Reuseable(title: 'RecoveredCases', value: widget.recovered),
                      Reuseable(title: 'DeathCases', value: widget.deaths)
                    ],
                  ),
                ),
              ),
              CircleAvatar(radius: 35,
                backgroundImage: NetworkImage(widget.image)
              )
            ],
          )
        ],
      )
    );
  }
}