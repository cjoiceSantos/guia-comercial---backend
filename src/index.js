require('dotenv-safe').config()
const express = require('express');
const routes = require('./routes');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use('/static', express.static('/home/cjoice_s/Documentos/Projetos/Guia-comercial/backend/tmp/uploads/'))
app.use(routes);

app.listen(3333);
