import 'package:flutter/material.dart';

class FingerHome extends StatefulWidget {
    const FingerHome({super.key});

    @override
    State<FingerHome> createState() => _FingerHomeState();
}

class _FingerHomeState extends State<FingerHome> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
                child: Text('Welcome'),
            ),
        );
    }
}