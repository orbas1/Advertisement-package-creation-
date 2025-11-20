import 'package:equatable/equatable.dart';

class Metric extends Equatable {
  const Metric({
    required this.campaignId,
    required this.impressions,
    required this.clicks,
    required this.conversions,
    required this.spend,
    required this.ctr,
    required this.cpc,
    required this.cpa,
    required this.cpm,
    required this.rangeStart,
    required this.rangeEnd,
  });

  factory Metric.fromJson(Map<String, dynamic> json) {
    return Metric(
      campaignId: json['campaign_id'] as int,
      impressions: json['impressions'] as int,
      clicks: json['clicks'] as int,
      conversions: json['conversions'] as int,
      spend: (json['spend'] as num).toDouble(),
      ctr: (json['ctr'] as num).toDouble(),
      cpc: (json['cpc'] as num).toDouble(),
      cpa: (json['cpa'] as num).toDouble(),
      cpm: (json['cpm'] as num).toDouble(),
      rangeStart: DateTime.parse(json['range_start'] as String),
      rangeEnd: DateTime.parse(json['range_end'] as String),
    );
  }

  final int campaignId;
  final int impressions;
  final int clicks;
  final int conversions;
  final double spend;
  final double ctr;
  final double cpc;
  final double cpa;
  final double cpm;
  final DateTime rangeStart;
  final DateTime rangeEnd;

  Map<String, dynamic> toJson() => {
        'campaign_id': campaignId,
        'impressions': impressions,
        'clicks': clicks,
        'conversions': conversions,
        'spend': spend,
        'ctr': ctr,
        'cpc': cpc,
        'cpa': cpa,
        'cpm': cpm,
        'range_start': rangeStart.toIso8601String(),
        'range_end': rangeEnd.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        campaignId,
        impressions,
        clicks,
        conversions,
        spend,
        ctr,
        cpc,
        cpa,
        cpm,
        rangeStart,
        rangeEnd,
      ];
}
