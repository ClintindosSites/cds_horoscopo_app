import 'package:flutter/material.dart';

void main() {
  runApp(HoroscopoApp());
}

class HoroscopoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horóscopo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Map<String, String>> signos = [
    {"nome": "Áries", "emoji": "🔥"},
    {"nome": "Touro", "emoji": "🐂"},
    {"nome": "Gêmeos", "emoji": "👯"},
    {"nome": "Câncer", "emoji": "🦀"},
    {"nome": "Leão", "emoji": "🦁"},
    {"nome": "Virgem", "emoji": "🌾"},
    {"nome": "Libra", "emoji": "⚖️"},
    {"nome": "Escorpião", "emoji": "🦂"},
    {"nome": "Sagitário", "emoji": "🏹"},
    {"nome": "Capricórnio", "emoji": "🐐"},
    {"nome": "Aquário", "emoji": "🌊"},
    {"nome": "Peixes", "emoji": "🐟"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("🔮 Seu Horóscopo"), centerTitle: true),
      body: ListView.builder(
        itemCount: signos.length,
        itemBuilder: (context, index) {
          final signo = signos[index];

          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                "${signo["emoji"]} ${signo["nome"]}",
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetalhePage(signo: signo["nome"]!),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DetalhePage extends StatelessWidget {
  final String signo;

  DetalhePage({required this.signo});

  final Map<String, List<String>> frases = {
    "Áries": [
      "Hoje é um ótimo dia para agir!",
      "Evite discussões desnecessárias.",
    ],
    "Touro": [
      "Foque no seu crescimento financeiro.",
      "Um momento de paz está chegando.",
    ],
    "Gêmeos": ["Comunicação será sua chave hoje.", "Uma novidade pode surgir."],
    "Câncer": ["Cuide das emoções.", "Aproxime-se de quem você ama."],
    "Leão": ["Você estará em destaque hoje!", "Aproveite sua energia."],
    "Virgem": ["Organize sua rotina.", "Pequenos detalhes farão diferença."],
    "Libra": ["Busque equilíbrio.", "Evite decisões impulsivas."],
    "Escorpião": ["Dia de intensidade.", "Confie na sua intuição."],
    "Sagitário": ["Aventure-se mais.", "Boas notícias podem chegar."],
    "Capricórnio": [
      "Disciplina será recompensada.",
      "Foque nos seus objetivos.",
    ],
    "Aquário": ["Ideias novas surgirão.", "Seja criativo."],
    "Peixes": ["Use sua sensibilidade.", "Dia favorável para reflexão."],
  };

  @override
  Widget build(BuildContext context) {
    final lista = frases[signo] ?? ["Hoje será um bom dia!"];
    lista.shuffle();
    final frase = lista.first;

    return Scaffold(
      appBar: AppBar(title: Text(signo)),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            frase,
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
