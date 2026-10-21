import { useEffect, useState } from "react"
import type { PageProps } from "@keystone/plugin"
import type { ReportOutcome, ReportResult } from "@keystone/client"
import "./styles.css"

// A whole-page plugin whose content is driven by URL parameters. The route
// `/reports/:year?/:quarter?` fills props.routeParams; both are optional, so we
// fall back to a default period when the page is opened straight from the nav.
const QUARTERS = ["Q1", "Q2", "Q3", "Q4"] as const

/** The quarter's first day and the next quarter's, as `date_range` bounds. */
function quarterRange(year: number, quarter: string): { from: string; to: string } {
  const start = QUARTERS.indexOf(quarter as (typeof QUARTERS)[number]) * 3
  const pad = (m: number) => String(m + 1).padStart(2, "0")
  return {
    from: `${year}-${pad(start)}-01`,
    to: start === 9 ? `${year}-12-31` : `${year}-${pad(start + 2)}-31`,
  }
}

export default function Reports(props: PageProps) {
  const params = props.routeParams
  const year = params.year ?? 2026
  const quarter = params.quarter ?? "Q3"
  const [outcome, setOutcome] = useState<ReportOutcome | null>(null)

  useEffect(() => {
    let live = true
    // Counts are grouped on the server, exactly over what this user may see —
    // never fetched as rows and tallied here.
    void props.keystone
      .report({
        reports: [
          {
            id: "loans",
            model_name: "loans",
            filters: [{ kind: "date_range", property: "created_at", ...quarterRange(year, quarter) }],
            group_by: [{ property: "status" }],
            measures: [{ fn: "count", key: "n" }],
          },
          {
            id: "genres",
            model_name: "books",
            group_by: [{ property: "genre" }],
            measures: [{ fn: "count", key: "n" }],
            sort: [{ column: "n", direction: "desc" }],
          },
        ],
      })
      .then((result) => live && setOutcome(result))
    return () => {
      live = false
    }
  }, [props.keystone, year, quarter])

  return (
    <div data-plugin="reports" className="reports">
      <h2 className="reports__title">
        Library report — {quarter} {year}
      </h2>
      <p className="reports__hint">
        Pick a quarter (the URL updates, and the plugin re-renders from its route
        params):
      </p>
      <nav className="reports__quarters">
        {QUARTERS.map((q) => (
          <a
            key={q}
            className={
              "reports__quarter" + (q === quarter ? " reports__quarter--active" : "")
            }
            href={`/ops/reports/${year}/${q}`}
          >
            {q}
          </a>
        ))}
      </nav>
      {outcome?.kind === "refused" && (
        <p className="reports__refused">The server is busy — try again shortly.</p>
      )}
      {outcome?.kind === "answered" && (
        <div className="reports__tables">
          <Breakdown title="Loans opened this quarter" result={outcome.results[0]} />
          <Breakdown title="Books by genre" result={outcome.results[1]} />
        </div>
      )}
    </div>
  )
}

/** One Report's groups as rows, or the reason it was refused. */
function Breakdown({ title, result }: { title: string; result?: ReportResult }) {
  if (!result) return null
  if (result.kind === "error") {
    return (
      <section className="reports__breakdown">
        <h3>{title}</h3>
        <p className="reports__refused">Not available: {result.error.code}</p>
      </section>
    )
  }
  const [group, count] = result.columns
  return (
    <section className="reports__breakdown">
      <h3>{title}</h3>
      {group && count && group.values.length > 0 ? (
        <table>
          <tbody>
            {group.values.map((value, i) => (
              <tr key={String(value)}>
                <td>{value === null ? "—" : (group.labels?.[String(value)] ?? String(value))}</td>
                <td>{String(count.values[i])}</td>
              </tr>
            ))}
          </tbody>
        </table>
      ) : (
        <p className="reports__hint">None.</p>
      )}
    </section>
  )
}
