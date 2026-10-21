import type { Input, Output } from "@keystone/plugin"

// Derive a token FROM the decrypted secret. This plugin sees plaintext because
// its manifest sets `decrypts_sensitive_data: true`; the derived `token` is
// re-declared `sensitivity: password` (in plugin.yaml) so it stays Sensitive
// through the rest of the workflow (ADR-0059).
export default function enrich(input: Input): Output {
  return { token: `tok_${input.webhook_secret}` }
}
