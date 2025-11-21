# Advertisement Package Functions

## Overview
The package delivers a complete ads management layer that combines a Laravel backend (`advertisement_laravel_package`) with a Flutter addon (`advertisement_flutter_addon`). Advertisers can launch and manage campaigns, creatives, targeting, budgets, forecasts, and analytics that surface across feed, profile, search, and vertical placements (jobs, gigs, webinars, podcasts, networking). The addon plugs into a LinkedIn-style host app to show dashboards, editing flows, and reporting driven directly by the Laravel API.

## Architecture & Modules
- **Laravel**
  - **Controllers:** Campaign, Creative, Advertiser, Targeting, Report, Keyword Planner, Affiliate, Forecast endpoints.
  - **Models:** Advertiser, Campaign, Creative, AdGroup, Placement, TargetingRule, Metric, Forecast, KeywordPrice, AffiliateReferral, AffiliatePayout.
  - **Services:** ForecastingService (reach/click/conversion estimation), KeywordPlannerService (keyword pricing), AffiliateService (referrals/payouts).
  - **Policies:** CampaignPolicy for update/view authorization hooks.
- **Flutter**
  - **API Client:** `advertisement_api_client.dart` with authenticated REST calls.
  - **Repository/Services:** Wrap API for campaigns, creatives, metrics, forecasts, keyword planner, affiliates.
  - **State:** Cubits/Blocs for campaigns, creatives, analytics, forecasts, keyword planner, affiliate data.
  - **Views/Pages:** Dashboards, campaign list/detail, creatives, keyword planner, forecast, analytics, affiliate dashboards.

**Core Flow Outline**
- Campaign list → detail → manage creatives/targeting/budget → monitor analytics.
- Keyword planner → add priced keywords → targeting/budget tuning.
- Forecast simulation → stores per-campaign forecasts.
- Affiliate referrals/payout tracking.

## Functions & Features (Laravel)
- **Campaigns**
  - `GET /api/advertisement/campaigns` → paginated campaigns with advertiser, creatives, metrics, targeting, forecasts.
  - `GET /api/advertisement/campaigns/{campaign}` → detailed campaign payload.
  - `POST /api/advertisement/campaigns` / `PUT /api/advertisement/campaigns/{campaign}` → validate and persist campaigns (budget, bidding, placement, schedule, status).
  - `POST /api/advertisement/campaigns/{campaign}/forecast` → generate reach/click/conversion forecasts via `ForecastingService`.
- **Creatives**
  - `GET /api/advertisement/creatives?campaign_id={id}&ad_group_id={id}` → paginated creatives filtered to campaign/ad group.
  - `POST /api/advertisement/creatives` / `PUT /api/advertisement/creatives/{creative}` → manage creative assets (headline/body/CTA/media/destination URL/status).
- **Targeting**
  - `POST /api/advertisement/campaigns/{campaign}/targeting` → replace targeting rule set (type/value/operator array) per campaign.
- **Reports/Metrics**
  - `GET /api/advertisement/campaigns/{campaign}/reports?from=&to=` → time-series metrics (impressions, clicks, conversions, spend) with summary totals.
  - `POST /api/advertisement/campaigns/{campaign}/reports` → append metrics for analytics/attribution ingestion.
- **Advertisers**
  - `GET/POST/PUT /api/advertisement/advertisers` → advertiser CRUD (billing email, spend limits, status, balances).
- **Keyword Planner**
  - `POST /api/advertisement/keyword-planner` with `keywords[]` → returns priced keyword records (CPC/CPA/CPM) for planner/search alignment.
- **Affiliates**
  - `GET /api/advertisement/affiliates/referrals` with optional `referrer_id` → referral list.
  - `POST /api/advertisement/affiliates/referrals` → register referral (campaign-aware, commission applied).
  - `GET /api/advertisement/affiliates/payouts` / `POST /api/advertisement/affiliates/payouts` → payout queue/request handling.

## Functions & Features (Flutter)
- **Screens/Pages**
  - `lib/src/pages/ads_home_screen.dart` – entry dashboard summarizing campaign budgets/objectives.
  - `lib/src/pages/campaign_list_screen.dart` – lists campaigns, search/filter via `CampaignListCubit`.
  - `lib/src/pages/campaign_detail_screen.dart` – campaign header, budget, timeline, creative list, metrics hooks.
  - `lib/src/pages/campaign_wizard_screen.dart` & `lib/src/views/campaign_list_page.dart` – create/edit campaign fields (name/objective/budget/dates).
  - `lib/src/pages/creative_list_screen.dart` / `lib/src/pages/creative_edit_screen.dart` – creative CRUD via `CreativeBloc`.
  - `lib/src/pages/keyword_planner_screen.dart` / `lib/src/views/keyword_planner_page.dart` – keyword pricing search using `KeywordPlannerBloc/Cubit`.
  - `lib/src/pages/forecast_screen.dart` / `lib/src/views/forecast_page.dart` – forecast sliders and results via `ForecastBloc` and `ForecastCubit`.
  - `lib/src/pages/ads_reports_screen.dart` / `lib/src/views/analytics_page.dart` – metrics display through `AnalyticsBloc`.
  - `lib/src/pages/ads_home_screen.dart` – navigation entry from `lib/src/menu.dart`.
  - `lib/src/views/affiliate_dashboard_page.dart` – referral/payout overview driven by `AffiliateBloc`.
