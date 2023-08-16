import 'package:firebase_auth/firebase_auth.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

import '../routes/routes.dart';

class HomePage extends StatefulWidget {
  static Page page() => const MaterialPage(child: HomePage());
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FlowController<HomeState> _controller;

  @override
  void initState() {
    _controller = FlowController(HomeState.home);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout)),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}

class _FlowPage extends StatelessWidget {
  const _FlowPage({
    required FlowController<HomeState> controller,
  }) : _controller = controller;

  final FlowController<HomeState> _controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: FlowBuilder<HomeState>(
        controller: _controller,
        onGeneratePages: onGenerateHomePage,
      ),
    );
  }
}
