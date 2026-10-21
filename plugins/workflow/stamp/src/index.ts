import type { Input, Output } from "@keystone/plugin"

// Carry the Sensitive `token` through unchanged (its substance stays tainted),
// and derive a NON-secret FACT from it: `fingerprint` records only the token's
// length. Because the manifest declares `fingerprint` without `sensitivity`, it
// is untainted and may be persisted/egressed freely — taint follows substance,
// not facts (ADR-0059). (Length is a coarse fact; the accepted trade-off.)
export default function stamp(input: Input): Output {
  return {
    token: input.token,
    fingerprint: `len:${input.token.length}`,
  }
}
