import 'dart:convert';
import 'package:covid_tracker/app_url.dart';
import 'package:covid_tracker/countries_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {

  TextEditingController _searchController = TextEditingController();

  Future<List<dynamic>> getCountriesApi()async{
    final respone = await http.get(Uri.parse(AppUrl.CountriesList));
    var data =jsonDecode(respone.body.toString());
    if(respone.statusCode == 200){
      return data;
    }else{
      throw Exception('error');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('countris'),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextFormField(
                onChanged: (value){
                  setState(() {
                    
                  });
                },
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search a Country Name',  
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)
                  )
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: getCountriesApi(), 
                  builder: (context,AsyncSnapshot<List<dynamic>>snapshot){
                    if(!snapshot.hasData){
                      return SpinKitFadingCircle(color: Colors.white);
                    }else{
                        return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context,index){
                          String name = snapshot.data![index]['country'].toString();
                          if(_searchController.text.isEmpty){
                            return Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, 
                                  MaterialPageRoute(builder: (context)=> CountryDetail(
                                    name:  snapshot.data![index]['country'].toString(),
                                    image :snapshot.data![index]['countryInfo']['flag'].toString(),
                                    total: snapshot.data![index]['cases'].toString(),
                                    recovered: snapshot.data![index]['recovered'].toString(),
                                    deaths: snapshot.data![index]['deaths'].toString(),
                                    active: snapshot.data![index]['active'].toString(),
                                  ))
                                  );
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle:  Text(snapshot.data![index]['country']),
                                  leading: Image(height: 50,width: 50,image: NetworkImage(
                                    snapshot.data![index]['countryInfo']['flag']
                                  )),
                                ),
                              ),
                            ],
                          );
                          }else if(name.toLowerCase().contains(_searchController.text.toLowerCase())){
                            return Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, 
                                  MaterialPageRoute(builder: (context)=> CountryDetail(
                                    name:  snapshot.data![index]['country'].toString(),
                                    image :snapshot.data![index]['countryInfo']['flag'].toString(),
                                    total: snapshot.data![index]['cases'].toString(),
                                    recovered: snapshot.data![index]['recovered'].toString(),
                                    deaths: snapshot.data![index]['deaths'].toString(),
                                    active: snapshot.data![index]['active'].toString(),
                                  ))
                                  );
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle:  Text(snapshot.data![index]['country']),
                                  leading: Image(height: 50,width: 50,image: NetworkImage(
                                    snapshot.data![index]['countryInfo']['flag']
                                  )),
                                ),
                              ),
                            ],
                          );
                          }
                          else{
                            return Container();
                          }
                        
                        });
                    }
                  }),
              ),
              SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }
}