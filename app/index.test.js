const request = require('supertest');
const app = require('./index');

const BASE_URL = process.env.DEPLOYED_URL || 'http://localhost:8080';

describe('API Tests', () => {
  let server;

  beforeAll(() => {
    if (!process.env.DEPLOYED_URL) {
      server = app.listen(8080); 
    }
  });

  afterAll(() => {
    if (server) {
      server.close();
    }
  });

  test('GET / should return data', async () => {
    const response = await request(BASE_URL).get('/');
    expect(response.statusCode).toBe(200);
    expect(response.body).toBeDefined();
  });

  test('POST /data should save data', async () => {
    const testData = { field1: 'value1', field2: 123 };
    const response = await request(BASE_URL).post('/data').send(testData);
    expect(response.statusCode).toBe(200);
    expect(response.text).toEqual('Data saved successfully');
  });

});
