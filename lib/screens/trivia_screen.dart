import 'package:flutter/material.dart';
import '../services/trivia_repository.dart';
import '../models/trivia.dart';

class TriviaScreen extends StatefulWidget {
  const TriviaScreen({super.key});

  @override
  State<TriviaScreen> createState() => _TriviaScreenState();
}

class _TriviaScreenState extends State<TriviaScreen> {
  final TriviaRepository _repository = TriviaRepository();
  final TextEditingController _tickerController = TextEditingController(text: 'AAPL');
  
  Trivia? _trivia; // Здесь будет храниться акция
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _tickerController.dispose();
    super.dispose();
  }

  Future<void> _loadTrivia() async {
    final ticker = _tickerController.text.trim();
    if (ticker.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = null;
      _trivia = null;
    });

    try {
      final trivia = await _repository.fetchRandomTrivia(category: ticker);
      setState(() {
        _trivia = trivia;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString().replaceAll('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stock Price'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _tickerController,
              decoration: const InputDecoration(
                labelText: 'Тикер (AAPL, TSLA, MSFT...)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              textCapitalization: TextCapitalization.characters,
              onSubmitted: (_) => _loadTrivia(),
            ),
            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: _isLoading ? null : _loadTrivia,
              icon: const Icon(Icons.attach_money),
              label: Text(_isLoading ? 'Загрузка...' : 'Узнать цену'),
            ),
            const SizedBox(height: 24),

            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red, fontSize: 16), textAlign: TextAlign.center),

            if (_trivia != null)
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        _trivia!.ticker,
                        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${_trivia!.price.toStringAsFixed(2)} \$',
                        style: const TextStyle(fontSize: 28, color: Colors.green, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Биржа: ${_trivia!.exchange}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}