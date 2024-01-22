import {createConnection} from 'mysql2/promise';

const connection = await createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    port: 3306,
    database: 'moviesdb'
});

export default connection;