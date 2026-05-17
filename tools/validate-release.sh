#!/usr/bin/env bash
# Release validation for WGRALGO Financial Calculators v1.0.0
# Usage: bash tools/validate-release.sh
set -u

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

PASS=0
FAIL=0
ok()   { echo "PASS: $1"; PASS=$((PASS+1)); }
bad()  { echo "FAIL: $1"; FAIL=$((FAIL+1)); }

APK="WGRALGO_Financial_Calculators_v1.0.0.apk"
APK_SHA="$APK.sha256"

# 1. LICENSE is full GPLv3
if grep -q "GNU GENERAL PUBLIC LICENSE" LICENSE 2>/dev/null && grep -q "Version 3" LICENSE 2>/dev/null; then
  ok "LICENSE contains GNU GENERAL PUBLIC LICENSE Version 3"
else
  bad "LICENSE missing GPLv3 text"
fi

# 2. package.json says GPL-3.0-only
if [ -f package.json ]; then
  if grep -q '"license": *"GPL-3.0-only"' package.json; then
    ok "package.json license is GPL-3.0-only"
  else
    bad "package.json license is not GPL-3.0-only"
  fi
else
  ok "package.json not present (skipped)"
fi

# 3. No app-facing files say v1.0.1
HITS=$(grep -RIl --exclude-dir=node_modules --exclude-dir=.git --exclude-dir=build \
  --exclude-dir=android/build --exclude=CHANGELOG.md -e '1\.0\.1' \
  www package.json capacitor.config.json android/app/build.gradle \
  android/app/src/main/res/values/strings.xml README.md PRIVACY.md \
  2>/dev/null)
if [ -z "$HITS" ]; then
  ok "No v1.0.1 references in app-facing files"
else
  bad "v1.0.1 found in: $HITS"
fi

# 4. App-facing version references say v1.0.0
if grep -q "v1.0.0" www/index.html && grep -q "v1.0.0" README.md; then
  ok "v1.0.0 referenced in app UI and README"
else
  bad "v1.0.0 missing from app UI or README"
fi

# 5. Android versionName 1.0.0
if grep -qE 'versionName +"1\.0\.0"' android/app/build.gradle; then
  ok "Android versionName is 1.0.0"
else
  bad "Android versionName is not 1.0.0"
fi

# 6. Android versionCode 100
if grep -qE 'versionCode +100' android/app/build.gradle; then
  ok "Android versionCode is 100"
else
  bad "Android versionCode is not 100"
fi

# 7. Release not debuggable=true
if grep -qE 'debuggable +true' android/app/build.gradle; then
  # only acceptable inside debug{} block; flag if release sets it true
  if awk '/release *\{/,/\}/' android/app/build.gradle | grep -qE 'debuggable +true'; then
    bad "release buildType sets debuggable true"
  else
    ok "release buildType does not set debuggable true"
  fi
else
  ok "release buildType does not set debuggable true"
fi

# 8. Android Debug certificate not used (check built APK if tooling available)
BT=$(ls -d "$HOME"/Android/Sdk/build-tools/* 2>/dev/null | sort -V | tail -1)
if [ -n "$BT" ] && [ -f "$APK" ] && [ -x "$BT/apksigner" ]; then
  DN=$("$BT/apksigner" verify --print-certs "$APK" 2>/dev/null | grep "Signer #1 certificate DN")
  if echo "$DN" | grep -qi "Android Debug"; then
    bad "APK signed with Android Debug certificate: $DN"
  else
    ok "APK not signed with Android Debug certificate ($DN)"
  fi
else
  echo "INFO: apksigner or APK unavailable, skipping cert check"
fi

# 9. INTERNET permission not present (offline app)
if grep -q 'android.permission.INTERNET' android/app/src/main/AndroidManifest.xml; then
  if grep -q 'tools:node="remove"' android/app/src/main/AndroidManifest.xml; then
    ok "INTERNET permission only present as a removal directive"
  else
    bad "INTERNET permission declared in manifest"
  fi
else
  ok "INTERNET permission not in manifest"
fi
if [ -n "${BT:-}" ] && [ -f "$APK" ] && [ -x "$BT/aapt" ]; then
  if "$BT/aapt" dump badging "$APK" 2>/dev/null | grep -q "uses-permission:.*android.permission.INTERNET"; then
    bad "Built APK requests INTERNET permission"
  else
    ok "Built APK does not request INTERNET permission"
  fi
fi

# 10. No external CDN links in app source
if grep -RIn --include="*.html" --include="*.css" --include="*.js" \
   -e 'cdn.jsdelivr.net' -e 'https\?://[^"]*\(googleapis\|cdnjs\|unpkg\|jsdelivr\)' www 2>/dev/null | grep -q .; then
  bad "External CDN reference found in www/"
else
  ok "No external CDN references in app source"
fi

# 11. Required docs exist
MISSING=""
for f in README.md PRIVACY.md CONTRIBUTORS.md CHANGELOG.md SECURITY.md THIRD_PARTY_NOTICES.md LICENSE; do
  [ -f "$f" ] || MISSING="$MISSING $f"
done
if [ -z "$MISSING" ]; then ok "All required docs present"; else bad "Missing docs:$MISSING"; fi

# 12. Screenshots exist
if [ -d screenshots ] && [ "$(ls -1 screenshots/*.png 2>/dev/null | wc -l)" -ge 5 ]; then
  ok "Screenshots present (>=5)"
else
  bad "Screenshots missing or fewer than 5"
fi

# 13. Final APK exists
if [ -f "$APK" ]; then ok "Final APK present: $APK"; else bad "Final APK missing: $APK"; fi

# 14. SHA-256 checksum exists and matches
if [ -f "$APK_SHA" ]; then
  if sha256sum -c "$APK_SHA" >/dev/null 2>&1; then
    ok "SHA-256 checksum present and verifies"
  else
    bad "SHA-256 checksum present but does NOT verify"
  fi
else
  bad "SHA-256 checksum file missing: $APK_SHA"
fi

echo
echo "==================================="
echo "PASS: $PASS   FAIL: $FAIL"
echo "==================================="
[ "$FAIL" -eq 0 ]
