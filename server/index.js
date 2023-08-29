const express = require('express');
const router = require('./routes/routes');

const app = express();
app.use(express.json());
app.use(express.raw());
app.use(express.urlencoded({ extended: true }));

app.use('/api/v1', router);
const port = 3000;
app.listen(port, () => {
    console.log(`Server listening on ${ port }`);
});