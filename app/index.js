const express = require('express');
const { Pool } = require('pg');
const { BigQuery } = require('@google-cloud/bigquery');
const app = express();
const PORT = 8080;

let pool;
let bigquery;

if (process.env.NODE_ENV === 'production') {
    bigquery = new BigQuery();
} else {
    pool = new Pool({
        user: process.env.POSTGRES_USER,
        host: 'db',
        database: process.env.POSTGRES_DB,
        password: process.env.POSTGRES_PASSWORD,
        port: 5432,
    });
}

app.get('/', async (req, res) => {
    try {
        if (process.env.NODE_ENV === 'production') {
            const query = 'SELECT * FROM `latam.latam-app.latam-table` LIMIT 10';
            const [rows] = await bigquery.query({ query: query });
            res.json(rows);
        } else {
            const client = await pool.connect();
            const result = await client.query('SELECT * FROM data');
            const results = { 'results': (result) ? result.rows : null };
            res.json(results);
            client.release();
        }
    } catch (err) {
        res.status(500).send('Query database error: ' + err.message);
    }
});

app.post('/data', express.json(), async (req, res) => {
    try {
        const data = req.body;

        if (!data) {
            return res.status(400).send('No data provided');
        }

        if (process.env.NODE_ENV === 'production') {
            const datasetId = 'latam-app';
            const tableId = 'latam-table';
            const rows = [{...data}];
            
            await bigquery.dataset(datasetId).table(tableId).insert(rows);
        } else {
            const client = await pool.connect();
            await client.query('INSERT INTO data (info) VALUES ($1)', [JSON.stringify(data)]);
            client.release();
        }

        res.status(200).send('Data saved successfully');
    } catch (err) {
        res.status(500).send('Error saving data: ' + err.message);
    }
});

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});

module.exports = app;