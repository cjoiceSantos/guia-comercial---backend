require('dotenv-safe').config()
const path = require('path');
const express = require('express');
const routes = require('./routes');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use('/static', express.static(path.resolve(__dirname, '..', 'tmp', 'uploads')));
app.use(routes);
app.listen(3333);

console.log(path.resolve(__dirname, '..', 'tmp', 'uploads'))

