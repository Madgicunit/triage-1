import 'package:flutter/material.dart';

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
                      // ignore: prefer_single_quotes
                      "Proposez un nouvel article à ajouter et indiquez la catégorie correspondante. "
                      "Si un gérant l'a déjà approuvé, cochez la case ci-dessous.",
                      style: TextStyle(fontSize: 16, color: Colors.blue[800]),
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      controller: _nomController,
                      decoration: InputDecoration(labelText: 'Nom de l’article'),
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
                      decoration: InputDecoration(labelText: 'Catégorie proposée'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ce champ est obligatoire';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Checkbox(
                          value: _estApprouve,
                          onChanged: (value) {
                            setState(() {
                              _estApprouve = value ?? false;
                            });
                          },
                        ),
                        Text('Approuvé par le gérant'),
                      ],
                    ),
                    SizedBox(height: 24),
                    Center(
                      child: ElevatedButton(
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
                        child: Text('Suggérer'),
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