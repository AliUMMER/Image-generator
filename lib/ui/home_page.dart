import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_generator/bloc/genarator_bloc.dart';
import 'package:image_generator/repositery/model/genorater_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController messageController = TextEditingController();
  late Generatormodel data;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<GenaratorBloc>().add(FetchGenaratorEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffa653e8),
        leading: const Icon(
          Icons.menu_outlined,
          color: Colors.white,
        ),
        title: const Center(
          child: Text(
            'Text to Image',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: BlocBuilder<GenaratorBloc, GenaratorState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 320.0,
                    width: 320.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(width: 3, color: Colors.black),
                    ),
                    child: Builder(
                      builder: (context) {
                        if (state is GenaratorBlocLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is GenaratorBlocError) {
                          return const Center(
                              child: Text('Image not Generated'));
                        } else if (state is GenaratorBlocLoaded) {
                          data = BlocProvider.of<GenaratorBloc>(context)
                              .generatormodel!;
                          return Center(
                            child: Image.network(
                              data.message!.status.toString(),
                              fit: BoxFit.fill,
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(30),
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Enter your Text",
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final text = messageController.text.trim();
                      if (text.isNotEmpty) {
                        context
                            .read<GenaratorBloc>()
                            .add(FetchGenaratorEvent());
                      }
                    },
                    child: const Text(
                      'Generate',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffa653e8),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
