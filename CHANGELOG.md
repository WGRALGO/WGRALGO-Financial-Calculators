# Changelog

## v2.0.0 — 2026-10-02

- Math now matches the fixed website calculators:
  - Loans, mortgages, refinance, simple loan, amortization, and car loans use
    APR ÷ 12 per month (U.S. lender standard) instead of daily/360 compounding.
  - Debt repayment keeps daily interest (credit-card style).
  - Annual returns, growth, and discount rates are true yearly rates converted
    to monthly steps (compound interest, renter investments, NPV discounting).
- Fixed: lease payment at signing was counted in addition to the full term
  (one payment too many); with tax-upfront, the first payment was taxed twice.
- Fixed: Rent vs Own Home NPV subtracted the renter's investment account and
  double-counted the deposit, which wrongly favored renting.
- Fixed: payoff date in Debt Repayment and Amortization was one month late.
- Fixed: on phones the table of contents was 16 px too wide, and the
  amortization table stretched the whole page sideways.
- Real app look: black launch screen with the big logo (no white box on
  Android 12+), launcher icon on black that fills round, squircle, and square
  shapes, solid app bar, a menu that jumps to each calculator, and About /
  Privacy / Credits panels. Removed the web-style banner and footer.
- Android back button: closes menus and panels, scrolls back to the top, and
  asks before exiting.
- Phones and tablets, portrait and landscape: rotates freely, smaller logo on
  landscape phones, wide tables scroll inside their box.
- A content security policy blocks all network access.
- App name under the icon is now "Financial Calculators"; new app ID
  `org.wgralgo.financialcalculators`.
- APK renamed to `WGRALGO-FinancialCalculators-v2.0.0.apk`, the same
  `WGRALGO-<AppName>-v<version>.apk` naming as every WGRALGO app.
- Version 2.0.0 (versionCode 200). Signed with a new key: uninstall v1.0.0
  before installing v2.0.0.
- Release signing can now come from `FC_*` environment variables; added
  GitHub Actions debug builds, a signed release workflow, release notes,
  `tools/validate-release.sh` checks, and `tools/build-icons.py`.
- Removed the leftover v1.0.0 checksum file from the repository root.

## v1.0.0

- First official public GitHub release.
- Rebuilt with proper release signing.
- Cleaned public APK interface.
- Removed donation/social media/promotional links from APK UI.
- Improved offline/privacy posture.
- Added GPLv3 licensing.
- Added contributor credits.
- Added privacy, security, third-party notices, and release documentation.
