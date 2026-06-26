import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(SignosDoDestino());
}

class SignosDoDestino extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signos do Destino',
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
            image: AssetImage("assets/bg.webp"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Seja bem vindo ao Signos do Destino! Para começarmos, qual seu nome?",
                  style: TextStyle(fontSize: 24),
                ),
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
            image: AssetImage("assets/bg.webp"),
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
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.only(bottom: 15),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.3),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
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
    "Áries": [
      "Você está entrando em um momento em que sua coragem será colocada à prova de maneira positiva. Muitas vezes você sente que precisa resolver tudo rapidamente, mas o universo está mostrando que sua força não está apenas na velocidade, e sim na capacidade de continuar avançando mesmo diante das dificuldades. Hoje é um excelente momento para confiar mais em si mesmo, iniciar projetos que estavam parados e mostrar ao mundo sua verdadeira energia. Pessoas ao seu redor irão perceber sua determinação e podem se inspirar na sua atitude. Não tenha medo de tomar decisões importantes, porque sua intuição estará mais forte do que imagina.",
      "Sua energia está intensa e cheia de possibilidades. Este é o momento ideal para abandonar pensamentos negativos que estavam atrasando seu crescimento pessoal. O signo de Áries possui uma capacidade incrível de recomeçar mesmo após momentos difíceis, e exatamente por isso você deve usar este período para construir algo maior para sua vida. Acredite mais no seu potencial e não permita que comentários pessimistas diminuam sua motivação. Grandes oportunidades surgem quando você age com confiança e determinação. Continue caminhando com coragem, pois o universo está preparando mudanças importantes para você.",
      "Hoje você poderá perceber sinais de crescimento em áreas que antes pareciam completamente travadas. Seu espírito competitivo e sua vontade de vencer serão essenciais para superar qualquer desafio que surgir no caminho. Não permita que pequenas frustrações tirem seu foco principal. Você nasceu para liderar e conquistar espaços importantes, mas para isso será necessário manter a disciplina e controlar a impulsividade em alguns momentos. Pessoas próximas poderão buscar seus conselhos e sua presença será percebida de forma marcante. Aproveite essa fase para fortalecer seus sonhos e acreditar ainda mais na sua própria capacidade.",
      "O universo está enviando uma energia poderosa de renovação para sua vida. Muitas vezes você sente vontade de desistir quando as coisas não acontecem rapidamente, mas hoje será um ótimo dia para lembrar que cada passo dado faz diferença no seu futuro. Sua coragem é uma das maiores qualidades do seu signo e ela será fundamental para abrir portas importantes. Evite desperdiçar sua energia com conflitos desnecessários e foque em tudo aquilo que realmente pode trazer crescimento. Você tem potencial para conquistar muito mais do que imagina, principalmente quando age com confiança e maturidade.",
    ],
    "Touro": [
      "Você está vivendo uma fase em que a estabilidade emocional e financeira pode começar a se fortalecer de maneira significativa. O signo de Touro possui uma conexão muito forte com segurança, conforto e construção de resultados duradouros. Hoje será importante confiar mais no seu ritmo e não se comparar com outras pessoas. Cada conquista que você alcança vem através da persistência e da paciência, qualidades extremamente valiosas. Continue acreditando nos seus projetos e mantenha o foco no que realmente importa. Pequenos avanços feitos agora poderão gerar grandes resultados no futuro.",
      "Sua determinação será uma das maiores armas para enfrentar desafios e transformar situações complicadas em oportunidades de crescimento. Muitas vezes você carrega preocupações em silêncio, mas o universo está mostrando que chegou o momento de aliviar o peso emocional e confiar mais no processo da vida. Valorize suas qualidades, reconheça sua força interior e não permita que inseguranças limitem seus sonhos. Pessoas próximas poderão oferecer apoio importante nos próximos dias. Aproveite essa energia para organizar suas metas e fortalecer sua autoestima.",
      "Hoje será um excelente momento para cuidar mais da sua mente e do seu coração. O signo de Touro tende a acumular responsabilidades e esquecer da própria felicidade em alguns momentos, mas agora o universo quer lembrar que você também merece descanso, paz e reconhecimento. Sua capacidade de construir uma vida sólida é admirável, porém não tenha medo de sair da rotina quando necessário. Novas experiências poderão trazer inspiração e abrir caminhos inesperados. Confie no seu potencial e continue avançando com calma e inteligência.",
      "A energia deste período favorece crescimento pessoal e fortalecimento emocional. Você poderá perceber que algumas situações difíceis serviram apenas para torná-lo mais forte e preparado para novas oportunidades. Não tenha medo de mudar aquilo que já não faz sentido na sua vida. Seu signo possui uma força silenciosa que impressiona as pessoas ao redor, e muitas vezes você nem percebe o quanto é admirado. Continue trabalhando pelos seus objetivos e mantenha a confiança no futuro. O universo recompensa quem age com persistência e verdade.",
    ],
    "Gêmeos": [
      "Sua mente estará extremamente criativa e aberta para novas possibilidades. O signo de Gêmeos possui uma capacidade única de se adaptar às mudanças e enxergar oportunidades onde outras pessoas enxergam problemas. Hoje será importante usar essa inteligência de forma positiva e evitar distrações desnecessárias. Conversas importantes poderão trazer novas ideias e caminhos interessantes para sua vida. Permita-se aprender algo novo e explorar experiências diferentes. Seu potencial cresce ainda mais quando você acredita na própria capacidade de comunicação.",
      "Você está entrando em uma fase em que suas palavras terão grande impacto sobre as pessoas ao seu redor. Aproveite essa energia para fortalecer relações, criar conexões positivas e expressar sentimentos que estavam guardados há muito tempo. O universo está incentivando você a confiar mais em sua autenticidade e não esconder sua verdadeira personalidade. Sua leveza e criatividade podem transformar ambientes e inspirar pessoas. Continue cultivando pensamentos positivos e use sua inteligência para construir algo significativo.",
      "Hoje será um ótimo dia para organizar ideias e colocar projetos em prática. Muitas vezes você inicia várias coisas ao mesmo tempo, mas o momento pede mais foco e direcionamento. Quando você concentra sua energia em um objetivo específico, consegue alcançar resultados impressionantes. Não tenha medo de mostrar seus talentos e compartilhar suas ideias com o mundo. Pessoas importantes poderão reconhecer seu esforço e abrir portas inesperadas. Continue acreditando na sua criatividade e mantenha a mente aberta para novas oportunidades.",
      "A energia deste período favorece crescimento intelectual e renovação emocional. Você poderá sentir vontade de mudar hábitos, conhecer pessoas diferentes e explorar novos caminhos. O universo está mostrando que sua curiosidade pode ser uma grande aliada na construção do seu futuro. Não se limite por medo de errar ou pela opinião de outras pessoas. Seu signo nasceu para evoluir constantemente e descobrir novas formas de enxergar a vida. Aproveite este momento para fortalecer sua confiança e buscar experiências que tragam felicidade verdadeira.",
    ],
    "Câncer": [
      "Sua sensibilidade estará mais forte e isso permitirá que você perceba detalhes importantes ao seu redor. O signo de Câncer possui uma conexão profunda com emoções e sentimentos, e hoje será essencial cuidar da sua energia emocional. Não carregue problemas sozinho e permita-se conversar com pessoas de confiança. O universo está enviando sinais de renovação e acolhimento para sua vida. Aproveite este momento para fortalecer laços familiares, cuidar de si mesmo e valorizar tudo aquilo que traz paz para o seu coração.",
      "Hoje será um excelente dia para ouvir sua intuição e confiar mais nas mensagens que sua mente e seu coração estão tentando transmitir. Muitas vezes você sente demais e acaba absorvendo energias negativas sem perceber, mas agora chegou o momento de proteger sua paz interior. Sua capacidade de demonstrar carinho e empatia é admirável e pode transformar a vida das pessoas ao seu redor. Continue acreditando no amor, na amizade e nas conexões verdadeiras. O universo recompensará sua dedicação emocional.",
      "Você poderá perceber mudanças importantes acontecendo lentamente em sua vida emocional. Algumas situações do passado já não precisam ocupar espaço dentro da sua mente. O signo de Câncer possui uma força emocional muito maior do que imagina, e exatamente por isso consegue superar momentos difíceis com sensibilidade e maturidade. Hoje será importante olhar mais para o presente e valorizar as pequenas alegrias do cotidiano. Confie na sua capacidade de reconstruir sonhos e criar um futuro mais leve.",
      "A energia deste período favorece equilíbrio emocional e fortalecimento interior. Você poderá sentir necessidade de desacelerar e cuidar mais da própria felicidade. Não existe problema em colocar seus sentimentos como prioridade em alguns momentos. Pessoas próximas poderão demonstrar apoio e carinho de maneira inesperada. Aproveite essa fase para fortalecer sua autoestima e lembrar que sua sensibilidade não é fraqueza, mas sim uma das maiores qualidades do seu signo. Continue seguindo com amor e confiança.",
    ],
    "Leão": [
      "Seu brilho natural estará ainda mais evidente e as pessoas ao seu redor poderão perceber sua presença de forma marcante. O signo de Leão possui uma energia poderosa de liderança, coragem e inspiração, e hoje será importante usar essas qualidades de maneira positiva. Confie mais no seu potencial e não tenha medo de ocupar espaços importantes. O universo está mostrando que você pode conquistar objetivos grandes quando age com determinação e generosidade. Continue acreditando em si mesmo e espalhando sua energia positiva.",
      "Hoje será um ótimo momento para fortalecer sua autoestima e reconhecer tudo aquilo que você já conquistou até aqui. Muitas vezes você se cobra demais e esquece de valorizar a própria caminhada. O universo quer lembrar que sua luz pode inspirar pessoas e transformar ambientes. Aproveite este período para investir em sonhos pessoais, desenvolver novos projetos e cuidar mais da sua felicidade. Sua coragem será essencial para abrir caminhos importantes no futuro.",
      "Você poderá sentir uma forte vontade de mudar situações que já não fazem sentido na sua vida. Essa energia de renovação será extremamente positiva se for usada com sabedoria e equilíbrio. O signo de Leão nasceu para crescer, liderar e motivar pessoas, mas também precisa aprender a descansar e ouvir o próprio coração. Não permita que orgulho ou medo atrapalhem oportunidades valiosas. Continue caminhando com confiança e mantenha o foco naquilo que realmente traz realização.",
      "A energia deste momento favorece reconhecimento e crescimento pessoal. Pessoas importantes poderão notar seu esforço e admirar sua dedicação. Aproveite este período para fortalecer sua confiança interior e mostrar ao mundo seus talentos. Sua criatividade estará em alta e poderá trazer excelentes ideias para projetos futuros. O universo está preparando oportunidades especiais para você, principalmente se continuar agindo com coragem e autenticidade. Nunca duvide da sua capacidade de conquistar grandes resultados.",
    ],
    "Virgem": [
      "Sua capacidade de organização será extremamente importante para colocar sua vida em ordem e construir resultados sólidos. O signo de Virgem possui uma inteligência prática admirável e consegue enxergar detalhes que passam despercebidos por muitas pessoas. Hoje será um ótimo momento para cuidar da rotina, organizar planos e eliminar tudo aquilo que está causando desgaste emocional. Não se cobre tanto por perfeição, porque seu valor vai muito além de pequenos erros. O universo está mostrando que disciplina e equilíbrio podem abrir portas importantes para o seu crescimento.",
      "Você poderá sentir necessidade de desacelerar um pouco e olhar com mais carinho para si mesmo. Muitas vezes o signo de Virgem assume responsabilidades demais e acaba esquecendo da própria felicidade. Hoje será essencial encontrar tempo para descansar a mente e fortalecer sua energia emocional. Pequenas mudanças poderão trazer grandes resultados no futuro. Continue acreditando no seu potencial e valorize sua dedicação diária. Sua inteligência e capacidade de análise serão fundamentais para superar qualquer dificuldade.",
      "O universo está enviando sinais de renovação e crescimento pessoal para sua vida. Este será um período importante para abandonar hábitos negativos e fortalecer tudo aquilo que faz bem para sua mente e para seu coração. Sua determinação é admirável e pode levar você muito mais longe do que imagina. Não tenha medo de sair da zona de conforto quando perceber que algo já não contribui para sua evolução. Continue seguindo com paciência e confiança no futuro.",
      "Hoje será um excelente dia para focar nos seus objetivos e acreditar mais nas próprias capacidades. O signo de Virgem possui uma força silenciosa que muitas vezes impressiona as pessoas ao redor. Sua dedicação aos detalhes e sua vontade de fazer tudo da melhor maneira possível serão recompensadas em breve. Evite críticas excessivas contra si mesmo e reconheça suas conquistas. O universo está preparando oportunidades importantes para quem continua caminhando com responsabilidade e verdade.",
    ],
    "Libra": [
      "Sua busca por equilíbrio será essencial para lidar com situações importantes nos próximos dias. O signo de Libra possui uma energia harmoniosa e uma capacidade incrível de enxergar diferentes pontos de vista. Hoje será importante confiar mais na sua intuição e evitar carregar problemas que não pertencem a você. O universo está incentivando você a cuidar mais da própria paz emocional e valorizar relações verdadeiras. Continue acreditando na força do diálogo e da gentileza, porque essas qualidades poderão abrir caminhos especiais.",
      "Você poderá perceber mudanças positivas acontecendo em sua vida emocional e social. Muitas vezes você tenta agradar todo mundo e acaba esquecendo das próprias necessidades. Hoje será um ótimo momento para lembrar que seu bem-estar também merece prioridade. O signo de Libra possui charme, inteligência e uma grande capacidade de criar conexões profundas com as pessoas. Aproveite esta energia para fortalecer amizades, desenvolver novos projetos e buscar ambientes que tragam felicidade verdadeira.",
      "A energia deste período favorece crescimento interior e fortalecimento da autoestima. Você poderá sentir vontade de transformar situações que estavam causando desequilíbrio em sua vida. Não tenha medo de tomar decisões importantes quando perceber que elas serão positivas para o seu futuro. Sua capacidade de manter a calma mesmo em momentos difíceis será uma grande vantagem. Continue acreditando na sua sensibilidade e use sua inteligência emocional para construir relações mais saudáveis.",
      "Hoje será um excelente dia para investir em sonhos pessoais e buscar mais harmonia na rotina. O universo está mostrando que você possui talentos importantes e merece ocupar espaços maiores na vida. Sua leveza e sua capacidade de compreender as pessoas podem transformar ambientes e inspirar quem está ao seu redor. Evite pensamentos negativos e confie mais no processo da vida. Grandes oportunidades surgem quando você aprende a equilibrar razão e emoção.",
    ],
    "Escorpião": [
      "Sua intensidade emocional será uma grande fonte de força e transformação nos próximos dias. O signo de Escorpião possui uma capacidade única de superar desafios e renascer ainda mais forte após momentos difíceis. Hoje será importante confiar mais na sua intuição e não permitir que inseguranças antigas limitem seu crescimento. O universo está enviando sinais de renovação e oportunidades para quem estiver disposto a mudar de verdade. Continue acreditando no seu potencial e use sua energia de maneira positiva.",
      "Você poderá sentir necessidade de se afastar de situações negativas e buscar ambientes que tragam mais paz para sua mente. Muitas vezes o signo de Escorpião guarda sentimentos profundos e acaba carregando emoções em silêncio. Hoje será um ótimo momento para liberar pesos emocionais e olhar para o futuro com mais leveza. Sua coragem interior é admirável e pode ajudar você a transformar completamente sua realidade. Confie mais no processo da vida e siga em frente sem medo.",
      "A energia deste período favorece mudanças importantes e crescimento pessoal. Você poderá perceber que algumas experiências difíceis serviram apenas para fortalecer sua maturidade emocional. O universo quer lembrar que você possui uma força interior muito maior do que imagina. Não tenha medo de encerrar ciclos que já não fazem sentido. Novas oportunidades poderão surgir quando você decidir abrir espaço para aquilo que realmente merece permanecer na sua vida.",
      "Hoje será um excelente dia para fortalecer sua confiança e acreditar mais na própria capacidade de vencer desafios. O signo de Escorpião possui magnetismo, inteligência emocional e uma intensidade que impressiona as pessoas ao redor. Use essas qualidades de maneira equilibrada e evite conflitos desnecessários. Pessoas importantes poderão reconhecer sua dedicação e oferecer apoio em momentos inesperados. Continue caminhando com coragem e mantenha o foco em tudo aquilo que traz crescimento verdadeiro.",
    ],
    "Sagitário": [
      "Sua vontade de explorar novos caminhos estará ainda mais forte e isso poderá trazer oportunidades surpreendentes para sua vida. O signo de Sagitário possui uma energia aventureira, otimista e cheia de esperança. Hoje será importante acreditar mais nos seus sonhos e não permitir que o medo limite seus passos. O universo está incentivando você a sair da rotina, aprender coisas novas e confiar mais no próprio potencial. Grandes experiências podem surgir quando você se permite viver com autenticidade.",
      "Hoje será um ótimo momento para fortalecer sua autoestima e investir em projetos que tragam felicidade verdadeira. Muitas vezes você sente vontade de fazer muitas coisas ao mesmo tempo, mas agora será importante manter mais foco e direcionamento. O universo está mostrando que grandes resultados podem surgir quando você une entusiasmo com disciplina. Continue caminhando com coragem e não tenha medo de buscar caminhos diferentes.",
      "A energia deste período favorece crescimento, liberdade emocional e expansão pessoal. Você poderá perceber oportunidades aparecendo de maneira inesperada em áreas importantes da sua vida. Aproveite este momento para acreditar mais em si mesmo e abandonar pensamentos negativos que atrasam seu progresso. Seu espírito livre e sua capacidade de enxergar o lado positivo das situações serão fundamentais para abrir novas portas. Continue confiando na vida e seguindo em frente com esperança.",
      "Você poderá sentir necessidade de mudar hábitos, conhecer pessoas diferentes e buscar novos objetivos para o futuro. Essa energia de renovação será extremamente positiva para o seu crescimento pessoal. O signo de Sagitário nasceu para evoluir constantemente e encontrar significado nas experiências da vida. Continue cultivando pensamentos positivos e não perca sua essência alegre e espontânea. Sua confiança poderá inspirar pessoas ao seu redor.",
    ],
    "Capricórnio": [
      "Sua determinação será essencial para conquistar objetivos importantes e construir um futuro mais sólido. O signo de Capricórnio possui uma força admirável e uma capacidade incrível de persistir mesmo diante das dificuldades. Hoje será um excelente momento para organizar metas e acreditar mais no próprio potencial. O universo está mostrando que todo esforço feito com dedicação será recompensado no tempo certo. Continue caminhando com responsabilidade e não desista dos seus sonhos.",
      "Você poderá perceber que algumas situações difíceis serviram apenas para fortalecer sua maturidade e sua confiança interior. Muitas vezes o signo de Capricórnio assume responsabilidades excessivas e acaba esquecendo de cuidar da própria felicidade. Hoje será importante encontrar equilíbrio entre trabalho, descanso e vida emocional. Pequenos momentos de paz poderão renovar completamente sua energia e trazer novas ideias para o futuro.",
      "A energia deste período favorece crescimento profissional e fortalecimento emocional. Pessoas importantes poderão reconhecer seu esforço e valorizar sua dedicação. Aproveite esta fase para investir em projetos pessoais e acreditar mais na sua capacidade de liderança. O universo está preparando oportunidades especiais para quem continua trabalhando com disciplina e verdade. Não permita que inseguranças diminuam sua motivação.",
      "Hoje será um ótimo dia para refletir sobre tudo aquilo que você deseja construir para sua vida. O signo de Capricórnio possui uma visão forte de futuro e uma habilidade admirável para transformar sonhos em realidade. Continue mantendo o foco nos seus objetivos e não se distraia com críticas negativas. Sua persistência será uma das maiores armas para superar desafios e alcançar estabilidade em diversas áreas da vida.",
    ],
    "Aquário": [
      "Sua criatividade estará extremamente forte e poderá abrir caminhos inesperados para seu crescimento pessoal. O signo de Aquário possui uma mente inovadora e uma capacidade incrível de enxergar soluções diferentes para os problemas da vida. Hoje será importante confiar mais nas suas ideias e não ter medo de mostrar sua verdadeira personalidade. O universo está incentivando você a explorar novos projetos e acreditar no seu potencial de transformação.",
      "Você poderá sentir vontade de mudar hábitos, renovar ambientes e buscar experiências que tragam mais liberdade para sua vida. Essa energia será extremamente positiva para o seu desenvolvimento emocional e intelectual. O signo de Aquário nasceu para inovar e criar novas possibilidades, por isso não permita que opiniões negativas diminuam sua confiança. Continue seguindo sua intuição e mantenha a mente aberta para novas oportunidades.",
      "Hoje será um excelente momento para fortalecer amizades e criar conexões verdadeiras com pessoas que compartilham dos mesmos sonhos e objetivos. Sua autenticidade é uma das maiores qualidades do seu signo e pode inspirar muitas pessoas ao seu redor. O universo está mostrando que sua criatividade poderá gerar resultados importantes no futuro. Não tenha medo de pensar diferente e seguir caminhos únicos.",
      "A energia deste período favorece crescimento pessoal, inovação e renovação emocional. Você poderá perceber novas ideias surgindo de maneira natural e trazendo motivação para mudar sua rotina. Aproveite este momento para acreditar mais em si mesmo e investir em tudo aquilo que desperta entusiasmo no seu coração. Seu espírito livre e sua visão diferenciada serão fundamentais para abrir portas importantes.",
    ],
    "Peixes": [
      "Sua sensibilidade estará ainda mais forte e permitirá que você perceba detalhes importantes ao seu redor. O signo de Peixes possui uma conexão profunda com emoções, sonhos e espiritualidade, e hoje será essencial confiar mais na sua intuição. O universo está enviando sinais positivos para quem estiver disposto a ouvir o próprio coração. Continue acreditando nos seus sentimentos e não permita que energias negativas diminuam sua esperança.",
      "Você poderá sentir necessidade de desacelerar e cuidar mais da sua paz interior. Muitas vezes o signo de Peixes absorve emoções de outras pessoas sem perceber, o que pode gerar desgaste emocional. Hoje será um ótimo momento para fortalecer sua energia espiritual e valorizar ambientes que tragam tranquilidade. Sua capacidade de demonstrar carinho e empatia é admirável e pode transformar vidas.",
      "A energia deste período favorece crescimento emocional e renovação interior. Você poderá perceber mudanças importantes acontecendo lentamente em áreas que antes pareciam completamente paradas. O universo quer lembrar que sua sensibilidade é uma grande força e não uma fraqueza. Continue acreditando nos seus sonhos e mantenha a esperança mesmo diante das dificuldades.",
      "Hoje será um excelente dia para fortalecer sua autoestima e confiar mais no processo da vida. O signo de Peixes possui imaginação, criatividade e uma conexão emocional muito especial com o mundo ao redor. Use essas qualidades de maneira positiva e não tenha medo de demonstrar sua verdadeira essência. Grandes oportunidades podem surgir quando você aprende a acreditar mais em si mesmo e seguir o caminho do coração.",
    ],
  };

  final Map<String, String> imagens = {
    "Áries": "assets/signos/aries.webp",
    "Touro": "assets/signos/touro.webp",
    "Gêmeos": "assets/signos/gemeos.webp",
    "Câncer": "assets/signos/cancer.webp",
    "Leão": "assets/signos/leao.webp",
    "Virgem": "assets/signos/virgem.webp",
    "Libra": "assets/signos/libra.webp",
    "Escorpião": "assets/signos/escorpiao.webp",
    "Sagitário": "assets/signos/sagitario.webp",
    "Capricórnio": "assets/signos/capricornio.webp",
    "Aquário": "assets/signos/aquario.webp",
    "Peixes": "assets/signos/peixes.webp",
  };

  @override
  Widget build(BuildContext context) {
    final lista = frases[signo] ?? ["Hoje será especial."];
    final agora = DateTime.now();

    final indice = (agora.day + agora.hour + signo.length) % lista.length;

    final frase = lista[indice];

    final img = imagens[signo]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(signo),
        actions: [
          SizedBox(height: 30),

          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              Share.share(
                "🔮 Horóscopo de hoje para $signo:\n\n$frase\n\nBaixe o app e veja o seu também!",
              );
            },
            icon: Icon(Icons.share),
            label: Text("Compartilhar"),
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
              color: Colors.black.withOpacity(0.75),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.deepPurple.withOpacity(0.5),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 5,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Olá, $nome",
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),

                  SizedBox(height: 10),

                  Text(
                    signo,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(blurRadius: 12, color: Colors.deepPurple),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  Text(
                    frase,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      height: 1.5,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.black,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
