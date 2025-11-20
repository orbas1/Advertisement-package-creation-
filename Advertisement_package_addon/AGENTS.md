# Agent Instructions – Advertisement Package (Laravel + Flutter)

## Overall Goal

Your goal is to create:

1. A **Laravel package** (`advertisement_laravel_package`), and
2. A **Flutter mobile addon package** (`advertisement_flutter_addon`),

that together provide the **same advertisement functionality** on both:

- The **Laravel backend / web app**, and
- The **Flutter mobile app**.

These will plug into an existing **social media style platform**, moving it towards a **LinkedIn-style professional network** with a full ads system.

> ⚠️ Important: **Do not copy any binary files** (e.g. images, fonts, compiled assets, `.exe`, `.dll`, `.so`, APKs, etc.).

---

## Source Applications

- Backend source: `sngine` / ads module


We will **copy the necessary logic and structure** from these into:

- `advertisement_laravel_package` (Laravel package)
- `advertisement_flutter_addon` (Flutter addon package)

The aim is **full feature parity** with the original ads functionality (campaigns, creatives, targeting, forecasting, etc.).

---

## Part 1 – Laravel Package (`advertisement_laravel_package`)

We are building a **proper Laravel package** (installable via Composer, likely using a `path` repository). This package will be added into the main social app and must include all files required for **full advertisement functionality**.

When extracting from the ads logic in `connect` / `wavepods`, ensure the following areas are copied/refactored into the package:

1. **Config**
   - Package config files (e.g. `config/advertisement.php`).
   - Settings for:
     - Billing models (CPC, CPA, CPM/PPI).
     - Default budgets and limits.
     - Permissions/roles (advertiser, campaign manager, admin).
     - Feature toggles (simulation on/off, forecast on/off, keyword planner, etc.).

2. **Database**
   - All required **migrations**, including tables for:
     - Advertisers / ad accounts.
     - Campaigns.
     - Ad groups (if used).
     - Ad creatives (text, banner, video, etc.).
     - Placements (feed, profile, search, podcasts, webinars, networking, gigs, jobs, etc.).
     - Targeting (gender, tags, keywords, country, location, searches).
     - Keywords and pricing (CPC, CPA, CPM/PPI).
     - Budgets, bids, and schedules (start/end times).
     - Impressions, clicks, conversions, and other metrics.
     - Forecast/simulation data (if stored).
     - Limits and checks (e.g. user daily spend limits).
   - Any **seeders** necessary for:
     - Default ad types.
     - Default placements.
     - Default targeting options.

3. **Domains**
   Organise domain logic by feature area, for example:

   - `Domain/Advertiser`
     - Advertiser account creation, billing info, spend limits.
   - `Domain/Campaign`
     - Campaign creation, management, status (active/paused/completed).
     - Budgets, schedules, and objectives.
   - `Domain/Creative`
     - Ad creatives (video ads, banner ads, text ads, search ads, recommendation/placement ads).
   - `Domain/Placement`
     - Mapping ads to:
       - Social feed/timeline
       - Profiles
       - Search results
       - Gigs, projects, freelancers
       - Jobs
       - Podcasts, webinars, networking sessions
   - `Domain/Targeting`
     - Targeting rules and segments (gender, location, tags, keywords, country, searches).
   - `Domain/Measurement`
     - Metrics and reporting (impressions, clicks, conversions, cost, CTR, CPC, CPA, CPM).
   - `Domain/Forecast`
     - Results predictions, simulation, reach planner, click/impression/cost forecaster.
   - `Domain/KeywordPlanner`
     - Keyword planner and pricing logic (CPC, CPA, CPM/PPI).

4. **Http**
   - Controllers (web + API) for:
     - Advertiser account management.
     - Campaign management.
     - Ad creative management.
     - Targeting and placements configuration.
     - Viewing metrics and reports.
     - Forecast/simulation endpoints.
   - Form requests / validation classes for all create/update actions.
   - Middleware specific to:
     - Permissions (must be advertiser/admin).
     - Spend limit checks where needed.

5. **Policies**
   - Authorization policies for:
     - Creating and managing campaigns.
     - Managing creatives.
     - Viewing and editing advertiser accounts.
     - Access to detailed metrics (e.g. only for owner or admins).

6. **Resources**
   - Blade templates for:
     - Advertiser dashboard.
     - Campaign list/detail screens.
     - Ad creation/editing wizards.
     - Targeting configuration screens.
     - Reporting/analytics views.
     - Forecast/simulation UI.

7. **Routes**
   - Web + API routes for all above features.
   - Ensure proper middleware.

8. **Services / Domain Logic**
   - Forecasting/Simulation engines.
   - Keyword planner pricing.
   - Campaign checks (budget, schedule, approvals).

9. **Testing / Docs**
   - README with installation + usage instructions (Composer install, migrations, config publish, routes, etc.).

