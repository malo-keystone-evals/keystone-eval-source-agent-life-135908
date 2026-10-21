import { useState } from "react"
import type { PageProps } from "@keystone/plugin"
import "./styles.css"

// The 200 body shape declared by the `book_secret` endpoint's `returns` — the
// same shape the typed `callEndpoint` return generates into `@keystone/client`.
// `webhook_secret` is Encrypted Storage (ADR-0059): stored encrypted, persisted
// encrypted in the run trace, and only decrypted onto the wire because the
// endpoint declares the field `sensitivity: password` and its respond node sets
// `returns_sensitive_data: true`.
type BookSecret = {
  title: string
  webhook_secret: string
}

export default function BookSecret(props: PageProps) {
  const bookId = props.subject.id
  const [secret, setSecret] = useState<string | null>(null)
  const [revealed, setRevealed] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [loading, setLoading] = useState(false)

  async function reveal() {
    setLoading(true)
    setError(null)
    try {
      // Drive the anchored endpoint for THIS book: `recordId` becomes the
      // trailing URL segment (/api/endpoints/book_secret/<id>). The server
      // decrypts the secret for the response; nothing plaintext is stored.
      const res = await props.keystone.callEndpoint({
        name: "book_secret",
        method: "get",
        recordId: bookId,
      })
      const body = res.body as BookSecret
      setSecret(body.webhook_secret)
      setRevealed(true)
    } catch (e) {
      setError(e instanceof Error ? e.message : "Failed to reveal the secret.")
    } finally {
      setLoading(false)
    }
  }

  return (
    <div data-plugin="book-secret" className="book-secret">
      <h2 className="book-secret__title">Webhook secret</h2>
      <p className="book-secret__blurb">
        Stored encrypted at rest (ADR-0059). Revealing it calls a custom endpoint
        that decrypts it for this response only — the persisted run never holds
        it in plaintext.
      </p>

      {!revealed && (
        <button
          type="button"
          className="book-secret__reveal"
          onClick={reveal}
          disabled={loading}
        >
          {loading ? "Revealing…" : "Reveal secret"}
        </button>
      )}

      {error && <p className="book-secret__error">{error}</p>}

      {revealed && !error && (
        <dl className="book-secret__readout">
          <div>
            <dt>webhook_secret</dt>
            <dd>
              <code className="book-secret__value">{secret}</code>
            </dd>
          </div>
        </dl>
      )}
    </div>
  )
}
