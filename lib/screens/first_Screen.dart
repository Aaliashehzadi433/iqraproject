import 'dart:convert';
// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:iqra_project/screens/second_Screen.dart';
import 'package:dio/dio.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  //initialing dio liberary//
  Dio dio = Dio();

  // Variables and functions Area
  int id = 1;

  //  List<Map<String, dynamic>> studentsInfo= [];

  List studentsInfo = [];
  List products = [];

  //Function responsible for getting data from local json file

  Future<void> readJson() async {
    //readJson() async{
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    setState(() {
      studentsInfo = data["studentsInfo"];
    });
  }
  // API call for getting data from API server

  Future<void> getAPIcall() async {
    var url = Uri.parse('https://dummyjson.com/products'); //Access the link
    var response = await http.get(url); //make the call
    var data = await json.decode(response.body); //decode the Response
    setState(() {
      products = data['products']; //Save decoded response
    });
  }

  Future<void> getAPIcallDio() async {
    var url = ('https://dummyjson.com/products');
    try {
      var response = await dio.get(url); //make the call
      //decode the Response
      setState(() {
        products = response.data['products']; //Save decoded response
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // readJson();
    getAPIcall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        // leading: ,
        title: const Text(
          'Text',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        // actions: [],
      ),
      body: products.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    GestureDetector(
                      // onTap: () {

                      // Navigation From One Screen to Another

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => SecondScreen(
                      //       studentsInfo [index] ['id'],
                      //       studentsInfo [index] ['name'],
                      //       studentsInfo [index] ['fatherName'],
                      //       studentsInfo [index] ['department'],
                      //       studentsInfo [index] ['description'],
                      //     ),
                      //  ),
                      //  );
//  },

                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.black26,
                          radius: 15.0,
                          child: Image.network(products[index]['thumbnail']),
                        ),
                        //Text('${products[index]['id']}'),
                        title: Text('${products[index]['title']}'),
                        subtitle: Text('${products[index]['description']}'),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
    );
  }
}
