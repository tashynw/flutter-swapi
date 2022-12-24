import 'dart:convert';
//import 'dart:html';
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './routes/specificPerson.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SW-API',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var data = [];

  void loadPersons() async {
    var request = await http.get(Uri.parse('https://swapi.dev/api/people'));
    var persons = jsonDecode(request.body)['results'];
    setState(() {
      data = persons;
    });
  }

  @override
  void initState() {
    super.initState();

    loadPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFededed),
      body: Column(
        children: [
          const SizedBox(height: 70),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 30,
                width: 80,
                margin: const EdgeInsets.only(left: 15),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: const Center(child: Text("All Cards")),
              ),
              Container(
                height: 30,
                width: 80,
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
                child: const Center(child: Text("Tashyn")),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            child: const Divider(
              color: Colors.black,
              height: 10,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 16),
                child: const Text(
                  "All Cards > Select a card"
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            margin: const EdgeInsets.only(left: 16, right: 16),
            padding: const EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Search"),
                Icon(
                  Icons.search
                )
              ],
            ),
          ),  
          Expanded(
            child: ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (((context, index) {
              return InkWell(
                onTap: (() {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return SpecificPerson(
                          name: data[index]['name'],
                          height: data[index]['height'],
                          mass: data[index]['mass'],
                          gender: data[index]['gender']);
                    },
                  ));
                }),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  width: 300,
                  height: 300,
                  child: Column(
                    children: [
                      //purple box
                      Expanded(
                        child: Container(
                          width: 300,
                          height: 150,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            color: Colors.purple,
                          ),
                          child: Center(
                            child: Text(
                              data[index]["name"],
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      //details (green box)
                      Expanded(
                        child: Container(
                          width: 300,
                          height: 150,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            color: Colors.green,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //vehicles row
                              Container(
                                height: 30,
                                margin: const EdgeInsets.only(left: 8, right: 8),
                                padding: const EdgeInsets.only(left: 10,right: 10),
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Vehicles".toUpperCase()),
                                    const SizedBox(width:5),
                                    Text("${data[index]["vehicles"].length}")
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              //Starships row
                              Container(
                                padding: const EdgeInsets.only(left: 10,right: 10),
                                margin: const EdgeInsets.only(left: 8, right: 8),
                                height: 30,
                                decoration: const BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Starships".toUpperCase()),
                                    
                                    Text("${data[index]["starships"].length}")
                                  ],
                                ),
                              ),
                            ],
                          )
                        ),
                      )
                      
                    ],
                  ),
                ),
              );
            })),
          ),
          ),
        ],
      ),
    );
  }
}
