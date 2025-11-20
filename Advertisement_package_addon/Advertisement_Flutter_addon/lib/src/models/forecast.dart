import 'package:equatable/equatable.dart';

class Forecast extends Equatable {
  const Forecast({
    required this.campaignId,
    required this.estimatedImpressions,
    required this.estimatedClicks,
    required this.estimatedConversions,
    required this.estimatedSpend,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      campaignId: json['campaign_id'] as int,
      estimatedImpressions: json['estimated_impressions'] as int,
      estimatedClicks: json['estimated_clicks'] as int,
      estimatedConversions: json['estimated_conversions'] as int,
      estimatedSpend: (json['estimated_spend'] as num).toDouble(),
    );
  }

  final int campaignId;
  final int estimatedImpressions;
  final int estimatedClicks;
  final int estimatedConversions;
  final double estimatedSpend;

  Map<String, dynamic> toJson() => {
        'campaign_id': campaignId,
        'estimated_impressions': estimatedImpressions,
        'estimated_clicks': estimatedClicks,
        'estimated_conversions': estimatedConversions,
        'estimated_spend': estimatedSpend,
      };

  @override
  List<Object?> get props => [
        campaignId,
        estimatedImpressions,
        estimatedClicks,
        estimatedConversions,
        estimatedSpend,
      ];
}
