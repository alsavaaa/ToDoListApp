import 'package:flutter/material.dart';

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    String username = args['username'];

    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        backgroundColor: Color.fromARGB(255, 225, 182, 193),  // Pink color for the app bar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 146, 168, 211),  // Blue color
              Color.fromARGB(255, 225, 182, 193),  // Pink color
            ],
            begin: Alignment.topLeft,  // Starting point of the gradient
            end: Alignment.bottomRight,  // Ending point of the gradient
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Column(
                children: [
                  // Foto Profil
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 4),
                        ),
                      ],
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://i.pinimg.com/236x/8e/0c/fa/8e0cfaf58709f7e626973f0b00d033d0.jpg',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Nama User
                  Text(
                    username,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 225, 182, 193),  // Pink color for username
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your profile information',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey,  // Light blue for subheading
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // Detail Informasi
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              color: Color.fromARGB(255, 225, 182, 193),  // Pink card background
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileDetailItem(
                      icon: Icons.person,
                      label: 'Username',
                      value: username,
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

// Widget for profile detail items
class ProfileDetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  ProfileDetailItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Color.fromARGB(255, 146, 168, 211)),  // Serenity blue icon color
        SizedBox(width: 16),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.blueGrey,  // Light blue for the label
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 146, 168, 211),  // Serenity blue for value
          ),
        ),
      ],
    );
  }
}
