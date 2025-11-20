import 'package:flutter/material.dart';

import 'views/views.dart';

class AdsMenuItem {
  const AdsMenuItem({required this.title, required this.icon, required this.builder});

  final String title;
  final IconData icon;
  final WidgetBuilder builder;
}

const defaultAdsMenu = <AdsMenuItem>[
  AdsMenuItem(title: 'Ads Dashboard', icon: Icons.dashboard, builder: AdsDashboardPage.builder),
  AdsMenuItem(title: 'Campaigns', icon: Icons.campaign, builder: CampaignListPage.builder),
  AdsMenuItem(title: 'Creatives', icon: Icons.movie, builder: CreativeEditorPage.builder),
  AdsMenuItem(title: 'Analytics', icon: Icons.show_chart, builder: AnalyticsPage.builder),
  AdsMenuItem(title: 'Forecast', icon: Icons.trending_up, builder: ForecastPage.builder),
  AdsMenuItem(title: 'Keyword Planner', icon: Icons.search, builder: KeywordPlannerPage.builder),
  AdsMenuItem(title: 'Affiliates', icon: Icons.group, builder: AffiliateDashboardPage.builder),
];
