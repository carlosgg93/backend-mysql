import { createConnection } from 'mysql2/promise';

import { DB_HOST, DB_DATABASE, DB_PASSWORD, DB_PORT, DB_USER } from './utils/config';

const connection = await createConnection({
  host: DB_HOST,
  user: DB_USER,
  password: DB_PASSWORD,
  port: DB_PORT,
  database: DB_DATABASE,
});

export default connection;
