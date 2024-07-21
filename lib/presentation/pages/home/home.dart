import 'package:crossword_admin/presentation/widgets/alphabet_dropdown.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ValueNotifier<String?> _valueNotifier;
  late final TextEditingController _controller;
  late final ValueNotifier<int?> _wordCountNotifier;

  @override
  void initState() {
    super.initState();
    _wordCountNotifier = ValueNotifier(0);
    _valueNotifier = ValueNotifier(null);
    _controller = TextEditingController()..addListener(_collectFirstWords);
  }

  @override
  void dispose() {
    _controller.removeListener(_collectFirstWords);

    _valueNotifier.dispose();
    _controller.dispose();
    _wordCountNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AlphabetDropdown(valueNotifier: _valueNotifier),
            const SizedBox(height: 10),
            ValueListenableBuilder(
              valueListenable: _wordCountNotifier,
              builder: (context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '${_wordCountNotifier.value} söz',
                      style: const TextStyle(fontSize: 24),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Əlavə et'),
                    )
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: null,
                expands: true,
                style: const TextStyle(fontSize: 20),
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _collectFirstWords() {
    String text = _controller.text;
    List<String> lines = text.split('\n');
    List<String> firstWords = [];
    for (String line in lines) {
      if (line.trim().isNotEmpty) {
        firstWords.add(line.split(' ').first);
      }
    }
    print(firstWords);
    _wordCountNotifier.value = firstWords.length;
  }
}
