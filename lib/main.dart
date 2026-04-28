import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

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
      home: SplashCheck(),
    );
  }
}

class SplashCheck extends StatefulWidget {
  @override
  _SplashCheckState createState() => _SplashCheckState();
}

class _SplashCheckState extends State<SplashCheck> {
  @override
  void initState() {
    super.initState();
    verificarNome();
  }

  verificarNome() async {
    final prefs = await SharedPreferences.getInstance();
    final nome = prefs.getString("nome");

    if (nome == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => NomePage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage(nome: nome)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class NomePage extends StatefulWidget {
  @override
  _NomePageState createState() => _NomePageState();
}

class _NomePageState extends State<NomePage> {
  final controller = TextEditingController();

  salvarNome() async {
    if (controller.text.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("nome", controller.text);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomePage(nome: controller.text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Qual seu nome?", style: TextStyle(fontSize: 24)),
                SizedBox(height: 20),
                TextField(controller: controller),
                SizedBox(height: 20),
                ElevatedButton(onPressed: salvarNome, child: Text("Continuar")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String nome;

  HomePage({required this.nome});

  final List<String> signos = [
    "Áries",
    "Touro",
    "Gêmeos",
    "Câncer",
    "Leão",
    "Virgem",
    "Libra",
    "Escorpião",
    "Sagitário",
    "Capricórnio",
    "Aquário",
    "Peixes",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Olá, $nome")),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.all(20),
          itemCount: signos.length,
          itemBuilder: (context, index) {
            final signo = signos[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetalhePage(signo: signo, nome: nome),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 15),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(signo, style: TextStyle(fontSize: 20)),
              ),
            );
          },
        ),
      ),
    );
  }
}

class DetalhePage extends StatelessWidget {
  final String signo;
  final String nome;

  DetalhePage({required this.signo, required this.nome});

  final Map<String, List<String>> frases = {
    "Áries": ["Você está imparável hoje!"],
    "Touro": ["Estabilidade será sua força."],
    "Gêmeos": ["Comunicação abrirá portas."],
    "Câncer": ["Sua intuição estará forte."],
    "Leão": ["Brilhe sem medo."],
    "Virgem": ["Organização trará paz."],
    "Libra": ["Busque equilíbrio."],
    "Escorpião": ["Intensidade positiva."],
    "Sagitário": ["Aventure-se mais."],
    "Capricórnio": ["Foco total nos objetivos."],
    "Aquário": ["Inove hoje."],
    "Peixes": ["Confie no seu coração."],
  };

  final Map<String, String> imagens = {
    "Áries": "assets/signos/aries.png",
    "Touro": "assets/signos/touro.png",
    "Gêmeos": "assets/signos/gemeos.png",
    "Câncer": "assets/signos/cancer.png",
    "Leão": "assets/signos/leao.png",
    "Virgem": "assets/signos/virgem.png",
    "Libra": "assets/signos/libra.png",
    "Escorpião": "assets/signos/escorpiao.png",
    "Sagitário": "assets/signos/sagitario.png",
    "Capricórnio": "assets/signos/capricornio.png",
    "Aquário": "assets/signos/aquario.png",
    "Peixes": "assets/signos/peixes.png",
  };

  @override
  Widget build(BuildContext context) {
    final lista = frases[signo] ?? ["Hoje será especial."];
    final frase = lista[DateTime.now().day % lista.length];

    final img = imagens[signo]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(signo),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share(
                "Horóscopo de hoje para $signo:\n\n$frase\n\n— App Horóscopo",
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(30),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Olá, $nome", style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text(
                  signo,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  frase,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
