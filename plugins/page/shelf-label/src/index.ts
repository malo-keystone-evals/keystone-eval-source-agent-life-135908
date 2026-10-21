import html from "solid-js/html"
import type { PageProps } from "@keystone/plugin"
import "./styles.css"

// A tiny Solid page plugin: renders the bound book's title as a library "shelf
// label" — uppercased, with the letter count beneath it. Deliberately small,
// but real — it reads its `books` subject reactively and ships its own scoped
// stylesheet, exercising the Solid framework path (and CSS scoping on it) end
// to end alongside the React `reading-time` plugin.
//
// Authored in Solid's no-build `html` tagged template rather than JSX: the
// plugin bundler is a pure-TypeScript SWC pass and doesn't run Solid's JSX babel
// transform, so `html` is how a Solid page plugin stays buildable here.
export default function ShelfLabel(props: PageProps) {
  const title = () => props.subject.properties.title
  const letters = () => title().replace(/\s+/g, "").length

  return html`
    <div data-plugin="shelf-label" class="shelf-label">
      <span class="shelf-label__title">${() => title().toUpperCase()}</span>
      <span class="shelf-label__count">${() => `${letters()} letters`}</span>
    </div>
  `
}
