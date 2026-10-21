import slugify from "slugify"
import type { Input, Output } from "@keystone/plugin"

// Turn a book title into a URL-friendly slug. A minimal Workflow Node Plugin:
// pure computation over the declared input, returning the declared output. The
// optional `record_id` is echoed straight through so the calling workflow can
// write the slug back onto the record it came from.
export default function makeSlug(input: Input): Output {
  return {
    slug: slugify(input.title, { lower: true, strict: true }),
    record_id: input.record_id,
  }
}
