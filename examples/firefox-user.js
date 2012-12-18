// To allow access to files via recoll-webui include the following in your:
// ~/.mozilla/firefox/<profile>/user.js

user_pref("capability.policy.policynames", "localfilelinks");
user_pref("capability.policy.localfilelinks.sites", "http://localhost:8080");
user_pref("capability.policy.localfilelinks.checkloaduri.enabled", "allAccess");
