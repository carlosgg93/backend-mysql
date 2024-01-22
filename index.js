import express from 'express';
import cors from 'cors';
import { info } from './utils/logger.js';
import { PORT } from './utils/config.js';
import loginRouter from './controllers/loginController.js';
import moviesRouter from './controllers/moviesController.js';

const app = express();

app.use(cors());
app.use(express.static('build'));
app.use(express.json());

// Route handlers
app.use('/api/login', loginRouter);
app.use('/api/movies', moviesRouter);

const server = app.listen(PORT, () => {
  info('Server listening on port', PORT);
});

app.use((req, res) => {
  res.status(404).send({ error: 'Not found' });
});

export { app, server };
