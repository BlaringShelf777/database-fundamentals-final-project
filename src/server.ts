
import 'dotenv/config'

import { app } from './app'

try {
  const serverPort = process.env.PORT || '3000'

  app.listen(
    serverPort,
    () => console.info(`Server running on port ${serverPort}`)
  )
} catch (err) {
  console.error(err)
}
