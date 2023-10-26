const request = require('supertest');
const app = require('./index');

describe('Test API endpoints', () => {

  test('GET / should return data', async () => {
    const response = await request(app).get('/');
    expect(response.statusCode).toBe(200);
    expect(response.body).toBeDefined();
  });

  test('POST /data should save data', async () => {
    const testData = { field1: 'value1', field2: 123 };
    const response = await request(app).post('/data').send(testData);
    expect(response.statusCode).toBe(200);
    expect(response.text).toEqual('Data saved successfully');
  });

});