- **Services/State**
  - API client handles auth headers, JSON parsing into typed models (`Campaign`, `Creative`, `Metric`, `Forecast`, `KeywordPrice`, `AffiliateReferral`, `AffiliatePayout`).
  - Cubits/Blocs manage loading/error/empty states with refresh after create/update actions.

## Integration Guide – Feed & Search
- **Feed/Placement Helpers**
  - Use backend `Creative` + `Campaign` payloads to render feed/profile/search/job/webinar/podcast/networking ads. Components in `resources/views/vendor/advertisement/components/*.blade.php` offer templates for feed cards, search results, and banners.
  - Query campaigns/creatives for placement-specific rendering and respect status/approval before injecting into host feed.
- **Search Integration**
  - Keyword planner uses same keyword catalog as global search via `KeywordPrice` records. Call `POST /api/advertisement/keyword-planner` with user-entered queries, then index `keyword` + pricing fields into your search engine (Scout/Meilisearch/Elastic) for consistent keyword pricing and autocomplete.

## Integration Guide – Analytics
- **Events Fired**
  - `advertiser_account_created`, `campaign_created`, `campaign_paused`, `campaign_ended`, `ad_created`, `ad_approved`, `ad_rejected`, `impression_logged`, `click_logged`, `conversion_logged`, `forecast_requested` can be dispatched where business actions occur (campaign/creative CRUD, metric ingestion, forecast calls).
- **Backend Hooks**
  - Dispatch events when creating/updating campaigns/creatives or storing metrics/forecasts; wire listeners to existing analytics/BI bus.
- **Flutter Hooks**
  - Inject an analytics provider into blocs or wrap navigation/button taps to emit events (screen opens, forecast requested, creative saved). Repository/service calls already centralize API interactions for easy instrumentation.

## Security, Reliability & Performance Notes
- **Validation**: Laravel Form Requests guard advertiser/campaign/creative payloads; targeting/report routes validate arrays and numeric ranges.
- **Authorization**: Campaign update/forecast actions honor `CampaignPolicy`/`Gate` checks; protect routes with `auth` middleware in host app.
- **Data Safety**: Campaign model exposes derived `name`, `daily_budget`, `lifetime_budget` for UI parity without leaking raw internals; creatives filtered by campaign/ad group in index route.
- **Pagination**: All list endpoints (campaigns, creatives, referrals, payouts) return paginated data to avoid heavy payloads.
- **Performance**: Campaign queries eager-load advertiser/creatives/metrics/targeting/forecasts to reduce N+1 access; keyword planner caches pricing rows via first-or-create semantics.
- **Budget Guardrails**: Validation enforces minimum budgets; forecast uses budget and schedule to derive per-day spend so projections stay bounded.

## Configuration & Environment
- Key config values live in `config/advertisement.php` (minimum budgets, placements, affiliate settings).
- Ensure `.env` includes database credentials and any auth middleware keys required by the host app.
- Run migrations to create ads tables (advertisers, campaigns, ad_groups, creatives, placements, targeting_rules, metrics, forecasts, keyword_prices, affiliate_referrals, affiliate_payouts).
- Queue/cron: schedule metric ingestion/importers as needed; configure storage for media paths if creatives upload assets.

## Quick Start – Integration Steps
1. Add the Laravel package to the host app, publish config, and register the service provider if not auto-discovered.
2. Run `php artisan migrate` to create advertisement tables.
3. Mount routes (`routes/api.php` already prefixed under `/api/advertisement`; secure with `auth:api`/throttle` in host app).
4. Add Blade component includes for feed/search/banner placements where ads should render.
5. Expose menu items linking to advertiser dashboard and campaign wizard screens.
6. For Flutter:
   - Add the addon as a dependency and initialize `AdvertisementApiClient` with base URL + token provider.
   - Register routes/pages from `lib/src/menu.dart` in the host app’s navigation.
   - Wire an analytics provider to blocs/cubits for event capture.
7. Verify keyword planner and forecast flows by hitting their respective screens; ensure metrics ingestion job provides data for analytics.

