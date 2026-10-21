import { useState } from "react"
import type { PageProps } from "@keystone/plugin"
import "./styles.css"

// A few fixed locations to demo the endpoint. In a real page these might come
// from a record, a search box, or the browser's geolocation.
const CITIES = [
  { name: "Sydney", latitude: -33.87, longitude: 151.21 },
  { name: "London", latitude: 51.51, longitude: -0.13 },
  { name: "Tokyo", latitude: 35.68, longitude: 139.69 },
]

// The 200 body shape declared by the endpoint's `returns` (and the typed
// `callEndpoint` return type generated into `@keystone/client`).
type Conditions = {
  temperature_c: number
  temperature_f: number
  wind_kph: number
  is_warm: boolean
}

export default function Weather(props: PageProps) {
  const [city, setCity] = useState(CITIES[0])
  const [conditions, setConditions] = useState<Conditions | null>(null)
  const [error, setError] = useState<string | null>(null)
  const [loading, setLoading] = useState(false)

  async function load(next: (typeof CITIES)[number]) {
    setCity(next)
    setLoading(true)
    setError(null)
    try {
      // Drive the server-side endpoint: it fetches Open-Meteo and does the
      // Celsius→Fahrenheit + warm/cool computation, returning the result. A
      // browser couldn't call Open-Meteo with the project's auth or run that
      // logic server-side — the endpoint is what makes it possible.
      const res = await props.keystone.callEndpoint({
        name: "weather",
        method: "get",
        input: { latitude: next.latitude, longitude: next.longitude },
      })
      // Declared codes resolve here; framework refusals (401/403/…) throw and
      // land in the catch below.
      setConditions(res.body as Conditions)
    } catch (e) {
      setError(e instanceof Error ? e.message : "Failed to load the weather.")
    } finally {
      setLoading(false)
    }
  }

  return (
    <div data-plugin="weather" className="weather">
      <h2 className="weather__title">Current conditions</h2>
      <div className="weather__cities">
        {CITIES.map((c) => (
          <button
            key={c.name}
            type="button"
            className={
              "weather__city" +
              (c.name === city.name ? " weather__city--active" : "")
            }
            onClick={() => load(c)}
          >
            {c.name}
          </button>
        ))}
      </div>

      {loading && <p className="weather__status">Loading…</p>}
      {error && <p className="weather__error">{error}</p>}

      {conditions && !loading && !error && (
        <dl className="weather__readout">
          <div>
            <dt>Temperature</dt>
            <dd>
              {conditions.temperature_c}°C / {conditions.temperature_f}°F
            </dd>
          </div>
          <div>
            <dt>Wind</dt>
            <dd>{conditions.wind_kph} km/h</dd>
          </div>
          <div>
            <dt>Feels</dt>
            <dd>{conditions.is_warm ? "Warm" : "Cool"}</dd>
          </div>
        </dl>
      )}
    </div>
  )
}
