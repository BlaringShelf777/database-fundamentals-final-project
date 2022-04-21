
import { ClientConfig } from 'pg'

export const dbSettings: ClientConfig = {
  user: process.env.DB_USER,
  host: 'localhost',
  database: process.env.DB_NAME,
  password: process.env.DB_USER_PASSWORD,
  port: 5432
}
