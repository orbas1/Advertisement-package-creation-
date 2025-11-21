import '../api/advertisement_api_client.dart';
import '../models/models.dart';

class AdsService {
  AdsService(this.client);

  final AdvertisementApiClient client;

  Future<List<Campaign>> fetchCampaigns() => client.fetchCampaigns();

  Future<Campaign> createCampaign(Map<String, dynamic> payload) =>
      client.createCampaign(payload);

  Future<Campaign> updateCampaign(int id, Map<String, dynamic> payload) =>
      client.updateCampaign(id, payload);

  Future<List<Creative>> fetchCreatives(int adGroupId) =>
      client.fetchCreatives(adGroupId);

  Future<Creative> createCreative(Map<String, dynamic> payload) =>
      client.createCreative(payload);

  Future<Creative> updateCreative(int id, Map<String, dynamic> payload) =>
      client.updateCreative(id, payload);

  Future<Forecast> fetchForecast(Map<String, dynamic> payload) =>
      client.createForecast(payload);

  Future<List<KeywordPrice>> keywordIdeas(String query) =>
      client.keywordPrices(query);

  Future<List<Metric>> fetchMetrics({
    required int campaignId,
    required DateTime start,
    required DateTime end,
  }) =>
      client.fetchMetrics(campaignId: campaignId, start: start, end: end);
}
