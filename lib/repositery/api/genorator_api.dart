import 'dart:convert';

import 'package:http/http.dart';
import 'package:image_generator/repositery/api/api_client.dart';
import 'package:image_generator/repositery/model/genorater_model.dart';

class GenoratorApi {
  ApiClient apiClient = ApiClient();

  Future<Generatormodel> getGenerator() async {
    String trendingPath = 'https://ai-image-generator14.p.rapidapi.com/';

    // Correct JSON body format
    Map<String, dynamic> body = {
      "function_name": "image_generator",
      "type": "image_generation",
      "query": "A Cat Eating Noodles With Chop Sticks.",
      "output_type": "png"
    };

    // Invoke API correctly
    Response response = await apiClient.invokeAPI(
      trendingPath,
      'POST',
      body, // Pass the body as a map
    );

    return Generatormodel.fromJson(jsonDecode(response.body));
  }
}
