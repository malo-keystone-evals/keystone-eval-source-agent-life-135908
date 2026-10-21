import { useMemo } from "react"
import type { PageProps } from "@keystone/plugin"
import "./styles.css"

// Words an average adult reads per minute. Used to turn a book's summary
// length into a rough "time to read the blurb" estimate.
const WORDS_PER_MINUTE = 200

// The pace table below runs from a slow careful reader to a fast skimmer, in
// steps of ten. It is here to be *long*: on a record page's tab this plugin's
// container is the tab's scroll box, and a tab that never exceeds the viewport
// would never show whether the scrolling works. Forty-three rows clears a
// 900px viewport on any book, so the dress rehearsal has something to fail on
// if the scroll box goes away (#1238).
const SLOWEST_PACE = 80
const FASTEST_PACE = 500
const PACE_STEP = 10

function formatDuration(seconds: number): string {
  // Rounded once, before it is split. Rounding the remainder on its own gives
  // "1m 60s" whenever the seconds land just short of the next minute, and
  // "60s" whenever they land just short of the first one.
  const whole = Math.round(seconds)
  if (whole < 60) return `${whole}s`
  const minutes = Math.floor(whole / 60)
  const rest = whole % 60
  return rest === 0 ? `${minutes}m` : `${minutes}m ${rest}s`
}

export default function ReadingTime(props: PageProps) {
  const book = props.subject.properties

  const { words, minutes } = useMemo(() => {
    const summary = book.summary ?? ""
    const words = summary.trim() === "" ? 0 : summary.trim().split(/\s+/).length
    const minutes = Math.max(1, Math.round(words / WORDS_PER_MINUTE))
    return { words, minutes }
  }, [book.summary])

  const paces = useMemo(() => {
    const rows = []
    for (let pace = SLOWEST_PACE; pace <= FASTEST_PACE; pace += PACE_STEP) {
      rows.push({ pace, seconds: (words / pace) * 60 })
    }
    return rows
  }, [words])

  return (
    <div data-plugin="reading-time" className="reading-time">
      <h2 className="reading-time__title">{book.title}</h2>
      {words === 0 ? (
        <p className="reading-time__empty">No summary yet — nothing to read.</p>
      ) : (
        <>
          <p className="reading-time__estimate">
            {words} words · about {minutes} minute{minutes === 1 ? "" : "s"} to read
            the summary.
          </p>
          <h3 className="reading-time__subtitle">At other paces</h3>
          <p className="reading-time__note">
            The estimate above assumes {WORDS_PER_MINUTE} words a minute. Readers
            vary by a factor of six, so here is the same {words} words at every
            pace from a careful {SLOWEST_PACE} to a skimmed {FASTEST_PACE}.
          </p>
          <table className="reading-time__paces">
            <thead>
              <tr>
                <th scope="col">Words a minute</th>
                <th scope="col">Time to read</th>
              </tr>
            </thead>
            <tbody>
              {paces.map(({ pace, seconds }) => (
                <tr
                  key={pace}
                  className={
                    pace === WORDS_PER_MINUTE
                      ? "reading-time__pace--default"
                      : undefined
                  }
                >
                  <td>{pace}</td>
                  <td>{formatDuration(seconds)}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </>
      )}
    </div>
  )
}
