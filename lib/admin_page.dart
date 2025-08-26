import 'package:flutter/material.dart';

// Exemple de fonctions que tu peux ajouter dans une page admin :

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  void _showNotImplemented(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Fonction non disponible pour le moment')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Section Admin')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Ajouter une catégorie'),
            onTap: () => _showNotImplemented(context),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Modifier une catégorie'),
            onTap: () => _showNotImplemented(context),
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Supprimer une catégorie'),
            onTap: () => _showNotImplemented(context),
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Voir toutes les suggestions d’articles'),
            onTap: () => _showNotImplemented(context),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Paramètres avancés'),
            onTap: () => _showNotImplemented(context),
          ),
        ],
      ),
    );
  }
}