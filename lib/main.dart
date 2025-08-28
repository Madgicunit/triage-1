import 'package:flutter/material.dart';
import 'categories_page.dart';
import 'admin_page.dart';



void main() {
  runApp(RenaissanceApp());
}

  class RenaissanceApp extends StatelessWidget {
    const RenaissanceApp({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Centre de don',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/add': (context) => AddItemPage(),
        },
      );
    }
  }
  
  class HomePage extends StatelessWidget {
  const HomePage({super.key});

    Widget buildButton({
      required String label,
      required IconData icon,
      required Color color,
      required Color textColor,
      VoidCallback? onPressed, // Ajout du paramètre onPressed
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
        child: ElevatedButton.icon(
          onPressed: onPressed, // Utilisation du paramètre
          icon: Icon(icon, color: textColor),
          label: Text(label, style: TextStyle(color: textColor)),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
          ),
        ),
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 150,
            ),
            SizedBox(height: 20),
            Text(
              'Centre de don',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue[800],
                fontWeight: FontWeight.bold, // En gras
              ),
            ),
            SizedBox(height: 30),

            // Boutons
            buildButton(
              label: 'Trier un objet',
              icon: Icons.search,
              color: Colors.blue[700]!,
              textColor: Colors.amber[400]!,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
            ),
            buildButton(
              label: 'Voir les catégories',
              icon: Icons.list,
              color: Colors.amber[400]!,
              textColor: Colors.blue[700]!,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoriesPage()),
                );
              },
            ),
            buildButton(
              label: 'Ajouter un objet',
              icon: Icons.description,
              color: Colors.blue[700]!,
              textColor: Colors.amber[400]!,
              onPressed: () {
                Navigator.pushNamed(context, '/add');
              },
            ),
             buildButton(
            label: 'Directive Importante',
            icon: Icons.info_outline,
            color: Colors.amber[400]!,
            textColor: Colors.blue[700]!,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DirectivesPage()),
              );
            },
          ),
          buildButton(
            label: 'Admin.',
            icon: Icons.settings,
            color: Colors.amber[400]!,
            textColor: Colors.blue[700]!,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminPage()),
              );
            },
          ),
          ],
        ),
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';
  List<Category> results = [];

  void search(String value) {
    setState(() {
      query = value.trim().toLowerCase();
      results = [];
      // Correction : utilise la liste globale 'categories' importée
      for (final cat in categories) {
        if (cat.items.any((item) => item.toLowerCase().contains(query))) {
          results.add(cat);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recherche d\'objet')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Nom de l\'objet',
                border: OutlineInputBorder(),
              ),
              onChanged: search,
            ),
            SizedBox(height: 20),
            if (query.isNotEmpty)
              Expanded(
                child: results.isEmpty
                  ? Center(child: Text('Aucune catégorie trouvée pour "$query".'))
                  : ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (context, idx) {
                        final cat = results[idx];
                        return ListTile(
                          leading: Icon(cat.icon, color: Colors.blue[800]),
                          title: Text(cat.name),
                          subtitle: Text('Bac ${cat.binColor}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryDetailPage(category: cat),
                              ),
                            );
                          },
                        );
                      },
                    ),
              ),
          ],
        ),
      ),
    );
  }
}
class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  AddItemPageState createState() => AddItemPageState();
}

class AddItemPageState extends State<AddItemPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _categorieController = TextEditingController();
  bool _estApprouve = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Suggérer un article')),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 500, minWidth: 350),
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Proposez un nouvel article à ajouter et indiquez la catégorie correspondante. '
                      "Si un gérant l'a déjà approuvé, cochez la case ci-dessous.",
                      style: TextStyle(fontSize: 16, color: Colors.blue[800]),
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      controller: _nomController,
                      decoration: InputDecoration(
                        labelText: 'Nom de l’article',
                        prefixIcon: Icon(Icons.article),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ce champ est obligatoire';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _categorieController,
                      decoration: InputDecoration(
                        labelText: 'Catégorie proposée',
                        prefixIcon: Icon(Icons.category),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ce champ est obligatoire';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    SwitchListTile(
                      title: Text('Approuvé par le gérant'),
                      value: _estApprouve,
                      onChanged: (value) {
                        setState(() => _estApprouve = value);
                      },
                    ),
                    SizedBox(height: 24),
                    Center(
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.send),
                        label: Text('Suggérer'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final nom = _nomController.text;
                            final categorie = _categorieController.text;
                            final approuve = _estApprouve;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Suggestion envoyée : $nom ($categorie)'
                                  '${approuve ? ' [Approuvé]' : ''}',
                                ),
                              ),
                            );

                            _formKey.currentState!.reset();
                            _nomController.clear();
                            _categorieController.clear();
                            setState(() => _estApprouve = false);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class DirectivesPage extends StatelessWidget {
  const DirectivesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Directive Importante')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // ignore: prefer_single_quotes
                "Directive concernant tous les dons :\n"
                // ignore: prefer_single_quotes
                "Ne jamais séparer un ensemble d’objet, peu importe la catégorie choisie. Toujours mettre l’ensemble complet. "
                // ignore: prefer_single_quotes
                "Si vous devez séparer un ensemble dans plusieurs bacs, identifiez-les sur l’étiquette afin que les employés après vous puissent faire le lien. "
                // ignore: prefer_single_quotes
                "Exemple : un cinéma maison 7.1, vous avez trop de morceaux pour 1 seul bac et vous le séparez dans 3 bacs, sur l’étiquette inscrivez : ensemble 1/3 - 2/3 – 3/3. "
                // ignore: prefer_single_quotes
                "Vous pouvez aussi choisir de mettre l’ensemble complet dans le bac bleu de gros morceaux ou, si c’est de l’électronique, dans le bac noir électronique/électrique.",
                style: TextStyle(fontSize: 17, color: Colors.blue[800], fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 16),
              Text(
                // ignore: prefer_single_quotes
                "Directive concernant uniquement les bacs gris :\n"
                // ignore: prefer_single_quotes
                "Les bacs gris ne doivent pas excéder un poids de 30lb. Noter que le bac en lui-même pèse déjà 10lb.\n"
                // ignore: prefer_single_quotes
                "Tout objets en lot (lot de crayon, lot de balle de golf, lot de petit jouet etc.) et/ou étant plus petit qu’une balle de baseball (porte clé, bouton, article de papeterie n’étant plus dans l’emballage d’origine) dois être mis dans les sacs prévu à cet effet, les bijoux dois en tout temps être mis dans des sacs.",
                style: TextStyle(fontSize: 16, color: Colors.blue[800], fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 16),
              Text(
                // ignore: prefer_single_quotes
                "Directive concernant uniquement le bac noir :\n"
                // ignore: prefer_single_quotes
                "Pour tout les objets électronique et électrique trop gros pour les bacs gris, vérifier d’abord s’il n’entre pas dans un bac gris, si l’objet peut se démonter rapidement et facilement pour réduire son espace utiliser faite le!",
                style: TextStyle(fontSize: 16, color: Colors.blue[800], fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}