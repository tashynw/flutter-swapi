import 'dart:convert';
import 'package:flutter/material.dart';

class SpecificPerson extends StatefulWidget {
  const SpecificPerson({super.key, required this.name,required this.height, required this.mass, required this.gender});
  final String height;
  final String mass;
  final String gender;
  final String name;
  @override
  State<SpecificPerson> createState() => _SpecificPersonState();
}

class _SpecificPersonState extends State<SpecificPerson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text('Height: ${widget.height}'),
          Text('Mass: ${widget.mass}'),
          Text('Gender: ${widget.gender}'),
        ],
      ),
    );
  }
}