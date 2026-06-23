import { config } from 'dotenv'
import { resolve } from 'path'
import { fileURLToPath } from 'url'

const __dirname = fileURLToPath(new URL('.', import.meta.url))

// Load .env from the monorepo root if present (local dev).
// In CI, env vars are injected directly — the missing file is silently ignored.
config({ path: resolve(__dirname, '../.env') })
