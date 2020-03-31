import 'dart:async';
import 'dart:convert';

import 'package:event_sg/globals/urls.dart';
import 'package:event_sg/models/models.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;


class ReviewApiClient {

  static const baseUrl = '${Urls.apiUrlBase}/review';

  final http.Client httpClient;

  ReviewApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<int> addReview(Review review) async {
    final reviewUrl = '$baseUrl/add';
    try {
      final reviewResponse = await this.httpClient.post(reviewUrl, body: jsonEncode(review));
      if (reviewResponse.statusCode == 200)
        return 1;
      else{
        throw Exception('error adding review for event');
      }
    } catch (e) {
      print("caught error: $e");
      throw Exception('error adding review for event');
    }
  }

  Future<bool> hasReviewed(String eventId, String userId) async {
    final url = '$baseUrl/has_reviewed/$eventId/$userId';
    try {
      final response = await httpClient.get(url);
      // print( response.body);
      bool data = jsonDecode(response.body);

      if (data) {
        return true; // has added review
      } else {
        return false;
      }
    } catch (e) {
      print("Caught error: $e");
      throw Exception('error getting review whether added data!');
    }
  }

  Future<Review> getReviewById(String reviewId) async {
    final reviewUrl = '$baseUrl/$reviewId';

    try {
      final reviewResponse = await this.httpClient.get(reviewUrl);
      Map reviewData = jsonDecode(reviewResponse.body);
      print(reviewData);
      final review = Review.fromJson(reviewData);
      return review;
    } catch(e) {
      print("caught error $e");
      throw Exception('error getting review data');
    }
  }

  Future<List<Review>> getReviewsByEventId(String eventId) async {
    final reviewUrl = '$baseUrl/$eventId';
    try {
      final reviewResponse = await this.httpClient.get(reviewUrl);
      List reviewData = jsonDecode(reviewResponse.body);
      print(reviewData);
      List<Review> reviews = reviewData.map((value) =>  Review.fromJson(value)).toList();
      return reviews;
    } catch(e) {
      print("caught error $e");
      throw Exception('error getting review data');
    }
  }
}