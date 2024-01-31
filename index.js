import express from 'express';
import cors from 'cors';
import { info } from './utils/logger.js';
import { PORT } from './utils/config.js';
import loginRouter from './controllers/loginController.js';
import tournamentsRouter from './controllers/tournamentsController.js';
import clubsRouter from './controllers/clubsController.js';
import circuitsRouter from './controllers/circuitsController.js';
import playersRouter from './controllers/playersController.js';
import managersRouter from './controllers/managersController.js';

const app = express();

app.use(cors());
app.use(express.static('build'));
app.use(express.json());

// Route handlers
app.use('/api/login', loginRouter);
app.use('/api/tournaments', tournamentsRouter);
app.use('/api/clubs', clubsRouter);
app.use('/api/circuits', circuitsRouter);
app.use('/api/players', playersRouter);
app.use('/api/managers', managersRouter);

const server = app.listen(PORT, () => {
  info('Server listening on port', PORT);
});

app.use((req, res) => {
  res.status(404).send({ error: 'Not found' });
});

export { app, server };
