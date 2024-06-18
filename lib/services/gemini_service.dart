import 'package:http/http.dart' as http;
import 'dart:convert';

class GeminiService {
  static const String _geminiApiEndpoint = 'https://api.gemini.com/verify';
  static const String _geminiApiKey = 'AIzaSyAtgK2_D0YlGguXCdC8mlNsHPnex_gJ0_8'; // Remplacez par votre clé API Gemini

  static Future<String> checkProjectCompliance(Map<String, dynamic> projectData) async {
    try {
      final response = await http.post(
        Uri.parse(_geminiApiEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_geminiApiKey',
        },
        body: jsonEncode(projectData),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse['status']; // Supposons que la réponse de Gemini inclut un champ "status"
      } else {
        throw Exception('Erreur de la requête Gemini: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur lors de la vérification de la conformité du projet: $e');
    }
  }
}