10. **Affiliate Upgrade (Web + Mobile)**
    - Import Sngine affiliate hooks (init + payout flow) into the Laravel package.
    - Surface matching affiliate support for the Flutter addon (referrals + payout flows) so both phone and web experience stay in sync.
    - Document the upgrade expectations and endpoints.

---

## Part 2 – Flutter Addon (`advertisement_flutter_addon`)

We need a Flutter package/addon that matches the Laravel package behaviour.

Key requirements:

1. **Structure**
   - `lib/advertisement_flutter_addon.dart` as main entry point.
   - Separate directories for: models, repositories/providers, UI/screens, state management.

2. **Pages**
   - Pages for:
     - Ads dashboard.
     - Campaign list + detail.
     - Create/Edit ad creative.
     - Targeting configuration.
     - Ads analytics (metrics, reports, charts).
     - Forecasting/simulation display.
     - Keyword planner.
   - These should mirror the Laravel functionality (fields, validations, flows).

3. **Models**
   - Campaign, Creative, Placement, Targeting, Metrics/Results, Forecast results.
   - Keyword pricing: CPC, CPA, CPM/PPI.

4. **Networking**
   - Repositories/clients calling Laravel API endpoints, e.g.:
     - `createCampaign()`, `updateCampaign()`
     - `createAdCreative()`, `updateAdCreative()`
     - `fetchMetrics(campaignId, ...)`
     - `runForecast(params)`
     - `getKeywordPricing(keyword, ...)`
     - All endpoints must match the Laravel routes provided by `advertisement_laravel_package`.

5. **State**
   - State management (BLoC, Cubit, Provider, Riverpod, etc.) for:
     - Campaign listing and details.
     - Ad creative creation/editing.
     - Targeting configuration.
     - Metrics and reports.
     - Forecast/simulation results.
   - Reflect the same behaviour and flows as the original implementation.

6. **`menu.dart`**
   - Expose navigation/menu entries for the host app, e.g.:
     - “Ads”
     - “My Campaigns”
     - “Create Ad”
     - “Ads Analytics”
   - Provide a simple API (e.g. list of `MenuItem` objects) so the main app can plug these pages into its global navigation.

7. **API Connection**
   - All network calls must connect to the **corresponding Laravel advertisement package API**.
   - Ensure:
     - Consistent request/response models.
     - Proper error handling (network, validation, auth).
     - Auth failures handled by redirecting to login/refreshing tokens.
     - Reasonable offline handling (retry, simple caching if implemented).

> 🎯 Focus: The Flutter addon must provide a **complete advertiser experience** (create/manage campaigns, view results, forecast performance), implemented cleanly as a reusable Flutter package, wired to the new Laravel advertisement package.

---

## Required Functional Areas (Both Laravel & Flutter)

Both the **Laravel package** and the **Flutter addon** must support the following core advertisement functions:

### Ad Types & Placements

- Ads similar to Google/Facebook/LinkedIn ads:
  - Video ads.
  - Banner ads.
  - Text ads.
  - Search ads.
  - Recommendation ads.
  - Feed/timeline ads.
  - Profile ads.
- Specific placements across the platform:
  - Gig adverts.
  - Podcast adverts.
  - Webinar adverts.
  - Networking session adverts.
  - Freelancer adverts.
  - Jobs adverts.
  - Freelance project adverts.
  - Social media post adverts.

### Pricing Models & Billing

- Pay per click (PPC).
- Pay per conversion (CPA).
- Pay per impression (CPM/PPI).
- Keyword pricing:
  - Pricing per keyword for PPC, CPA, PPI.
- Budgets:
  - Daily budgets.
  - Lifetime budgets.
- Campaign scheduling:
  - Start/end dates and times.
  - Ad campaign timing controls.

### Targeting

- Targeting by:
  - Gender.
  - Tags and interests.
  - Keywords.
  - Country and region.
  - Location (geo targeting).
  - Searches / search history.
- Country-level targeting.
- Combination rules for targeting segments.

### Metrics, Results & Forecasting

- Ad metrics:
  - Impressions, clicks, conversions.
  - CTR, CPC, CPA, CPM.
  - Cost over time.
- Campaign results:
  - Overall performance per campaign.
  - Multi-campaign overview.
- Ads results predictions:
  - Ads simulation.
  - Reach planner.
  - Clicks/impressions forecaster.
  - Cost forecaster.

### Planning & Controls

- Keyword planner:
  - Discover and price keywords (PPC, CPA, CPM/PPI).
- Ads checks & limits:
  - Basic ad compliance checks.
  - Spend limits per account/campaign.
- Ad creation & management:
  - Ad creation wizards.
  - Edit, pause, resume, and stop campaigns/ads.
- Campaign management:
  - Single and multi-campaign handling.
  - Quick access to results and key stats.

---

By following this document, the agent should:

- Extract all necessary ads logic from `connect` / `wavepods` (backend and any mobile/client code).
- Rebuild them as:
  - A **modular Laravel advertisement package**, and
  - A **modular Flutter advertisement addon**,
- Ensuring **feature parity** across web and mobile and seamless integration into the host social/LinkedIn-style platform.
