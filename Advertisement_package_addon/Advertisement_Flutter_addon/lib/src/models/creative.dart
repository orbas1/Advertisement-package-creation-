import 'package:equatable/equatable.dart';

class Creative extends Equatable {
  const Creative({
    required this.id,
    required this.adGroupId,
    required this.type,
    required this.headline,
    required this.body,
    this.mediaUrl,
    this.callToAction,
  });

  factory Creative.fromJson(Map<String, dynamic> json) {
    return Creative(
      id: json['id'] as int,
      adGroupId: json['ad_group_id'] as int,
      type: json['type'] as String,
      headline: json['headline'] as String,
      body: json['body'] as String,
      mediaUrl: json['media_url'] as String?,
      callToAction: json['call_to_action'] as String?,
    );
  }

  final int id;
  final int adGroupId;
  final String type;
  final String headline;
  final String body;
  final String? mediaUrl;
  final String? callToAction;

  Map<String, dynamic> toJson() => {
        'id': id,
        'ad_group_id': adGroupId,
        'type': type,
        'headline': headline,
        'body': body,
        'media_url': mediaUrl,
        'call_to_action': callToAction,
      };

  @override
  List<Object?> get props => [id, adGroupId, type, headline, body, mediaUrl, callToAction];
}
